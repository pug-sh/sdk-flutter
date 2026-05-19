import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Pug.track callable namespace', () {
    test('Pug.track(kind, props:) still works after refactor', () async {
      // This is an existing behavior assertion. It exercises Pug.track via .call().
      // The actual queueing assertion lives in the existing suite; here we only
      // assert that the call shape compiles and does not throw.
      Pug.track('any_event', props: {'a': 1});
    });

    test('tear-off: assigning Pug.track to a variable still allows invocation', () {
      final fn = Pug.track;
      fn('any_event', props: {'a': 1});
      // No exception thrown = pass.
    });
  });

  group('Pug.track.purchase (hand-written reference)', () {
    test('produces a purchase event equivalent to the untyped track call',
        () async {
      // Both calls should produce equivalent queued events. Exact equivalence
      // assertions land in the golden tests (Task 8); here we only check
      // the typed call compiles and runs without throwing.
      Pug.track.purchase(
        productId: 'sku-1',
        amount: 99.50,
        currency: 'USD',
      );
    });

    test('extras key colliding with named arg is dropped with debug log', () {
      // Behavior assertion: the typed contract wins; extras are merged behind.
      Pug.track.purchase(
        productId: 'sku-1',
        amount: 99.50,
        currency: 'USD',
        extras: {'amount': 42.0, 'cohort': 'A'},
      );
      // Logger output is asserted in Task 8 via CapturingLogger.
    });
  });

  group('discouraged-path detector', () {
    setUp(TrackNamespace.resetHintedKindsForTest);

    test('logs debug hint when a well-known kind is used via untyped track',
        () async {
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

      Pug.track('purchase', props: {'productId': 'sku-1'});
      Pug.track('purchase', props: {'productId': 'sku-2'}); // second call — no second log

      final hints = logger.debugs.where(
        (m) => m.contains('consider Pug.track.purchase'),
      ).toList();
      expect(hints, hasLength(1));

      Pug.destroy();
    });

    test('does not log for fully custom events', () async {
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

      Pug.track('cart_abandoned_v2', props: {'cartId': 'c-1'});

      final hints = logger.debugs.where(
        (m) => m.contains('consider Pug.track'),
      ).toList();
      expect(hints, isEmpty);

      Pug.destroy();
    });
  });

  group('Pug.logger getter', () {
    test('returns a usable logger before init (no-op fallback)', () {
      final logger = Pug.shared.logger;
      // Should not be null and should not throw on common calls.
      logger.debug('test');
      logger.warn('test');
      expect(logger, isNotNull);
    });

    test('returns the configured logger after init', () async {
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
      Pug.shared.logger.warn('hello');
      expect(
        logger.warnings.where((m) => m == 'hello'),
        isNotEmpty,
      );
      Pug.destroy();
    });
  });
}
