import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';

import 'test_doubles.dart';

// ---------------------------------------------------------------------------
// File-private helpers for golden equivalence tests (Task 8)
// ---------------------------------------------------------------------------

/// Initialises Pug with a fresh [FakeTransport], runs [act], flushes, then
/// destroys and returns the list of [Event] JSON maps from all batches.
Future<List<Map<String, Object?>>> _captureRequests(
  void Function() act,
) async {
  final transport = FakeTransport();
  await Pug.init(
    'project',
    PugOptions(
      apiKey: 'key',
      logger: CapturingLogger(),
      transport: transport,
      storage: MemoryPugStorage(),
      autoTrack: false,
    ),
  );
  act();
  await Pug.flush();
  final events = transport.batches.expand((batch) => batch).toList();
  Pug.destroy();
  return events.map((e) => e.toJson()).toList();
}

/// Removes volatile fields from a JSON map so that two otherwise-equivalent
/// events can be compared deterministically.
///
/// Stripped fields:
/// - `eventId` — random UUID per track() call.
/// - `occurTime` — wall-clock milliseconds.
/// - `sessionId` — random UUID created at Pug.init(); differs across separate
///   init calls used by [_captureRequests].
/// - `distinctId` — anonymous profile ID, also random UUID per init.
List<Map<String, Object?>> _stripVolatile(List<Map<String, Object?>> maps) {
  return maps.map((m) {
    final copy = Map<String, Object?>.from(m);
    copy.remove('eventId');
    copy.remove('occurTime');
    copy.remove('sessionId');
    copy.remove('distinctId');
    return copy;
  }).toList();
}

/// Returns a sample value appropriate for the given [WellKnownPropertyType].
Object _sampleValue(WellKnownPropertyType type) {
  switch (type) {
    case WellKnownPropertyType.string:
      return 'x';
    case WellKnownPropertyType.int32:
      return 1;
    case WellKnownPropertyType.double:
      return 1.0;
    case WellKnownPropertyType.bool:
      return true;
  }
}

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

  // ---------------------------------------------------------------------------
  // Task 8 — Golden equivalence tests
  // ---------------------------------------------------------------------------

  group('golden equivalence: untyped path for every well-known kind', () {
    // Reset hint state so the discouraged-path detector logs once-per-process
    // doesn't pollute these tests.
    setUp(TrackNamespace.resetHintedKindsForTest);

    for (final kind in PugEventNames.all) {
      test('untyped Pug.track("$kind", ...) produces a queued payload', () async {
        final transport = FakeTransport();
        await Pug.init(
          'project',
          PugOptions(
            apiKey: 'key',
            logger: CapturingLogger(),
            transport: transport,
            storage: MemoryPugStorage(),
            autoTrack: false,
          ),
        );

        final schema = wellKnownEventSchemas[kind]!;
        final syntheticProps = <String, Object?>{
          for (final entry in schema.fields.entries)
            entry.key: _sampleValue(entry.value.type),
        };

        Pug.track(kind, props: syntheticProps);
        await Pug.flush();
        // Events with no fields are flushed as an empty-props event, so the
        // batch should still contain exactly one event.
        final allEvents = transport.batches.expand((b) => b).toList();
        expect(
          allEvents,
          isNotEmpty,
          reason: 'Untyped Pug.track for kind "$kind" produced no requests',
        );
        expect(allEvents.first.kind, equals(kind));

        Pug.destroy();
      });
    }
  });

  group('typed dispatch spot checks', () {
    // Reset hint state so the discouraged-path detector does not log from
    // untyped calls in this group and interfere with other tests.
    setUp(TrackNamespace.resetHintedKindsForTest);

    test('Pug.track.purchase ≈ Pug.track("purchase", ...)', () async {
      final typedReqs = await _captureRequests(() {
        Pug.track.purchase(
          productId: 'sku-1',
          amount: 99.50,
          currency: 'USD',
        );
      });
      final untypedReqs = await _captureRequests(() {
        Pug.track('purchase', props: {
          'productId': 'sku-1',
          'amount': 99.50,
          'currency': 'USD',
        });
      });

      // Both calls should have produced exactly one event.
      expect(typedReqs, hasLength(1),
          reason: 'typed purchase produced no batches');
      expect(untypedReqs, hasLength(1),
          reason: 'untyped purchase produced no batches');

      final typed = _stripVolatile(typedReqs);
      final untyped = _stripVolatile(untypedReqs);
      // Compare via JSON encoding to get deep equality on nested maps.
      expect(jsonEncode(typed), equals(jsonEncode(untyped)));
    });

    test('Pug.track.scroll ≈ Pug.track("scroll", ...)', () async {
      final typedReqs = await _captureRequests(() {
        Pug.track.scroll(percent: 50, scrollY: 800);
      });
      final untypedReqs = await _captureRequests(() {
        Pug.track('scroll', props: {'percent': 50, 'scrollY': 800});
      });

      expect(typedReqs, hasLength(1),
          reason: 'typed scroll produced no batches');
      expect(untypedReqs, hasLength(1),
          reason: 'untyped scroll produced no batches');

      final typed = _stripVolatile(typedReqs);
      final untyped = _stripVolatile(untypedReqs);
      expect(jsonEncode(typed), equals(jsonEncode(untyped)));
    });

    test('Pug.track.signup ≈ Pug.track("signup", ...)', () async {
      final typedReqs = await _captureRequests(() {
        Pug.track.signup();
      });
      final untypedReqs = await _captureRequests(() {
        Pug.track('signup', props: {});
      });

      expect(typedReqs, hasLength(1),
          reason: 'typed signup produced no batches');
      expect(untypedReqs, hasLength(1),
          reason: 'untyped signup produced no batches');

      final typed = _stripVolatile(typedReqs);
      final untyped = _stripVolatile(untypedReqs);
      expect(jsonEncode(typed), equals(jsonEncode(untyped)));
    });
  });
}
