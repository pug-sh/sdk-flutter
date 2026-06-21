import 'dart:async';
import 'dart:convert';

import 'package:connectrpc/connect.dart' as connect;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';
import 'package:pug_sdk/src/connect_transport.dart';
import 'package:pug_sdk/src/event_queue_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('default endpoint points at production, not localhost', () {
    const options = PugOptions(apiKey: 'key');
    expect(options.endpoint, 'https://polru.pug.sh');
  });

  test(
    'init validates required values and repeated init warns and is ignored',
    () async {
      await expectLater(
        Pug.init('', const PugOptions(apiKey: 'key', autoTrack: false)),
        throwsA(isA<ArgumentError>()),
      );

      final logger = CapturingLogger();
      final transport = FakeTransport();
      await Pug.init(
        'project',
        PugOptions(
          apiKey: 'key',
          logger: logger,
          transport: transport,
          storage: MemoryPugStorage(),
          autoTrack: false,
        ),
      );

      await expectLater(
        Pug.init(
          'project',
          PugOptions(apiKey: 'key', logger: logger, autoTrack: false),
        ),
        completes,
      );
      expect(
        logger.warnings,
        contains('Pug.init() called after initialization; ignoring.'),
      );

      Pug.destroy();
    },
  );

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

  test(
    'identify before init warns, while invalid input and transport failures still throw',
    () async {
      await expectLater(Pug.identify('user-before-init'), completes);

      final failedTransport =
          FakeTransport()
            ..identifyError = const PugTransportException('identify failed');
      final client = testClient(transport: failedTransport);

      await expectLater(client.identify(''), throwsA(isA<ArgumentError>()));

      await expectLater(
        client.identify('user-1'),
        throwsA(isA<PugTransportException>()),
      );
    },
  );

  test('init and identify remain safe when logger throws', () async {
    await expectLater(
      Pug.init(
        '',
        const PugOptions(
          apiKey: 'key',
          logger: ThrowingLogger(),
          autoTrack: false,
        ),
      ),
      throwsA(isA<ArgumentError>()),
    );

    final client = testClient(
      logger: const ThrowingLogger(),
      autoCaptureCampaigns: false,
    );
    await expectLater(client.identify(''), throwsA(isA<ArgumentError>()));
    Pug.destroy();
    await expectLater(Pug.identify('user-before-init'), completes);
    expect(
      () => client.track('purchase', props: {'bad': double.nan}),
      returnsNormally,
    );
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

  test('campaign properties are captured from initial app link', () async {
    final client = testClient(
      linkProvider: FakeLinkProvider(
        initial: Uri.parse(
          'https://example.com/welcome?utm_source=google&utm_medium=cpc'
          '&utm_campaign=spring&gclid=click-1',
        ),
      ),
      autoCaptureCampaigns: true,
    );
    await Future<void>.delayed(Duration.zero);

    client.track('signup');

    final autoProperties = client.queue.peekUnlocked().single.autoProperties;
    expect(autoProperties[r'$utmSource']?.value, 'google');
    expect(autoProperties[r'$utmMedium']?.value, 'cpc');
    expect(autoProperties[r'$utmCampaign']?.value, 'spring');
    expect(autoProperties[r'$gclid']?.value, 'click-1');
  });

  test('campaign properties update from later app links', () async {
    final linkProvider = FakeLinkProvider();
    final client = testClient(
      linkProvider: linkProvider,
      autoCaptureCampaigns: true,
    );
    await Future<void>.delayed(Duration.zero);

    linkProvider.add(
      Uri.parse('pug://open?utm_source=newsletter&utm_content=hero'),
    );
    await Future<void>.delayed(Duration.zero);
    client.track('open');

    final autoProperties = client.queue.peekUnlocked().single.autoProperties;
    expect(autoProperties[r'$utmSource']?.value, 'newsletter');
    expect(autoProperties[r'$utmContent']?.value, 'hero');
  });

  test('well-known events accept any props without validation', () {
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
    expect(purchase.customProperties['amount']?.kind, 'intValue');
    expect(purchase.customProperties['amount']?.value, 3);
    expect(purchase.customProperties['extra']?.kind, 'boolValue');

    client.track('purchase', props: {'amount': '3.00'});
    expect(client.queue.peekUnlocked().length, 2);

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

  test('auto page views tracks page_view on route changes', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport, autoPageViews: true);

    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    PugRouteObserver.onRouteChanged?.call('/home', null);

    expect(client.queue.peekUnlocked().map((event) => event.kind), [
      'page_view',
    ]);
    final pageView = client.queue.peekUnlocked().single;
    expect(pageView.customProperties['url']?.value, '/home');
    expect(pageView.customProperties.containsKey('referrer'), isFalse);

    PugRouteObserver.onRouteChanged?.call('/about', '/home');

    expect(client.queue.peekUnlocked().length, 2);
    expect(
      client.queue.peekUnlocked().last.customProperties['url']?.value,
      '/about',
    );
    expect(
      client.queue.peekUnlocked().last.customProperties['referrer']?.value,
      '/home',
    );
  });

  test('auto page views disabled does not track page_view', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport, autoPageViews: false);

    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    PugRouteObserver.onRouteChanged?.call('/home', null);

    expect(client.queue.peekUnlocked(), isEmpty);
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

  test('push subscribe and unsubscribe never throw', () async {
    await expectLater(PugPush.subscribe(FakePushProvider()), completes);
    await expectLater(PugPush.unsubscribe(FakePushProvider()), completes);

    final logger = CapturingLogger();
    final client = testClient(logger: logger);
    await expectLater(
      client.subscribePush(FakePushProvider(token: '')),
      completes,
    );
    await expectLater(
      client.unsubscribePush(FakePushProvider(deleteError: StateError('bad'))),
      completes,
    );

    expect(logger.warnings, contains(contains('token unavailable')));
    expect(logger.errors, contains(contains('Pug push unsubscribe failed')));
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

  test('destroy removes all storage keys', () async {
    final transport = FakeTransport();
    final storage = MemoryPugStorage();
    final client = testClient(transport: transport, storage: storage);

    // Initialize storage with some data
    client.track('test_event');
    await client.identify('test-user');
    await Future<void>.delayed(Duration.zero);

    // Verify storage keys exist before destroy
    expect(storage.getString('__pug_project_session__'), isNotNull);
    expect(storage.getString('__pug_project_profile__'), isNotNull);
    expect(storage.getString('__pug_project_device_id__'), isNotNull);
    expect(storage.getString('__pug_project_external_id__'), isNotNull);
    expect(storage.getString('__pug_project_queue__'), isNotNull);

    // Destroy the client
    client.destroy();

    // Verify all storage keys are removed
    expect(storage.getString('__pug_project_session__'), isNull);
    expect(storage.getString('__pug_project_profile__'), isNull);
    expect(storage.getString('__pug_project_device_id__'), isNull);
    expect(storage.getString('__pug_project_external_id__'), isNull);
    expect(storage.getString('__pug_project_queue__'), isNull);
  });
}

PugClient testClient({
  FakeTransport? transport,
  FakeClock? clock,
  SequenceIds? ids,
  MemoryPugStorage? storage,
  PugLogger? logger,
  PugAutoPropertyProvider? autoPropertyProvider,
  PugLinkProvider? linkProvider,
  bool autoTrack = false,
  bool autoPageViews = false,
  bool autoCaptureCampaigns = false,
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
      linkProvider: linkProvider,
      autoTrack: autoTrack,
      autoPageViews: autoPageViews,
      autoCaptureCampaigns: autoCaptureCampaigns,
      batch: const BatchConfig(maxWaitMs: 60000),
    ),
    clock: clock ?? FakeClock(1000),
    idGenerator: ids ?? SequenceIds(),
    lifecycleBinding: lifecycleBinding,
  );
  unawaited(client.start());
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

class FakeConnectTransport implements connect.Transport {
  Object? unaryError;
  connect.Headers? lastHeaders;
  String? lastProcedure;

  @override
  Future<connect.UnaryResponse<I, O>> unary<I extends Object, O extends Object>(
    connect.Spec<I, O> spec,
    I input, [
    connect.CallOptions? options,
  ]) async {
    lastProcedure = spec.procedure;
    lastHeaders = options?.headers;
    if (unaryError != null) {
      throw unaryError!;
    }
    return connect.UnaryResponse(
      spec,
      connect.Headers(),
      spec.outputFactory(),
      connect.Headers(),
    );
  }

  @override
  Future<connect.StreamResponse<I, O>> stream<
    I extends Object,
    O extends Object
  >(connect.Spec<I, O> spec, Stream<I> input, [connect.CallOptions? options]) {
    throw UnimplementedError();
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

class ThrowingLogger implements PugLogger {
  const ThrowingLogger();

  @override
  void debug(String message) {
    throw StateError('debug failed');
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    throw StateError('error failed');
  }

  @override
  void warn(String message) {
    throw StateError('warn failed');
  }
}

class FakeLinkProvider implements PugLinkProvider {
  FakeLinkProvider({this.initial});

  final Uri? initial;
  final StreamController<Uri> _controller = StreamController<Uri>.broadcast();

  void add(Uri uri) {
    _controller.add(uri);
  }

  @override
  Future<Uri?> initialUri() async => initial;

  @override
  Stream<Uri> get uriStream => _controller.stream;

  @override
  void dispose() {
    unawaited(_controller.close());
  }
}

class FakePushProvider implements PushProvider {
  FakePushProvider({this.token = 'token-1', this.deleteError});

  final String token;
  final Object? deleteError;

  @override
  String get platform => 'android';

  @override
  String get provider => 'fake';

  @override
  Future<void> deleteToken() async {
    final error = deleteError;
    if (error != null) {
      throw error;
    }
  }

  @override
  Future<String> getToken() async => token;

  @override
  Map<Object?, Object?> notificationData(Object source) => const {};
}

class TestRoute extends Route<dynamic> {
  TestRoute({required this.name});

  final String name;

  @override
  RouteSettings get settings => RouteSettings(name: name);

  @override
  List<OverlayEntry> get overlayEntries => [];

  @override
  void dispose() {
    super.dispose();
  }
}
