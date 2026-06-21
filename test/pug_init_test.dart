import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_support.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

      await Pug.destroy();
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
    await Pug.destroy();
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
    await Pug.destroy();
    await expectLater(Pug.identify('user-before-init'), completes);
    expect(
      () => client.track('purchase', props: {'bad': double.nan}),
      returnsNormally,
    );
  });

  test('destroy starts a best-effort final flush', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport);

    client.track('one');
    await client.destroy();

    expect(transport.batches.single.map((event) => event.kind), ['one']);
    expect(client.queue.peekUnlocked(), isEmpty);
  });

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
    await client.destroy();

    // Verify all storage keys are removed
    expect(storage.getString('__pug_project_session__'), isNull);
    expect(storage.getString('__pug_project_profile__'), isNull);
    expect(storage.getString('__pug_project_device_id__'), isNull);
    expect(storage.getString('__pug_project_external_id__'), isNull);
    expect(storage.getString('__pug_project_queue__'), isNull);
  });

  test('Pug.init binds the route observer callback', () async {
    PugRouteObserver.onRouteChanged = null;
    await Pug.init(
      'project',
      PugOptions(
        apiKey: 'key',
        transport: FakeTransport(),
        storage: MemoryPugStorage(),
        autoTrack: false,
      ),
    );

    expect(PugRouteObserver.onRouteChanged, isNotNull);
    await Pug.destroy();
  });

  test('destroy clears the route observer callback', () async {
    final client = testClient();
    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;

    await client.destroy();

    expect(PugRouteObserver.onRouteChanged, isNull);
  });

  test(
    'destroy detaches the singleton synchronously for immediate re-init',
    () async {
      await Pug.init(
        'project',
        PugOptions(
          apiKey: 'key',
          transport: FakeTransport(),
          storage: MemoryPugStorage(),
          autoTrack: false,
        ),
      );

      // Intentionally not awaited — the singleton must detach synchronously so a
      // follow-up init() is not rejected as "already initialized".
      final pendingDestroy = Pug.destroy();

      final logger = CapturingLogger();
      await Pug.init(
        'project',
        PugOptions(
          apiKey: 'key',
          logger: logger,
          transport: FakeTransport(),
          storage: MemoryPugStorage(),
          autoTrack: false,
        ),
      );

      expect(
        logger.warnings,
        isNot(contains('Pug.init() called after initialization; ignoring.')),
      );

      await pendingDestroy;
      await Pug.destroy();
    },
  );

  test('shared preferences storage logs when an async write fails', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final preferences = await SharedPreferences.getInstance();
    final logger = CapturingLogger();
    final storage = SharedPreferencesPugStorage(
      preferences,
      logger: logger,
      writeString: (_, _) => Future<bool>.error(StateError('disk full')),
      removeKey: (_) => Future<bool>.error(StateError('disk full')),
    );

    storage.setString('k', 'v');
    storage.remove('k');
    await Future<void>.delayed(Duration.zero);

    expect(logger.warnings, hasLength(2));
    expect(logger.warnings.any((m) => m.contains('persist')), isTrue);
    expect(logger.warnings.any((m) => m.contains('remove')), isTrue);
  });
}
