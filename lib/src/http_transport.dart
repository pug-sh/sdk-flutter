import 'dart:io';

import 'contracts.dart';
import 'errors.dart';
import 'events.dart';
import 'proto_codec.dart';
import 'push_models.dart';

class HttpPugTransport implements PugTransport {
  HttpPugTransport({
    required this.endpoint,
    required this.apiKey,
    this.codec = const PugProtoCodec(),
    HttpClient? client,
  }) : _client = client ?? HttpClient();

  final String endpoint;
  final String apiKey;
  final PugProtoCodec codec;
  final HttpClient _client;

  @override
  Future<void> send(Event event) => sendBatch([event]);

  @override
  Future<void> sendBatch(List<Event> events) async {
    await _post(
      '/sdk.events.v1.EventsService/BatchCreate',
      codec.encodeBatchCreateRequest(events),
    );
  }

  @override
  Future<void> identify(IdentifyRequest request) {
    return _post(
      '/sdk.profiles.v1.ProfilesSDKService/Identify',
      codec.encodeIdentifyRequest(request),
    );
  }

  @override
  Future<void> subscribeDevice(PushSubscription subscription) {
    return _post(
      '/sdk.devices.v1.DevicesService/Subscribe',
      codec.encodeSubscribeRequest(subscription),
    );
  }

  Future<void> _post(String path, List<int> body) async {
    final base = Uri.parse(endpoint);
    final uri = base.replace(path: _joinPath(base.path, path));
    final request = await _client.postUrl(uri);
    request.headers.set('x-api-key', apiKey);
    request.headers.contentType = ContentType(
      'application',
      'proto',
      charset: 'utf-8',
    );
    request.headers.set('connect-protocol-version', '1');
    request.add(body);
    final response = await request.close();
    final statusCode = response.statusCode;
    await response.drain<void>();
    if (statusCode >= 200 && statusCode < 300) {
      return;
    }
    throw PugTransportException(
      'Pug request failed with HTTP $statusCode.',
      code: statusCode.toString(),
      permanent: _isPermanentHttpStatus(statusCode),
    );
  }

  String _joinPath(String basePath, String path) {
    final cleanBase = basePath.endsWith('/')
        ? basePath.substring(0, basePath.length - 1)
        : basePath;
    return '$cleanBase$path';
  }

  bool _isPermanentHttpStatus(int statusCode) {
    return statusCode == HttpStatus.badRequest ||
        statusCode == HttpStatus.unauthorized ||
        statusCode == HttpStatus.forbidden ||
        statusCode == HttpStatus.notFound ||
        statusCode == HttpStatus.conflict ||
        statusCode == HttpStatus.preconditionFailed ||
        statusCode == HttpStatus.unprocessableEntity ||
        statusCode == HttpStatus.notImplemented;
  }
}
