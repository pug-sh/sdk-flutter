import 'dart:io' as io;

import 'package:connectrpc/connect.dart' as connect;
import 'package:connectrpc/io.dart' as connect_io;
import 'package:connectrpc/protocol/connect.dart' as connect_protocol;

import 'connect_proto_codec.dart';
import 'contracts.dart';
import 'errors.dart';
import 'events.dart';
import 'gen/sdk/devices/v1/devices.pb.dart' as devicespb;
import 'gen/sdk/events/v1/events.pb.dart' as eventspb;
import 'gen/sdk/profiles/v1/profiles.pb.dart' as profilespb;
import 'proto_codec.dart';
import 'push_models.dart';

const connect.Spec<eventspb.BatchCreateRequest, eventspb.BatchCreateResponse>
_batchCreateSpec =
    connect.Spec<eventspb.BatchCreateRequest, eventspb.BatchCreateResponse>(
      '/sdk.events.v1.EventsService/BatchCreate',
      connect.StreamType.unary,
      eventspb.BatchCreateRequest.new,
      eventspb.BatchCreateResponse.new,
    );

const connect.Spec<profilespb.IdentifyRequest, profilespb.IdentifyResponse>
_identifySpec =
    connect.Spec<profilespb.IdentifyRequest, profilespb.IdentifyResponse>(
      '/sdk.profiles.v1.ProfilesSDKService/Identify',
      connect.StreamType.unary,
      profilespb.IdentifyRequest.new,
      profilespb.IdentifyResponse.new,
    );

const connect.Spec<devicespb.SubscribeRequest, devicespb.SubscribeResponse>
_subscribeSpec =
    connect.Spec<devicespb.SubscribeRequest, devicespb.SubscribeResponse>(
      '/sdk.devices.v1.DevicesService/Subscribe',
      connect.StreamType.unary,
      devicespb.SubscribeRequest.new,
      devicespb.SubscribeResponse.new,
    );

class ConnectPugTransport implements PugTransport {
  ConnectPugTransport({
    required this.endpoint,
    required this.apiKey,
    this.codec = const PugProtoCodec(),
    io.HttpClient? client,
    connect.Transport? transport,
  }) : _transport =
           transport ??
           connect_protocol.Transport(
             baseUrl: endpoint,
             codec: const ConnectProtoCodec(),
             httpClient: connect_io.createHttpClient(client ?? io.HttpClient()),
           );

  final String endpoint;
  final String apiKey;
  final PugProtoCodec codec;
  final connect.Transport _transport;

  @override
  Future<void> send(Event event) => sendBatch([event]);

  @override
  Future<void> sendBatch(List<Event> events) async {
    await _unary(_batchCreateSpec, codec.toBatchCreateRequest(events));
  }

  @override
  Future<void> identify(IdentifyRequest request) async {
    await _unary(_identifySpec, codec.toIdentifyRequest(request));
  }

  @override
  Future<void> subscribeDevice(PushSubscription subscription) async {
    await _unary(_subscribeSpec, codec.toSubscribeRequest(subscription));
  }

  Future<void> _unary<I extends Object, O extends Object>(
    connect.Spec<I, O> spec,
    I input,
  ) async {
    try {
      await connect.Client(
        _transport,
      ).unary(spec, input, headers: _authHeaders());
    } catch (error, stackTrace) {
      throw _mapError(error, stackTrace);
    }
  }

  connect.Headers _authHeaders() {
    final headers = connect.Headers();
    headers['x-api-key'] = apiKey;
    return headers;
  }
}

PugTransportException mapConnectError(Object error, StackTrace stackTrace) =>
    _mapError(error, stackTrace);

bool isPermanentConnectCode(connect.Code code) => _isPermanentConnectCode(code);

PugTransportException _mapError(Object error, StackTrace stackTrace) {
  if (error is connect.ConnectException) {
    return PugTransportException(
      error.message.isEmpty ? error.toString() : error.message,
      code: error.code.name,
      permanent: _isPermanentConnectCode(error.code),
      stackTrace: stackTrace,
    );
  }
  // Connect wraps most failures in ConnectException (handled above); anything
  // else is unwrapped. Treat Dart `Error`s (programming bugs —
  // TypeError/StateError/ArgumentError) and `FormatException` (an undecodable
  // response body will not decode on retry) as permanent, so a poison batch is
  // dropped instead of retried forever. Everything else (SocketException,
  // TimeoutException, TLS, etc.) is a transient connectivity problem: roll back
  // and retry rather than drop.
  return PugTransportException(
    error.toString(),
    permanent: error is Error || error is FormatException,
    stackTrace: stackTrace,
  );
}

bool _isPermanentConnectCode(connect.Code code) {
  return switch (code) {
    connect.Code.invalidArgument ||
    connect.Code.notFound ||
    connect.Code.alreadyExists ||
    connect.Code.permissionDenied ||
    connect.Code.failedPrecondition ||
    connect.Code.unimplemented ||
    connect.Code.unauthenticated => true,
    _ => false,
  };
}
