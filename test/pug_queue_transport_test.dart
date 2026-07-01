import 'package:connectrpc/connect.dart' as connect;
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';
import 'package:pug_sdk/src/connect_transport.dart';
import 'package:pug_sdk/src/event_queue_storage.dart';

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
    'connect transport injects api key and maps permanent connect errors',
    () async {
      final baseTransport =
          FakeConnectTransport()
            ..unaryError = connect.ConnectException(
              connect.Code.invalidArgument,
              'bad request payload',
            );
      final transport = ConnectPugTransport(
        endpoint: 'http://example.com',
        apiKey: 'key',
        transport: baseTransport,
      );

      await expectLater(
        transport.send(fakeEvent('one')),
        throwsA(
          isA<PugTransportException>()
              .having((error) => error.code, 'code', 'invalid_argument')
              .having((error) => error.isPermanent, 'isPermanent', isTrue),
        ),
      );
      expect(baseTransport.lastHeaders?['x-api-key'], 'key');
      expect(
        baseTransport.lastProcedure,
        '/sdk.events.v1.EventsService/BatchCreate',
      );
    },
  );

  test('connect transport maps transient connect errors', () async {
    await expectLater(
      Future<void>.sync(
        () =>
            throw mapConnectError(
              connect.ConnectException(connect.Code.unavailable, 'retry later'),
              StackTrace.empty,
            ),
      ),
      throwsA(
        isA<PugTransportException>()
            .having((error) => error.code, 'code', 'unavailable')
            .having((error) => error.isPermanent, 'isPermanent', isFalse),
      ),
    );
  });

  test('connect transport maps unknown (non-Connect) errors as transient', () {
    final mapped = mapConnectError(Exception('offline'), StackTrace.empty);
    expect(mapped.isPermanent, isFalse);
  });

  test('connect transport maps Dart Errors (encode bugs) as permanent', () {
    final mapped = mapConnectError(StateError('bad encode'), StackTrace.empty);
    expect(mapped.isPermanent, isTrue);
  });

  test('connect transport maps undecodable responses as permanent', () {
    final mapped = mapConnectError(
      const FormatException('bad response body'),
      StackTrace.empty,
    );
    expect(mapped.isPermanent, isTrue);
  });
}
