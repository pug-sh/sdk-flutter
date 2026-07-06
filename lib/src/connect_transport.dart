import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:protobuf/protobuf.dart';

import 'contracts.dart';
import 'errors.dart';
import 'events.dart';
import 'proto_codec.dart';
import 'push_models.dart';

/// Connect RPC procedure paths for the Pug SDK services.
const String _batchCreateProcedure = '/sdk.events.v1.EventsService/BatchCreate';
const String _identifyProcedure =
    '/sdk.profiles.v1.ProfilesSDKService/Identify';
const String _subscribeProcedure = '/sdk.devices.v1.DevicesService/Subscribe';

/// Connect error codes that will never succeed on retry, so a batch that hits
/// one is dropped instead of rolled back. Wire names (snake_case) per the
/// Connect protocol; everything else (`unavailable`, `internal`, `unknown`,
/// `resource_exhausted`, ...) is treated as transient and retried.
///
/// This mirrors the web SDK's `PERMANENT_GRPC_CODES` (`../sdk-web/src/batch.ts`):
/// InvalidArgument, NotFound, AlreadyExists, PermissionDenied,
/// FailedPrecondition, Unimplemented, Unauthenticated. A bodyless non-2xx that
/// `_codeFromHttpStatus` maps to `internal`/`unknown` is therefore retried, not
/// dropped — intentional and matching the web SDK, not a gap.
const Set<String> _permanentConnectCodes = <String>{
  'invalid_argument',
  'not_found',
  'already_exists',
  'permission_denied',
  'failed_precondition',
  'unimplemented',
  'unauthenticated',
};

/// A Connect RPC error surfaced by the server: a non-200 response carrying a
/// Connect error [code] (and optional [message]).
class ConnectException implements Exception {
  const ConnectException(this.code, [this.message = ''])
    : assert(code != '', 'Connect wire code must not be empty');

  /// Connect wire code, e.g. `invalid_argument`.
  final String code;

  /// Human-readable error detail from the server, if any.
  final String message;

  @override
  String toString() =>
      'ConnectException($code${message.isEmpty ? '' : ': $message'})';
}

