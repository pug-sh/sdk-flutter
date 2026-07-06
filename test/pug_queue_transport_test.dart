import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:pug_flutter/pug_flutter.dart';
import 'package:pug_flutter/src/connect_transport.dart';
import 'package:pug_flutter/src/event_queue_storage.dart';

import 'test_support.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('device id is stable across session rotation and changes on reset', () {
    final clock = FakeClock(1000);
    final ids = SequenceIds();
    final storage = MemoryPugStorage();
    final client = testClient(clock: clock, ids: ids, storage: storage);

    client.track('first');
    final first = client.queue.peekUnlocked().last;
    final firstDevice = readDeviceId(storage);
    expect(readSession(storage)['deviceId'], firstDevice);

    clock.value = const Duration(minutes: 31).inMilliseconds + 1000;
    client.track('second');
    final second = client.queue.peekUnlocked().last;
    expect(second.sessionId, isNot(first.sessionId));
    expect(readDeviceId(storage), firstDevice);
    expect(readSession(storage)['deviceId'], firstDevice);

    client.rotate();
    final afterRotate = readSession(storage);
    expect(afterRotate['deviceId'], firstDevice);
    expect(readDeviceId(storage), firstDevice);

    client.identify('user-1');
    client.reset();
    final afterReset = readSession(storage);
    final resetDevice = readDeviceId(storage);
    expect(resetDevice, isNot(firstDevice));
    expect(afterReset['deviceId'], resetDevice);
    expect(storage.getString('__pug_project_external_id__'), isNull);
  });

  test(
    'identify first call includes anonymous id and device id and later calls omit both',
    () async {
      final transport = FakeTransport();
      final client = testClient(transport: transport);

      await client.identify('user-1', traits: {'plan': 'pro'});
      await client.identify('user-2');

      expect(transport.identifies.first.anonymousId, startsWith('anon-'));
      expect(transport.identifies.first.deviceId, isNotNull);
      expect(transport.identifies.first.deviceId, isNotEmpty);
      expect(transport.identifies.first.traits['plan']?.value, 'pro');
      expect(transport.identifies.last.anonymousId, isNull);
      expect(transport.identifies.last.deviceId, isNull);
    },
  );

  test('queue lock commit and rollback preserve in-flight batches', () {
    final queue = PugEventQueue(
      key: 'queue',
      storage: MemoryPugStorage(),
      logger: const NoopPugLogger(),
      maxQueueSize: 10,
    );
    queue.push(fakeEvent('one'));
    queue.push(fakeEvent('two'));

    final locked = queue.lock(1);
    expect(locked.single.kind, 'one');
    expect(queue.size, 1);
    expect(queue.peekUnlocked().single.kind, 'two');
    expect(queue.lock(1), isEmpty);

    queue.rollback();
    expect(queue.size, 2);
    expect(queue.peekUnlocked().map((event) => event.kind), ['one', 'two']);

    queue.lock(1);
    queue.commit();
    expect(queue.peekUnlocked().single.kind, 'two');
  });

  test('queue drops new events when full and all events are locked', () {
    final logger = CapturingLogger();
    final queue = PugEventQueue(
      key: 'queue',
      storage: MemoryPugStorage(),
      logger: logger,
      maxQueueSize: 1,
    );
    queue.push(fakeEvent('one'));
    expect(queue.lock(1).single.kind, 'one');

    queue.push(fakeEvent('two'));
    expect(queue.peekUnlocked(), isEmpty);
    expect(logger.warnings, contains(contains('full during flush')));
  });

  test(
    'transient transport errors rollback and permanent errors drop',
    () async {
      final transient =
          FakeTransport()
            ..batchError = const PugTransportException(
              'retry',
              permanent: false,
            );
      final transientClient = testClient(transport: transient);
      transientClient.track('one');
      await transientClient.flush();
      expect(transientClient.queue.peekUnlocked().single.kind, 'one');

      final permanent =
          FakeTransport()
            ..batchError = const PugTransportException('drop', permanent: true);
      final permanentClient = testClient(transport: permanent);
      permanentClient.track('one');
      await permanentClient.flush();
      expect(permanentClient.queue.peekUnlocked(), isEmpty);
    },
  );

  test(
    'unexpected transport errors drop queued and immediate events without retry',
    () async {
      final queuedTransport =
          FakeTransport()..batchFailure = StateError('poison batch');
      final queuedClient = testClient(transport: queuedTransport);
      queuedClient.track('one');
      await queuedClient.flush();
      expect(queuedClient.queue.peekUnlocked(), isEmpty);

      final immediateTransport =
          FakeTransport()..sendFailure = StateError('poison immediate');
      final immediateClient = testClient(transport: immediateTransport);
      immediateClient.track(
        'one',
        options: const TrackOptions(immediate: true),
      );
      await Future<void>.delayed(Duration.zero);
      expect(immediateClient.queue.peekUnlocked(), isEmpty);
    },
  );

  test(
    'connect transport posts proto with api key and maps permanent errors',
    () async {
      http.Request? captured;
      final httpClient = MockClient((request) async {
        captured = request;
        return http.Response(
          '{"code":"invalid_argument","message":"bad request payload"}',
          400,
          headers: const {'content-type': 'application/json'},
        );
      });
      final transport = ConnectPugTransport(
        endpoint: 'http://example.com',
        apiKey: 'key',
        httpClient: httpClient,
      );

      await expectLater(
        transport.send(fakeEvent('one')),
        throwsA(
          isA<PugTransportException>()
              .having((error) => error.code, 'code', 'invalid_argument')
              .having((error) => error.isPermanent, 'isPermanent', isTrue),
        ),
      );
      expect(captured?.method, 'POST');
      expect(captured?.headers['x-api-key'], 'key');
      expect(captured?.headers['connect-protocol-version'], '1');
      expect(captured?.headers['content-type'], contains('application/proto'));
      expect(
        captured?.url.toString(),
        'http://example.com/sdk.events.v1.EventsService/BatchCreate',
      );
      expect(captured?.bodyBytes, isNotEmpty);
    },
  );

  test('connect transport completes normally on a 200 response', () async {
    final httpClient = MockClient((request) async => http.Response('', 200));
    final transport = ConnectPugTransport(
      endpoint: 'https://api.pugs.dev',
      apiKey: 'key',
      httpClient: httpClient,
    );

    await expectLater(transport.send(fakeEvent('one')), completes);
  });

  test('connect transport maps a transient error response for retry', () async {
    final httpClient = MockClient(
      (request) async => http.Response(
        '{"code":"unavailable","message":"retry later"}',
        503,
        headers: const {'content-type': 'application/json'},
      ),
    );
    final transport = ConnectPugTransport(
      endpoint: 'http://example.com',
      apiKey: 'key',
      httpClient: httpClient,
    );

    await expectLater(
      transport.send(fakeEvent('one')),
      throwsA(
        isA<PugTransportException>()
            .having((error) => error.code, 'code', 'unavailable')
            .having((error) => error.isPermanent, 'isPermanent', isFalse),
      ),
    );
  });

  test(
    'connect transport falls back to HTTP status for non-JSON error bodies',
    () async {
      final httpClient = MockClient(
        (request) async => http.Response('gateway timeout', 504),
      );
      final transport = ConnectPugTransport(
        endpoint: 'http://example.com',
        apiKey: 'key',
        httpClient: httpClient,
      );

      await expectLater(
        transport.send(fakeEvent('one')),
        throwsA(
          isA<PugTransportException>()
              .having((error) => error.code, 'code', 'unavailable')
              .having((error) => error.isPermanent, 'isPermanent', isFalse),
        ),
      );
    },
  );

  test('connect transport maps a network failure as transient', () async {
    final httpClient = MockClient(
      (request) async => throw http.ClientException('offline'),
    );
    final transport = ConnectPugTransport(
      endpoint: 'http://example.com',
      apiKey: 'key',
      httpClient: httpClient,
    );

    await expectLater(
      transport.send(fakeEvent('one')),
      throwsA(
        isA<PugTransportException>().having(
          (error) => error.isPermanent,
          'isPermanent',
          isFalse,
        ),
      ),
    );
  });

  test('mapConnectError maps a Connect error by code', () {
    final mapped = mapConnectError(
      const ConnectException('unavailable', 'retry later'),
      StackTrace.empty,
    );
    expect(mapped.code, 'unavailable');
    expect(mapped.isPermanent, isFalse);
  });

  test('mapConnectError maps unknown (non-Connect) errors as transient', () {
    final mapped = mapConnectError(Exception('offline'), StackTrace.empty);
    expect(mapped.isPermanent, isFalse);
  });

  test('mapConnectError maps Dart Errors (encode bugs) as permanent', () {
    final mapped = mapConnectError(StateError('bad encode'), StackTrace.empty);
    expect(mapped.isPermanent, isTrue);
  });

  test('mapConnectError maps undecodable responses as permanent', () {
    final mapped = mapConnectError(
      const FormatException('bad response body'),
      StackTrace.empty,
    );
    expect(mapped.isPermanent, isTrue);
  });

  test('isPermanentConnectCode classifies terminal codes', () {
    expect(isPermanentConnectCode('invalid_argument'), isTrue);
    expect(isPermanentConnectCode('unauthenticated'), isTrue);
    expect(isPermanentConnectCode('unavailable'), isFalse);
    expect(isPermanentConnectCode('internal'), isFalse);
  });

  test(
    'connect transport maps bodyless HTTP statuses to Connect codes',
    () async {
      const cases = <int, (String, bool)>{
        400: ('internal', false),
        401: ('unauthenticated', true),
        403: ('permission_denied', true),
        404: ('unimplemented', true),
        429: ('unavailable', false),
        500: ('unknown', false),
        502: ('unavailable', false),
        503: ('unavailable', false),
        504: ('unavailable', false),
      };
      for (final entry in cases.entries) {
        final (expectedCode, expectedPermanent) = entry.value;
        final transport = ConnectPugTransport(
          endpoint: 'http://example.com',
          apiKey: 'key',
          httpClient: MockClient((_) async => http.Response('', entry.key)),
        );
        await expectLater(
          transport.send(fakeEvent('one')),
          throwsA(
            isA<PugTransportException>()
                .having((e) => e.code, 'code', expectedCode)
                .having((e) => e.isPermanent, 'isPermanent', expectedPermanent),
          ),
          reason: 'HTTP ${entry.key}',
        );
      }
    },
  );

  test(
    'connect transport keeps a non-JSON error body as the message',
    () async {
      final transport = ConnectPugTransport(
        endpoint: 'http://example.com',
        apiKey: 'key',
        httpClient: MockClient(
          (_) async => http.Response('Request Entity Too Large', 413),
        ),
      );
      await expectLater(
        transport.send(fakeEvent('one')),
        throwsA(
          isA<PugTransportException>()
              .having((e) => e.code, 'code', 'unknown')
              .having((e) => e.isPermanent, 'isPermanent', isFalse)
              .having(
                (e) => e.message,
                'message',
                contains('Request Entity Too Large'),
              ),
        ),
      );
    },
  );

  test(
    'connect transport posts identify and subscribe to their procedures',
    () async {
      final captured = <String>[];
      http.Client capturing() => MockClient((request) async {
        captured.add(request.url.path);
        return http.Response('', 200);
      });

      await ConnectPugTransport(
        endpoint: 'http://example.com',
        apiKey: 'key',
        httpClient: capturing(),
      ).identify(
        const IdentifyRequest(
          projectId: 'project',
          externalId: 'user-1',
          traits: {},
        ),
      );
      await ConnectPugTransport(
        endpoint: 'http://example.com',
        apiKey: 'key',
        httpClient: capturing(),
      ).subscribeDevice(
        const PushSubscription(
          provider: 'fake',
          platform: 'android',
          token: 'token-1',
          deviceId: 'device-1',
        ),
      );

      expect(captured, [
        '/sdk.profiles.v1.ProfilesSDKService/Identify',
        '/sdk.devices.v1.DevicesService/Subscribe',
      ]);
    },
  );

  test('connect transport normalizes a trailing-slash endpoint', () async {
    String? capturedUrl;
    final transport = ConnectPugTransport(
      endpoint: 'http://example.com/',
      apiKey: 'key',
      httpClient: MockClient((request) async {
        capturedUrl = request.url.toString();
        return http.Response('', 200);
      }),
    );
    await transport.send(fakeEvent('one'));
    expect(
      capturedUrl,
      'http://example.com/sdk.events.v1.EventsService/BatchCreate',
    );
  });

  test('connect transport times out a hung request as transient', () async {
    final gate = Completer<http.Response>();
    final transport = ConnectPugTransport(
      endpoint: 'http://example.com',
      apiKey: 'key',
      timeout: const Duration(milliseconds: 20),
      httpClient: MockClient((_) => gate.future),
    );
    await expectLater(
      transport.send(fakeEvent('one')),
      throwsA(
        isA<PugTransportException>().having(
          (e) => e.isPermanent,
          'isPermanent',
          isFalse,
        ),
      ),
    );
    gate.complete(http.Response('', 200));
  });
}
