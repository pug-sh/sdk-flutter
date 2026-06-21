import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('tracking consent gating', () {
    test('granted by default lets events through', () {
      final client = buildClient();
      addTearDown(client.destroy);

      expect(client.isTrackingEnabled, isTrue);
      expect(client.trackingConsent, TrackingConsent.granted);

      client.track('signup');
      expect(client.queue.size, 1);
    });

    test('denied by default drops events', () {
      final client = buildClient(
        consent: const TrackingConsentConfig(
          defaultConsent: TrackingConsent.denied,
        ),
      );
      addTearDown(client.destroy);

      expect(client.isTrackingEnabled, isFalse);
      expect(client.trackingConsent, TrackingConsent.denied);

      client.track('signup');
      expect(client.queue.size, 0);
    });

    test('denied drops a track call with a debug log', () {
      final logger = CapturingLogger();
      final client = buildClient(
        logger: logger,
        consent: const TrackingConsentConfig(
          defaultConsent: TrackingConsent.denied,
        ),
      );
      addTearDown(client.destroy);

      client.track('purchase');

      expect(client.queue.size, 0);
      expect(logger.debugs.any((m) => m.contains('consent is denied')), isTrue);
    });

    test(
      'denied drops identify without throwing or hitting transport',
      () async {
        final transport = FakeTransport();
        final client = buildClient(
          transport: transport,
          consent: const TrackingConsentConfig(
            defaultConsent: TrackingConsent.denied,
          ),
        );
        addTearDown(client.destroy);

        await expectLater(client.identify('user-1'), completes);
        expect(transport.identifies, isEmpty);
      },
    );

    test('granted lets identify reach transport', () async {
      final transport = FakeTransport();
      final client = buildClient(transport: transport);
      addTearDown(client.destroy);

      await client.identify('user-1');
      expect(transport.identifies, hasLength(1));
    });
  });

  group('opt in / opt out at runtime', () {
    test('optOut after granted drops subsequent events', () {
      final client = buildClient();
      addTearDown(client.destroy);

      client.optOutTracking();
      expect(client.isTrackingEnabled, isFalse);

      client.track('signup');
      expect(client.queue.size, 0);
    });

    test('optIn after denied lets subsequent events through', () {
      final client = buildClient(
        consent: const TrackingConsentConfig(
          defaultConsent: TrackingConsent.denied,
        ),
      );
      addTearDown(client.destroy);

      client.track('signup');
      expect(client.queue.size, 0);

      client.optInTracking();
      expect(client.isTrackingEnabled, isTrue);

      client.track('signup');
      expect(client.queue.size, 1);
    });
  });

  group('persistence', () {
    const consentKey = '__pug_project_consent__';

    test('persist:true writes opt-out and restores it on the next init', () {
      final storage = MemoryPugStorage();

      final first = buildClient(
        storage: storage,
        consent: const TrackingConsentConfig(persist: true),
      );
      first.optOutTracking();
      expect(storage.getString(consentKey), 'denied');
      first.destroy();

      // A fresh client over the same storage restores the denial, even though
      // its default seed is granted.
      final second = buildClient(
        storage: storage,
        consent: const TrackingConsentConfig(persist: true),
      );
      addTearDown(second.destroy);

      expect(second.isTrackingEnabled, isFalse);
      second.track('signup');
      expect(second.queue.size, 0);
    });

    test('persist:false does not write consent to storage', () {
      final storage = MemoryPugStorage();
      final client = buildClient(storage: storage);
      addTearDown(client.destroy);

      client.optOutTracking();
      expect(storage.getString(consentKey), isNull);
    });

    test('an invalid stored consent value is ignored and warns', () {
      final storage = MemoryPugStorage();
      storage.setString(consentKey, 'maybe');
      final logger = CapturingLogger();

      final client = buildClient(
        storage: storage,
        logger: logger,
        consent: const TrackingConsentConfig(persist: true),
      );
      addTearDown(client.destroy);

      // Falls back to the default seed (granted).
      expect(client.isTrackingEnabled, isTrue);
      expect(logger.warnings.any((m) => m.contains('invalid')), isTrue);
    });
  });

  group('Pug facade before init', () {
    test('consent calls are safe and report a denied/disabled state', () {
      expect(Pug.isTrackingEnabled(), isFalse);
      expect(Pug.getTrackingConsent(), TrackingConsent.denied);
      // Must not throw.
      Pug.optInTracking();
      Pug.optOutTracking();
    });
  });
}

PugClient buildClient({
  FakeTransport? transport,
  MemoryPugStorage? storage,
  PugLogger? logger,
  TrackingConsentConfig consent = const TrackingConsentConfig(),
}) {
  return PugClient(
    projectId: 'project',
    options: PugOptions(
      apiKey: 'key',
      transport: transport ?? FakeTransport(),
      storage: storage ?? MemoryPugStorage(),
      logger: logger ?? const NoopPugLogger(),
      autoPropertyProvider: const PugStaticAutoPropertyProvider({}),
      trackingConsent: consent,
      autoTrack: false,
      autoPageViews: false,
      autoCaptureCampaigns: false,
      batch: const BatchConfig(maxWaitMs: 60000),
    ),
  );
}
