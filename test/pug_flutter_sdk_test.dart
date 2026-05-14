import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter_sdk/pug_flutter_fcm.dart';
import 'package:pug_flutter_sdk/src/event_queue_storage.dart';
import 'package:pug_flutter_sdk/src/runtime.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('init validates required values and repeated init is ignored', () async {
    await expectLater(
      Pug.init('', const PugOptions(apiKey: 'key')),
      throwsA(isA<PugException>()),
    );

    final transport = FakeTransport();
    final logger = CapturingLogger();
    await Pug.init(
      'project',
      PugOptions(
        apiKey: 'key',
        transport: transport,
        storage: MemoryPugStorage(),
        logger: logger,
        autoTrack: false,
      ),
    );
    await Pug.init(
      'project',
      PugOptions(
        apiKey: 'key',
        transport: FakeTransport(),
        storage: MemoryPugStorage(),
        logger: logger,
        autoTrack: false,
      ),
    );

    expect(logger.warnings, contains(contains('already initialized')));
    Pug.destroy();
  });

  test('init uses shared preferences storage by default', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});

    await Pug.init(
      'project',
      PugOptions(
        apiKey: 'key',
        transport: FakeTransport(),
        autoTrack: false,
        batch: const BatchConfig(maxWaitMs: 60000),
      ),
    );
    Pug.track(PugEventNames.signup);

    final preferences = await SharedPreferences.getInstance();
    expect(preferences.getString('__pug_project_queue__'), contains('signup'));
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

  test('auto property provider contributes mobile metadata', () {
    final client = testClient(
      autoPropertyProvider: const PugStaticAutoPropertyProvider({
        r'$appVersion': '1.2.3',
        r'$appBuild': '45',
        r'$deviceManufacturer': 'Acme',
        r'$deviceModel': 'Phone',
        r'$screenWidth': 390,
        r'$screenHeight': 844,
        r'$networkType': 'wifi',
      }),
    );
    client.track('signup');

    final autoProperties = client.queue.peekUnlocked().single.autoProperties;
    expect(autoProperties[r'$projectId']?.value, 'project');
    expect(autoProperties[r'$appVersion']?.value, '1.2.3');
    expect(autoProperties[r'$appBuild']?.value, '45');
    expect(autoProperties[r'$deviceManufacturer']?.value, 'Acme');
    expect(autoProperties[r'$deviceModel']?.value, 'Phone');
    expect(autoProperties[r'$screenWidth']?.value, 390);
    expect(autoProperties[r'$screenHeight']?.value, 844);
    expect(autoProperties[r'$networkType']?.value, 'wifi');
  });

  test('well-known events validate known props and preserve schema types', () {
    final logger = CapturingLogger();
    final client = testClient(logger: logger);

    client.track(
      'purchase',
      props: {
        'productId': 'sku-1',
        'amount': 3,
        'currency': 'USD',
        'extra': true,
      },
    );
    final purchase = client.queue.peekUnlocked().single;
    expect(purchase.customProperties['productId']?.kind, 'stringValue');
    expect(purchase.customProperties['amount']?.kind, 'doubleValue');
    expect(purchase.customProperties['amount']?.value, 3.0);
    expect(purchase.customProperties['extra']?.kind, 'boolValue');

    client.track('purchase', props: {'amount': '3.00'});
    expect(client.queue.peekUnlocked().length, 1);
    expect(logger.errors, contains(contains('property "amount" must be')));

    client.track('scroll', props: {'percent': 0, 'scrollY': 0});
    final scroll = client.queue.peekUnlocked().last;
    expect(scroll.customProperties['percent']?.value, 0);
    expect(scroll.customProperties['scrollY']?.value, 0);
  });

  test('public well-known event names match runtime schemas', () {
    expect(PugEventNames.all.length, wellKnownEventSchemas.length);
    expect(PugEventNames.all.toSet(), wellKnownEventSchemas.keys.toSet());
    expect(PugEventNames.isWellKnown(PugEventNames.purchase), isTrue);
    expect(PugEventNames.isWellKnown('custom_event'), isFalse);
  });

  test('string properties are truncated to 1024 UTF-8 bytes', () {
    final mapped = const PropertyMapper().mapProperties({'long': 'a' * 2000});
    final value = mapped['long']!.value as String;
    expect(value.length, 1024);
  });

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
    'lifecycle background flushes queued events even without auto tracking',
    () async {
      final transport = FakeTransport();
      final client = testClient(transport: transport);

      client.track('one');
      client.didChangeAppLifecycleState(AppLifecycleState.paused);
      await Future<void>.delayed(Duration.zero);

      expect(transport.batches.single.map((event) => event.kind), ['one']);
      expect(client.queue.peekUnlocked(), isEmpty);
    },
  );

  test('auto tracking emits app open and close from lifecycle', () async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    final transport = FakeTransport();
    final client = testClient(
      transport: transport,
      autoTrack: true,
      lifecycleBinding: binding,
    );

    expect(client.queue.peekUnlocked().map((event) => event.kind), [
      'app_open',
    ]);

    binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await Future<void>.delayed(Duration.zero);

    expect(transport.sent.map((event) => event.kind), ['app_close']);
    expect(transport.batches.single.map((event) => event.kind), ['app_open']);
    expect(client.queue.peekUnlocked(), isEmpty);

    binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    expect(client.queue.peekUnlocked().map((event) => event.kind), [
      'app_open',
    ]);
  });

  test('destroy starts a best-effort final flush', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport);

    client.track('one');
    client.destroy();
    await Future<void>.delayed(Duration.zero);

    expect(transport.batches.single.map((event) => event.kind), ['one']);
    expect(client.queue.peekUnlocked(), isEmpty);
  });

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
    'FCM provider supplies token and extracts remote message data',
    () async {
      var deleted = false;
      final provider = FcmPushProvider(
        getToken: () async => 'fcm-token',
        deleteToken: () async {
          deleted = true;
        },
        targetPlatform: TargetPlatform.android,
      );

      expect(provider.provider, 'fcm');
      expect(provider.platform, 'android');
      expect(await provider.getToken(), 'fcm-token');

      await provider.deleteToken();
      expect(deleted, isTrue);

      final data = provider.notificationData(
        const RemoteMessage(
          data: <String, String>{'campaignId': 'campaign-1'},
          messageId: 'message-1',
          notification: RemoteNotification(title: 'Title', body: 'Body'),
        ),
      );

      expect(data['campaignId'], 'campaign-1');
      expect(data['messageId'], 'message-1');
      expect(data['title'], 'Title');
      expect(data['body'], 'Body');
    },
  );

  test('FCM provider reports unavailable tokens', () async {
    final provider = FcmPushProvider(getToken: () async => null);

    await expectLater(provider.getToken(), throwsA(isA<PugException>()));
  });

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
  PugLogger? logger,
  PugAutoPropertyProvider? autoPropertyProvider,
  bool autoTrack = false,
  WidgetsBinding? lifecycleBinding,
}) {
  final client = PugClient(
    projectId: 'project',
    options: PugOptions(
      apiKey: 'key',
      transport: transport ?? FakeTransport(),
      storage: storage ?? MemoryPugStorage(),
      logger: logger ?? const NoopPugLogger(),
      autoPropertyProvider:
          autoPropertyProvider ?? const PugStaticAutoPropertyProvider({}),
      autoTrack: autoTrack,
      batch: const BatchConfig(maxWaitMs: 60000),
    ),
    clock: clock ?? FakeClock(1000),
    idGenerator: ids ?? SequenceIds(),
    lifecycleBinding: lifecycleBinding,
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

String? readDeviceId(MemoryPugStorage storage) =>
    storage.getString('__pug_project_device_id__');

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
  final List<String> errors = <String>[];

  @override
  void debug(String message) {}

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    errors.add(message);
  }

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
