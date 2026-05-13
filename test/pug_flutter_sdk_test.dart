import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';
import 'package:pug_flutter_sdk/src/event_queue_storage.dart';
import 'package:pug_flutter_sdk/src/runtime.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('init validates required values and repeated init is ignored', () {
    expect(
      () => Pug.init('', const PugOptions(apiKey: 'key')),
      throwsA(isA<PugException>()),
    );

    final transport = FakeTransport();
    final logger = CapturingLogger();
    Pug.init(
      'project',
      PugOptions(
        apiKey: 'key',
        transport: transport,
        logger: logger,
        autoTrack: false,
      ),
    );
    Pug.init(
      'project',
      PugOptions(
        apiKey: 'key',
        transport: FakeTransport(),
        logger: logger,
        autoTrack: false,
      ),
    );

    expect(logger.warnings, contains(contains('already initialized')));
    Pug.destroy();
  });

  test('track never throws and maps properties', () {
    final transport = FakeTransport();
    final client = testClient(transport: transport);

    expect(
      () => client.track('purchase', props: {'bad': double.nan}),
      returnsNormally,
    );
    client.track(
      'purchase',
      props: {
        'string': 'hello',
        'bool': true,
        'int': 7,
        'double': 1.5,
        'date': DateTime.fromMillisecondsSinceEpoch(10, isUtc: true),
        'json': {'a': 1},
        'none': null,
      },
    );

    final event = client.queue.peekUnlocked().last;
    expect(event.customProperties['string']?.kind, 'stringValue');
    expect(event.customProperties['bool']?.kind, 'boolValue');
    expect(event.customProperties['int']?.kind, 'intValue');
    expect(event.customProperties['double']?.kind, 'doubleValue');
    expect(event.customProperties['date']?.kind, 'timestampValue');
    expect(event.customProperties['json']?.kind, 'stringValue');
    expect(event.customProperties.containsKey('none'), isFalse);
  });

  test('string properties are truncated to 1024 UTF-8 bytes', () {
    final mapped = const PropertyMapper().mapProperties({'long': 'a' * 2000});
    final value = mapped['long']!.value as String;
    expect(value.length, 1024);
  });

  test(
    'session expires, rotate preserves device, reset rotates device and clears profile',
    () {
      final clock = FakeClock(1000);
      final ids = SequenceIds();
      final storage = MemoryPugStorage();
      final client = testClient(clock: clock, ids: ids, storage: storage);

      client.track('first');
      final first = client.queue.peekUnlocked().last;

      clock.value = const Duration(minutes: 31).inMilliseconds + 1000;
      client.track('second');
      final second = client.queue.peekUnlocked().last;
      expect(second.sessionId, isNot(first.sessionId));

      final beforeRotateDevice = readSession(storage)['deviceId'];
      client.rotate();
      final afterRotate = readSession(storage);
      expect(afterRotate['deviceId'], beforeRotateDevice);

      client.identify('user-1');
      client.reset();
      final afterReset = readSession(storage);
      expect(afterReset['deviceId'], isNot(beforeRotateDevice));
      expect(storage.getString('__pug_project_external_id__'), isNull);
    },
  );

  test(
    'identify first call includes anonymous id and later calls omit it',
    () async {
      final transport = FakeTransport();
      final client = testClient(transport: transport);

      await client.identify('user-1', traits: {'plan': 'pro'});
      await client.identify('user-2');

      expect(transport.identifies.first.anonymousId, startsWith('anon-'));
      expect(transport.identifies.first.traits['plan']?.value, 'pro');
      expect(transport.identifies.last.anonymousId, isNull);
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
    expect(queue.peekUnlocked().single.kind, 'two');

    queue.rollback();
    expect(queue.peekUnlocked().map((event) => event.kind), ['one', 'two']);

    queue.lock(1);
    queue.commit();
    expect(queue.peekUnlocked().single.kind, 'two');
  });

  test(
    'transient transport errors rollback and permanent errors drop',
    () async {
      final transient = FakeTransport()
        ..batchError = const PugTransportException('retry', permanent: false);
      final transientClient = testClient(transport: transient);
      transientClient.track('one');
      await transientClient.flush();
      expect(transientClient.queue.peekUnlocked().single.kind, 'one');

      final permanent = FakeTransport()
        ..batchError = const PugTransportException('drop', permanent: true);
      final permanentClient = testClient(transport: permanent);
      permanentClient.track('one');
      await permanentClient.flush();
      expect(permanentClient.queue.peekUnlocked(), isEmpty);
    },
  );

  test(
    'push provider registration uses fake provider and current identity',
    () async {
      final transport = FakeTransport();
      final client = testClient(transport: transport);
      await client.identify('user-1');
      await client.subscribePush(
        FakePushProvider(),
        options: const PushSubscribeOptions(properties: {'channel': 'beta'}),
      );

      final subscription = transport.subscriptions.single;
      expect(subscription.provider, 'fake');
      expect(subscription.platform, 'android');
      expect(subscription.token, 'token-1');
      expect(subscription.profileExternalId, 'user-1');
      expect(subscription.properties['pushProvider'], 'fake');
    },
  );

  test(
    'notification payload is sanitized and clicked event gets campaign fallback',
    () async {
      final transport = FakeTransport();
      final client = testClient(transport: transport);
      client.trackNotificationOpened({
        'nested': {'drop': true},
        'ok': 'yes',
        'number': 3,
      });
      await Future<void>.delayed(Duration.zero);

      final event = transport.sent.single;
      expect(event.kind, 'notification_clicked');
      expect(event.customProperties['ok']?.value, 'yes');
      expect(event.customProperties['number']?.value, 3);
      expect(event.customProperties.containsKey('nested'), isFalse);
      expect(event.customProperties['campaignId']?.value, '(unknown)');
    },
  );
}

