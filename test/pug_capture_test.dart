import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';

import 'test_support.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

  test('route observer emits page_view events through the wired client', () {
    final client = testClient(autoPageViews: true);
    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    addTearDown(() => PugRouteObserver.onRouteChanged = null);

    final observer = PugRouteObserver();
    observer.didPush(NamedRoute('/home'), NamedRoute('/'));
    observer.didPush(NamedRoute('/profile'), NamedRoute('/home'));

    final events = client.queue.peekUnlocked();
    expect(events.map((event) => event.kind), everyElement('page_view'));
    expect(events.last.customProperties['url']?.value, '/profile');
    expect(events.last.customProperties['referrer']?.value, '/home');
  });

  test('notification received and dismissed are sent immediately', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport);

    client.trackNotificationReceived({'campaignId': 'c1'});
    client.trackNotificationDismissed({'campaignId': 'c1'});
    await Future<void>.delayed(Duration.zero);

    expect(
      transport.sent.map((event) => event.kind),
      containsAll(['notification_received', 'notification_dismissed']),
    );
    expect(client.queue.peekUnlocked(), isEmpty);
  });
}
