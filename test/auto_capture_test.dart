import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';

import 'test_doubles.dart';

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
}
