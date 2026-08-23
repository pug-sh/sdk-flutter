import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter/pug_flutter.dart';

import 'test_doubles.dart';

const _lastVersionKey = '__pug_project_last_version__';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('install and update detection', () {
    test('first launch emits app_install and records the version', () {
      final storage = MemoryPugStorage();
      final client = launch(storage: storage, appVersion: '1.0.0');

      final events = client.queue.peekUnlocked();
      expect(events.map((event) => event.kind), ['app_install']);
      expect(events.single.customProperties['appVersion']?.value, '1.0.0');
      expect(storage.getString(_lastVersionKey), '1.0.0');
    });

    test('a relaunch on the same version emits nothing', () async {
      final storage = MemoryPugStorage();
      // Drained first: the replacement client adopts the persisted queue, so
      // the install from launch one would otherwise still be sitting in it.
      await launch(storage: storage, appVersion: '1.0.0').flush();
      final relaunch = launch(storage: storage, appVersion: '1.0.0');

      expect(relaunch.queue.peekUnlocked(), isEmpty);
    });

    test(
      'a version change emits app_update with the previous version',
      () async {
        final storage = MemoryPugStorage();
        await launch(storage: storage, appVersion: '1.0.0').flush();
        final updated = launch(storage: storage, appVersion: '1.1.0');

        final events = updated.queue.peekUnlocked();
        expect(events.map((event) => event.kind), ['app_update']);
        expect(events.single.customProperties['appVersion']?.value, '1.1.0');
        expect(
          events.single.customProperties['previousVersion']?.value,
          '1.0.0',
        );
        expect(storage.getString(_lastVersionKey), '1.1.0');
      },
    );

    test('prior Pug state adopts the version without an app_install', () {
      final storage =
          MemoryPugStorage()
            ..setString('__pug_project_device_id__', 'device-1');
      final client = launch(storage: storage, appVersion: '1.0.0');

      expect(client.queue.peekUnlocked(), isEmpty);
      expect(storage.getString(_lastVersionKey), '1.0.0');
    });

    test('no app version disables detection', () {
      final storage = MemoryPugStorage();
      final client = launch(storage: storage);

      expect(client.queue.peekUnlocked(), isEmpty);
      expect(storage.getString(_lastVersionKey), isNull);
    });

    test('autoInstallEvents disabled skips detection', () {
      final storage = MemoryPugStorage();
      final client = launch(
        storage: storage,
        appVersion: '1.0.0',
        autoInstallEvents: false,
      );

      expect(client.queue.peekUnlocked(), isEmpty);
      expect(storage.getString(_lastVersionKey), isNull);
    });

    test('denied consent defers the install rather than losing it', () {
      final storage = MemoryPugStorage();
      final denied = launch(
        storage: storage,
        appVersion: '1.0.0',
        consent: const TrackingConsentConfig(
          defaultConsent: TrackingConsent.denied,
        ),
      );

      expect(denied.queue.peekUnlocked(), isEmpty);
      expect(storage.getString(_lastVersionKey), isNull);

      final granted = launch(storage: storage, appVersion: '1.0.0');

      expect(granted.queue.peekUnlocked().map((event) => event.kind), [
        'app_install',
      ]);
    });

    test('detection runs even with lifecycle auto tracking off', () {
      final storage = MemoryPugStorage();
      final client = launch(
        storage: storage,
        appVersion: '1.0.0',
        autoTrack: false,
      );

      expect(client.queue.peekUnlocked().map((event) => event.kind), [
        'app_install',
      ]);
    });

    test('persisted consent alone does not suppress the install', () {
      const config = TrackingConsentConfig(
        defaultConsent: TrackingConsent.denied,
        persist: true,
      );
      final storage = MemoryPugStorage();
      final denied = launch(
        storage: storage,
        appVersion: '1.0.0',
        consent: config,
      );
      // Opting in writes the consent key, and that key deliberately outlives
      // destroy() — so it must not read as prior tracking activity.
      denied.optInTracking();

      final granted = launch(
        storage: storage,
        appVersion: '1.0.0',
        consent: config,
      );

      expect(granted.queue.peekUnlocked().map((event) => event.kind), [
        'app_install',
      ]);
    });

    test('a downgrade is still an update', () {
      final storage = MemoryPugStorage()..setString(_lastVersionKey, '1.1.0');
      final client = launch(storage: storage, appVersion: '1.0.0');

      final events = client.queue.peekUnlocked();
      expect(events.map((event) => event.kind), ['app_update']);
      expect(events.single.customProperties['previousVersion']?.value, '1.1.0');
    });

    test('an empty stored version reads as a first launch', () {
      final storage = MemoryPugStorage()..setString(_lastVersionKey, '');
      final client = launch(storage: storage, appVersion: '1.0.0');

      expect(client.queue.peekUnlocked().map((event) => event.kind), [
        'app_install',
      ]);
    });

    test('a non-string app version is skipped with a debug log', () {
      final storage = MemoryPugStorage();
      final logger = CapturingLogger();
      final client = launch(storage: storage, appVersion: 7, logger: logger);

      expect(client.queue.peekUnlocked(), isEmpty);
      expect(storage.getString(_lastVersionKey), isNull);
      expect(
        logger.debugs.any((m) => m.contains('install/update detection')),
        isTrue,
      );
    });

    test('denied consent leaves the stored version behind on an update', () {
      final storage = MemoryPugStorage()..setString(_lastVersionKey, '1.0.0');
      final client = launch(
        storage: storage,
        appVersion: '1.1.0',
        consent: const TrackingConsentConfig(
          defaultConsent: TrackingConsent.denied,
        ),
      );

      expect(client.queue.peekUnlocked(), isEmpty);
      expect(storage.getString(_lastVersionKey), '1.0.0');
    });

    test('the launch install precedes the launch app_open', () {
      final binding = TestWidgetsFlutterBinding.ensureInitialized();
      binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      final storage = MemoryPugStorage();
      final client = launch(
        storage: storage,
        appVersion: '1.0.0',
        lifecycleBinding: binding,
      );

      // The app_open's own session/profile writes would trip the prior-state
      // probe if the check did not run first.
      expect(client.queue.peekUnlocked().map((event) => event.kind), [
        'app_install',
        'app_open',
      ]);
    });

    test('a second start does not re-emit the install', () {
      final storage = MemoryPugStorage();
      final client = launch(storage: storage, appVersion: '1.0.0');

      unawaited(client.start());

      expect(client.queue.peekUnlocked().map((event) => event.kind), [
        'app_install',
      ]);
    });

    test('destroy purges the recorded version', () async {
      final storage = MemoryPugStorage();
      final client = launch(storage: storage, appVersion: '1.0.0');

      await client.destroy();

      expect(storage.getString(_lastVersionKey), isNull);
    });

    test('the option defaults to on', () {
      final storage = MemoryPugStorage();
      final client = PugClient(
        projectId: 'project',
        options: PugOptions(
          apiKey: 'key',
          transport: FakeTransport(),
          storage: storage,
          autoPropertyProvider: const PugStaticAutoPropertyProvider({
            r'$appVersion': '1.0.0',
          }),
          autoTrack: false,
          autoPageViews: false,
          batch: const BatchConfig(maxWaitMs: 60000),
        ),
      );
      addTearDown(client.destroy);
      unawaited(client.start());

      expect(client.queue.peekUnlocked().map((event) => event.kind), [
        'app_install',
      ]);
    });

    test('copyWith carries the option through Pug.init', () {
      // Pug.init resolves storage and auto-properties with copyWith, so a
      // dropped field there would silently flip a host's opt-out back on.
      const options = PugOptions(apiKey: 'key', autoInstallEvents: false);

      expect(
        options.copyWith(storage: MemoryPugStorage()).autoInstallEvents,
        isFalse,
      );
    });

    test('a client that handed its storage over purges nothing', () async {
      final storage = MemoryPugStorage();
      final first = launch(storage: storage, appVersion: '1.0.0');
      await first.flush();
      launch(storage: storage, appVersion: '1.0.0');

      await first.destroy();

      expect(storage.getString(_lastVersionKey), '1.0.0');
    });
  });
}

PugClient launch({
  required MemoryPugStorage storage,
  Object? appVersion,
  bool autoTrack = true,
  bool autoInstallEvents = true,
  TrackingConsentConfig consent = const TrackingConsentConfig(),
  PugLogger? logger,
  WidgetsBinding? lifecycleBinding,
}) {
  final client = PugClient(
    projectId: 'project',
    options: PugOptions(
      apiKey: 'key',
      transport: FakeTransport(),
      storage: storage,
      logger: logger ?? const NoopPugLogger(),
      autoPropertyProvider: PugStaticAutoPropertyProvider({
        if (appVersion != null) r'$appVersion': appVersion,
      }),
      trackingConsent: consent,
      autoTrack: autoTrack,
      autoPageViews: false,
      autoInstallEvents: autoInstallEvents,
      batch: const BatchConfig(maxWaitMs: 60000),
    ),
    clock: FakeClock(1000),
    idGenerator: SequenceIds(),
    lifecycleBinding: lifecycleBinding,
  );
  unawaited(client.start());
  addTearDown(client.destroy);
  return client;
}