PugClient testClient({
  FakeTransport? transport,
  FakeClock? clock,
  SequenceIds? ids,
  MemoryPugStorage? storage,
}) {
  final client = PugClient(
    projectId: 'project',
    options: PugOptions(
      apiKey: 'key',
      transport: transport ?? FakeTransport(),
      storage: storage ?? MemoryPugStorage(),
      autoTrack: false,
      batch: const BatchConfig(maxWaitMs: 60000),
    ),
    clock: clock ?? FakeClock(1000),
    idGenerator: ids ?? SequenceIds(),
  );
  client.start();
  addTearDown(client.destroy);
  return client;
}

Map<String, Object?> readSession(MemoryPugStorage storage) {
  final raw = storage.getString('__pug_project_session__')!;
  final decoded = jsonDecode(raw);
  if (decoded is! Map<Object?, Object?>) {
    return const {};
  }
  final typed = <String, Object?>{};
  for (final entry in decoded.entries) {
    final key = entry.key;
    if (key is String) {
      typed[key] = entry.value;
    }
  }
  return typed;
}

Event fakeEvent(String kind) {
  return Event(
    eventId: 'event-$kind',
    projectId: 'project',
    kind: kind,
    sessionId: 'session',
    distinctId: 'anon',
    occurTime: 1,
    customProperties: const {},
    autoProperties: const {},
  );
}

class FakeTransport implements PugTransport {
  final List<Event> sent = <Event>[];
  final List<List<Event>> batches = <List<Event>>[];
  final List<IdentifyRequest> identifies = <IdentifyRequest>[];
  final List<PushSubscription> subscriptions = <PushSubscription>[];
  PugTransportException? batchError;

  @override
  Future<void> send(Event event) async {
    sent.add(event);
  }

  @override
  Future<void> sendBatch(List<Event> events) async {
    if (batchError != null) {
      throw batchError!;
    }
    batches.add(events);
  }

  @override
  Future<void> identify(IdentifyRequest request) async {
    identifies.add(request);
  }

  @override
  Future<void> subscribeDevice(PushSubscription subscription) async {
    subscriptions.add(subscription);
  }
}

class FakeClock implements PugClock {
  FakeClock(this.value);

  int value;

  @override
  int nowMillis() => value;
}

class SequenceIds implements PugIdGenerator {
  int value = 0;

  @override
  String nextId() {
    value += 1;
    return 'id-$value';
  }
}

class CapturingLogger implements PugLogger {
  final List<String> warnings = <String>[];

  @override
  void debug(String message) {}

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {}

  @override
  void warn(String message) {
    warnings.add(message);
  }
}

class FakePushProvider implements PushProvider {
  @override
  String get platform => 'android';

  @override
  String get provider => 'fake';

  @override
  Future<void> deleteToken() async {}

  @override
  Future<String> getToken() async => 'token-1';

  @override
  Map<Object?, Object?> notificationData(Object source) => const {};
}