/// [PugTransport] that speaks the Connect unary protocol over HTTP with binary
/// protobuf payloads. It sends the `x-api-key` auth header and
/// `connect-protocol-version: 1` per the Connect spec. The default endpoint is
/// `https://api.pugs.dev`; override it via `PugOptions.endpoint`.
///
/// Only unary RPCs are used, so this is a deliberately small Connect client
/// rather than a full implementation. Successful (HTTP 200) response bodies are
/// acknowledgements the SDK never reads, so they are not decoded. Non-200
/// responses are mapped to a [PugTransportException] whose `permanent` flag
/// decides whether the batch is dropped or retried.
class ConnectPugTransport implements PugTransport {
  ConnectPugTransport({
    required this.endpoint,
    required this.apiKey,
    this.codec = const PugProtoCodec(),
    this.timeout = const Duration(seconds: 30),
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client(),
       _ownsClient = httpClient == null;

  final String endpoint;
  final String apiKey;
  final PugProtoCodec codec;

  /// Per-request deadline. A stalled request fails with a transient
  /// `TimeoutException` (rolled back and retried) rather than hanging the flush
  /// loop indefinitely.
  final Duration timeout;

  final http.Client _httpClient;
  final bool _ownsClient;

  @override
  Future<void> send(Event event) => sendBatch([event]);

  @override
  Future<void> sendBatch(List<Event> events) =>
      _unary(_batchCreateProcedure, codec.toBatchCreateRequest(events));

  @override
  Future<void> identify(IdentifyRequest request) =>
      _unary(_identifyProcedure, codec.toIdentifyRequest(request));

  @override
  Future<void> subscribeDevice(PushSubscription subscription) =>
      _unary(_subscribeProcedure, codec.toSubscribeRequest(subscription));

  /// Closes the underlying [http.Client], but only if this transport created it
  /// (no client was injected). A no-op for an injected client, whose lifecycle
  /// the caller owns. Safe to call more than once.
  void close() {
    if (_ownsClient) {
      _httpClient.close();
    }
  }

  Future<void> _unary(String procedure, GeneratedMessage request) async {
    try {
      final response = await _httpClient
          .post(
            _procedureUri(procedure),
            headers: _headers(),
            body: request.writeToBuffer(),
          )
          .timeout(timeout);
      if (response.statusCode != 200) {
        throw _connectException(response);
      }
    } catch (error, stackTrace) {
      throw mapConnectError(error, stackTrace);
    }
  }

  Uri _procedureUri(String procedure) {
    final base =
        endpoint.endsWith('/')
            ? endpoint.substring(0, endpoint.length - 1)
            : endpoint;
    return Uri.parse('$base$procedure');
  }

  Map<String, String> _headers() => <String, String>{
    'content-type': 'application/proto',
    'connect-protocol-version': '1',
    'x-api-key': apiKey,
  };
}

/// Maps an error thrown while sending into a [PugTransportException],
/// classifying it as permanent (drop the batch) or transient (roll back and
/// retry). Exposed for tests.
PugTransportException mapConnectError(Object error, StackTrace stackTrace) {
  if (error is ConnectException) {
    return PugTransportException(
      error.message.isEmpty ? error.toString() : error.message,
      code: error.code,
      permanent: isPermanentConnectCode(error.code),
      stackTrace: stackTrace,
    );
  }
  // Anything else is unwrapped. Dart `Error`s (programming bugs like a proto
  // encode failure, or a malformed `endpoint` that fails `Uri.parse`) and
  // `FormatException` are permanent, so a poison batch is dropped instead of
  // retried forever. Everything else (`SocketException`, `http.ClientException`,
  // `TimeoutException`, TLS) is a transient connectivity problem: roll back and
  // retry.
  return PugTransportException(
    error.toString(),
    permanent: error is Error || error is FormatException,
    stackTrace: stackTrace,
  );
}

/// Whether [code] (a Connect wire code) is permanent and should drop the batch.
bool isPermanentConnectCode(String code) =>
    _permanentConnectCodes.contains(code);

/// Builds a [ConnectException] from a non-200 Connect response. Prefers the
/// `code`/`message` in the JSON error body; falls back to mapping the HTTP
/// status when the body is missing or is not Connect-shaped JSON.
ConnectException _connectException(http.Response response) {
  var code = _codeFromHttpStatus(response.statusCode);
  var message = '';
  final body = utf8.decode(response.bodyBytes, allowMalformed: true).trim();
  if (body.isNotEmpty) {
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map) {
        if (decoded['code'] case final String c when c.isNotEmpty) {
          code = c;
        }
        if (decoded['message'] case final String m) {
          message = m;
        }
      }
    } catch (_) {
      // Not Connect JSON; fall through to keep the raw body as the message.
    }
    // Preserve the server/proxy explanation (rate-limit note, WAF page, ...) so
    // a stuck batch is diagnosable in logs instead of surfacing a bare code.
    if (message.isEmpty) {
      message = body.length > 512 ? '${body.substring(0, 512)}…' : body;
    }
  }
  return ConnectException(code, message);
}

/// Connect protocol mapping from HTTP status to error code, used when an error
/// response carries no Connect JSON body. This matches the normative "HTTP to
/// Error Code" table in the Connect spec and connect-go's reference
/// `httpToCode`, so e.g. `400 -> internal` (not `invalid_argument`) and
/// `404 -> unimplemented` (not `not_found`) are intentional, not bugs:
/// - https://connectrpc.com/docs/protocol/#http-to-error-code
/// - https://github.com/connectrpc/connect-go/blob/main/protocol_connect.go
String _codeFromHttpStatus(int status) => switch (status) {
  400 => 'internal',
  401 => 'unauthenticated',
  403 => 'permission_denied',
  404 => 'unimplemented',
  429 || 502 || 503 || 504 => 'unavailable',
  _ => 'unknown',
};
