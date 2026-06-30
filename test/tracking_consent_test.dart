import 'package:flutter/widgets.dart';
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

    test(
      'denied identify persists no identity (stays a first identify)',
      () async {
        final transport = FakeTransport();
        final client = buildClient(
          transport: transport,
          consent: const TrackingConsentConfig(
            defaultConsent: TrackingConsent.denied,
          ),
        );
        addTearDown(client.destroy);

        await client.identify(
          'user-1',
        ); // dropped — must not persist externalId
        client.optInTracking();
        await client.identify('user-2');

        // The denied call stored nothing, so user-2 is still the first effective
        // identify and carries the anonymous id for backend merge. A regression
        // that persisted identity under denial would null the anonymousId here.
        expect(transport.identifies, hasLength(1));
        expect(transport.identifies.single.externalId, 'user-2');
        expect(transport.identifies.single.anonymousId, isNotNull);
      },
    );
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

  // Push device registration is intentionally NOT gated by consent (it mirrors
  // the web SDK). This pins that carve-out so a future "gate everything" change
  // can't silently break device registration for opted-out users.
  group('consent carve-outs', () {
    test('push subscribe still reaches transport when denied', () async {
      final transport = FakeTransport();
      final client = buildClient(
        transport: transport,
        consent: const TrackingConsentConfig(
          defaultConsent: TrackingConsent.denied,
        ),
      );
      addTearDown(client.destroy);

      await client.subscribePush(FakePushProvider());
      expect(transport.subscriptions, hasLength(1));
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

    test(
      'persist:true writes opt-in and restores granted on the next init',
      () {
        final storage = MemoryPugStorage();

        final first = buildClient(
          storage: storage,
          consent: const TrackingConsentConfig(
            defaultConsent: TrackingConsent.denied,
            persist: true,
          ),
        );
        first.optInTracking();
        expect(storage.getString(consentKey), 'granted');
        first.destroy();

        // The persisted grant overrides the denied seed on the next launch.
        final second = buildClient(
          storage: storage,
          consent: const TrackingConsentConfig(
            defaultConsent: TrackingConsent.denied,
            persist: true,
          ),
        );
        addTearDown(second.destroy);

        expect(second.isTrackingEnabled, isTrue);
      },
    );

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

  // The gate lives only inside PugClient.track(); these tests pin the privacy
  // guarantee that every automatic-capture path actually funnels through it.
  group('automatic capture is gated by consent', () {
    const denied = TrackingConsentConfig(
      defaultConsent: TrackingConsent.denied,
    );

    test('queued page_view is dropped when denied, flows once granted', () {
      final client = buildClient(autoPageViews: true, consent: denied);
      addTearDown(client.destroy);

      client.notifyRouteChanged('/home', null);
      expect(client.queue.size, 0);

      client.optInTracking();
      client.notifyRouteChanged('/about', '/home');
      expect(client.queue.peekUnlocked().map((e) => e.kind), ['page_view']);
    });

    test('queued notification_received is dropped when denied', () {
      final client = buildClient(consent: denied);
      addTearDown(client.destroy);

      client.trackNotificationReceived({'ok': 'yes'});
      expect(client.queue.size, 0);
    });

    test('immediate notification_clicked is dropped when denied', () async {
      final transport = FakeTransport();
      final client = buildClient(transport: transport, consent: denied);
      addTearDown(client.destroy);

      client.trackNotificationOpened({'campaignId': 'c1'});
      await Future<void>.delayed(Duration.zero);

      // notification_clicked is immediate, so it bypasses the queue — asserting
      // only queue.size would pass even if the event reached transport.
      expect(client.queue.size, 0);
      expect(transport.sent, isEmpty);
      expect(transport.batches, isEmpty);

      client.optInTracking();
      client.trackNotificationOpened({'campaignId': 'c1'});
      await Future<void>.delayed(Duration.zero);
      expect(transport.sent.map((e) => e.kind), ['notification_clicked']);
    });

    test('lifecycle app_open/app_close are dropped when denied', () async {
      final transport = FakeTransport();
      final client = buildClient(
        transport: transport,
        autoTrack: true,
        consent: denied,
      );
      addTearDown(client.destroy);

      // resumed sets _isForeground and emits app_open (queued); paused emits
      // app_close (immediate) and flushes — all dropped while denied.
      client.didChangeAppLifecycleState(AppLifecycleState.resumed);
      client.didChangeAppLifecycleState(AppLifecycleState.paused);
      await Future<void>.delayed(Duration.zero);

      expect(client.queue.size, 0);
      expect(transport.sent, isEmpty);
      expect(transport.batches, isEmpty);

      client.optInTracking();
      client.didChangeAppLifecycleState(AppLifecycleState.resumed);
      client.didChangeAppLifecycleState(AppLifecycleState.paused);
      await Future<void>.delayed(Duration.zero);

      expect(transport.sent.map((e) => e.kind), contains('app_close'));
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
  bool autoTrack = false,
  bool autoPageViews = false,
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
      autoTrack: autoTrack,
      autoPageViews: autoPageViews,
      autoCaptureCampaigns: false,
      batch: const BatchConfig(maxWaitMs: 60000),
    ),
  );
}
