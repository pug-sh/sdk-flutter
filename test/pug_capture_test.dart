import 'dart:async';

import 'package:flutter/foundation.dart'
    show TargetPlatform, debugDefaultTargetPlatformOverride;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter/pug_flutter.dart';

import 'package:pug_flutter/src/push.dart';

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

  test('auto page views tracks screen_view on native route changes', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport, autoPageViews: true);

    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    PugRouteObserver.onRouteChanged?.call('/home', null);

    // Tests run on the host VM (kIsWeb false), so the native kind is emitted;
    // page_view is reserved for web builds.
    expect(client.queue.peekUnlocked().map((event) => event.kind), [
      'screen_view',
    ]);
    final screenView = client.queue.peekUnlocked().single;
    // screen_view carries the required screenName; route context rides on
    // $url/$referrer auto-properties (matching the web SDK), never on
    // url/referrer custom props.
    expect(screenView.customProperties['screenName']?.value, '/home');
    expect(screenView.autoProperties[r'$url']?.value, '/home');
    expect(screenView.autoProperties.containsKey(r'$referrer'), isFalse);
    expect(screenView.customProperties.containsKey('url'), isFalse);

    PugRouteObserver.onRouteChanged?.call('/about', '/home');

    expect(client.queue.peekUnlocked().length, 2);
    expect(
      client.queue.peekUnlocked().last.customProperties['screenName']?.value,
      '/about',
    );
    expect(
      client.queue.peekUnlocked().last.autoProperties[r'$url']?.value,
      '/about',
    );
    expect(
      client.queue.peekUnlocked().last.autoProperties[r'$referrer']?.value,
      '/home',
    );
  });

  test('a null route updates state without emitting screen_view', () async {
    final client = testClient(autoPageViews: true);

    client.notifyRouteChanged('/home', null);
    client.notifyRouteChanged(null, '/home');

    // screen_view requires a non-empty screenName, so the null route emits
    // nothing — but route state moved on, so later events carry no $url.
    expect(client.queue.peekUnlocked().map((event) => event.kind), [
      'screen_view',
    ]);
    client.track('custom');
    final custom = client.queue.peekUnlocked().last;
    expect(custom.autoProperties.containsKey(r'$url'), isFalse);
    expect(custom.autoProperties[r'$referrer']?.value, '/home');
  });

  test('an empty-string route updates state without emitting screen_view', () {
    final client = testClient(autoPageViews: true);

    // screen_view carries a required screen_name (proto), so an empty route
    // name must emit nothing — otherwise the server permanently rejects the
    // event and it is silently dropped. Guards the `url.isNotEmpty` check.
    client.notifyRouteChanged('', null);

    expect(client.queue.peekUnlocked(), isEmpty);
  });

  test('desktop route changes update state without emitting a navigation '
      'event', () async {
    // screen_view is limited to iOS/Android and page_view is web-only, so a
    // desktop route change emits no navigation event — but route state still
    // moves on for the $url/$referrer auto-properties on later events.
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    final client = testClient(autoPageViews: true);

    client.notifyRouteChanged('/home', null);
    expect(client.queue.peekUnlocked(), isEmpty);

    client.track('custom');
    final custom = client.queue.peekUnlocked().single;
    expect(custom.kind, 'custom');
    expect(custom.autoProperties[r'$url']?.value, '/home');
  });

  test('an unsupported native platform logs once and emits no event', () {
    final logger = CapturingLogger();
    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    final client = testClient(logger: logger, autoPageViews: true);

    client.notifyRouteChanged('/home', null);
    client.notifyRouteChanged('/settings', '/home');

    // Desktop has no navigation kind in the schema, so nothing is emitted — but
    // we log once (not per route change) so a developer who wired the observer
    // isn't left wondering why no navigation events ever appear.
    expect(client.queue.peekUnlocked(), isEmpty);
    expect(
      logger.debugs.where((message) => message.contains('navigation')),
      hasLength(1),
    );
  });

  test('auto page views disabled does not track navigation events', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport, autoPageViews: false);

    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    PugRouteObserver.onRouteChanged?.call('/home', null);

    expect(client.queue.peekUnlocked(), isEmpty);
  });

  test(r'$url/$referrer ride on all events, not just page_view', () {
    final client = testClient(autoPageViews: true);
    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    addTearDown(() => PugRouteObserver.onRouteChanged = null);

    client.notifyRouteChanged('/home', null);
    client.notifyRouteChanged('/cart', '/home');
    client.track('checkout_started');

    final event = client.queue.peekUnlocked().last;
    expect(event.kind, 'checkout_started');
    expect(event.autoProperties[r'$url']?.value, '/cart');
    expect(event.autoProperties[r'$referrer']?.value, '/home');
  });

  test(r'$url is attached even when auto page views are disabled', () {
    final client = testClient(autoPageViews: false);
    client.notifyRouteChanged('/home', null);
    client.track('custom');

    final events = client.queue.peekUnlocked();
    // No page_view event, but the current route still stamps $url.
    expect(events.map((event) => event.kind), ['custom']);
    expect(events.single.autoProperties[r'$url']?.value, '/home');
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

  test('route observer emits screen_view events through the wired client', () {
    final client = testClient(autoPageViews: true);
    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    addTearDown(() => PugRouteObserver.onRouteChanged = null);

    final observer = PugRouteObserver();
    observer.didChangeTop(NamedRoute('/home'), NamedRoute('/'));
    observer.didChangeTop(NamedRoute('/profile'), NamedRoute('/home'));

    final events = client.queue.peekUnlocked();
    expect(events.map((event) => event.kind), everyElement('screen_view'));
    expect(events.last.customProperties['screenName']?.value, '/profile');
    expect(events.last.autoProperties[r'$url']?.value, '/profile');
    expect(events.last.autoProperties[r'$referrer']?.value, '/home');
  });

  testWidgets('removing a route below the top leaves the tracked route alone', (
    tester,
  ) async {
    final client = testClient(autoPageViews: true);
    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    addTearDown(() => PugRouteObserver.onRouteChanged = null);

    Route<void> page(String name) => PageRouteBuilder<void>(
      settings: RouteSettings(name: name),
      pageBuilder:
          (context, animation, secondaryAnimation) => const SizedBox.shrink(),
    );

    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      WidgetsApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [PugRouteObserver()],
        color: const Color(0xFF000000),
        onGenerateRoute: (settings) => page(settings.name ?? '/'),
      ),
    );

    final navigator = navigatorKey.currentState!;
    final middle = page('/b');
    unawaited(navigator.push(middle));
    await tester.pumpAndSettle();
    unawaited(navigator.push(page('/c')));
    await tester.pumpAndSettle();

    final before = client.queue.peekUnlocked().length;
    // `didRemove` reports the route *below* the removed one, so acting on it
    // here would report '/' while '/c' is still on screen.
    navigator.removeRoute(middle);
    await tester.pumpAndSettle();

    final events = client.queue.peekUnlocked();
    expect(events.length, before);
    expect(events.last.customProperties['screenName']?.value, '/c');
    expect(events.last.autoProperties[r'$url']?.value, '/c');

    // testWidgets fails the test on a pending timer, and the tear-down destroy
    // that cancels the flush timer runs after that check.
    await client.destroy();
  });

  test('an observer attached mid-stack reports no empty stack', () {
    final client = testClient(autoPageViews: true);
    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    addTearDown(() => PugRouteObserver.onRouteChanged = null);

    final observer = PugRouteObserver();
    final home = NamedRoute('/');
    final detail = NamedRoute('/b');

    // '/' was already on the stack when this observer was attached, so its
    // push was never counted. Popping '/b' must not look like an empty stack.
    observer.didPush(detail, home);
    observer.didChangeTop(detail, home);
    observer.didPop(detail, home);
    observer.didChangeTop(home, detail);

    final events = client.queue.peekUnlocked();
    expect(events.map((event) => event.kind), everyElement('screen_view'));
    expect(events.last.customProperties['screenName']?.value, '/');
    // A spurious null transition between the pop and didChangeTop would land
    // here as a null referrer.
    expect(events.last.autoProperties[r'$referrer']?.value, '/b');
  });

  testWidgets('replacing the whole route stack keeps the referrer', (
    tester,
  ) async {
    final client = testClient(autoPageViews: true);
    PugRouteObserver.onRouteChanged = client.notifyRouteChanged;
    addTearDown(() => PugRouteObserver.onRouteChanged = null);

    Route<void> page(String name) => PageRouteBuilder<void>(
      settings: RouteSettings(name: name),
      pageBuilder:
          (context, animation, secondaryAnimation) => const SizedBox.shrink(),
    );

    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      WidgetsApp(
        navigatorKey: navigatorKey,
        navigatorObservers: [PugRouteObserver()],
        color: const Color(0xFF000000),
        onGenerateRoute: (settings) => page(settings.name ?? '/'),
      ),
    );

    final navigator = navigatorKey.currentState!;
    unawaited(navigator.push(page('/b')));
    await tester.pumpAndSettle();

    // Removing the bottom-most route hands `didRemove` a null previousRoute
    // while another route is still on screen; acting on it would strand the
    // tracked route at null.
    unawaited(navigator.pushAndRemoveUntil(page('/login'), (route) => false));
    await tester.pumpAndSettle();

    final events = client.queue.peekUnlocked();
    expect(events.last.customProperties['screenName']?.value, '/login');
    expect(events.last.autoProperties[r'$url']?.value, '/login');
    expect(events.last.autoProperties[r'$referrer']?.value, '/b');

    await client.destroy();
  });

  test('inactive flushes without emitting app_close', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport, autoTrack: true);

    client.didChangeAppLifecycleState(AppLifecycleState.resumed);
    client.track('one');
    client.didChangeAppLifecycleState(AppLifecycleState.inactive);
    await Future<void>.delayed(Duration.zero);

    // An incoming call or the app switcher is not an app_close. It still
    // flushes: on desktop the embedders send only resumed/inactive/hidden, so
    // `inactive` can be the last state before the process exits.
    expect(transport.sent, isEmpty);
    expect(transport.batches.single.map((event) => event.kind), [
      'app_open',
      'one',
    ]);
    expect(client.queue.peekUnlocked(), isEmpty);
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
    expect(
      transport.sent.map(
        (event) => event.customProperties['campaignId']?.value,
      ),
      everyElement('c1'),
    );
    expect(client.queue.peekUnlocked(), isEmpty);
  });

  test('all notification helpers default an unusable campaignId', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport);

    // The notification_* schemas require a non-empty campaign_id; without the
    // fallback the server rejects these events (a permanent, silent drop).
    client.trackNotificationReceived({'ok': 'yes'}); // missing
    client.trackNotificationDismissed({'campaignId': ''}); // empty
    client.trackNotificationOpened({'campaignId': 7}); // non-string
    await Future<void>.delayed(Duration.zero);

    expect(transport.sent, hasLength(3));
    expect(
      transport.sent.map(
        (event) => event.customProperties['campaignId']?.value,
      ),
      everyElement('(unknown)'),
    );
  });
}
