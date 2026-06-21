import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';

import 'test_doubles.dart';

// ---------------------------------------------------------------------------
// File-private helpers for golden equivalence tests (Task 8)
// ---------------------------------------------------------------------------

/// Initialises Pug with a fresh [FakeTransport], runs [act], flushes, then
/// destroys and returns the list of [Event] JSON maps from all batches.
Future<List<Map<String, Object?>>> _captureRequests(void Function() act) async {
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
  await Pug.destroy();
  await Future<void>.delayed(
    Duration.zero,
  ); // drain microtasks from destroy's unawaited flushAll
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

    test(
      'tear-off: assigning Pug.track to a variable still allows invocation',
      () {
        final fn = Pug.track;
        fn('any_event', props: {'a': 1});
        // No exception thrown = pass.
      },
    );
  });

  group('Pug.track.purchase (hand-written reference)', () {
    test(
      'produces a purchase event equivalent to the untyped track call',
      () async {
        // Both calls should produce equivalent queued events. Exact equivalence
        // assertions land in the golden tests (Task 8); here we only check
        // the typed call compiles and runs without throwing.
        Pug.track.purchase(productId: 'sku-1', amount: 99.50, currency: 'USD');
      },
    );

    test(
      'extras key colliding with named arg is dropped with WARN log',
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

        Pug.track.purchase(
          productId: 'sku-1',
          amount: 99.50,
          currency: 'USD',
          extras: {'amount': 42.0, 'cohort': 'A'},
        );
        await Pug.flush();

        // Explicit named arg always wins on collision.
        final events = transport.batches.expand((b) => b).toList();
        expect(events, hasLength(1));
        final props = events.first.customProperties;
        expect(
          props['amount']?.value,
          equals(99.50),
          reason: 'named arg should win over extras',
        );
        expect(
          props['cohort']?.value,
          equals('A'),
          reason: 'non-colliding extras should still merge through',
        );

        // Collision logged at WARN with camelCase method name (not snake_case kind).
        final warnings =
            logger.warnings
                .where(
                  (m) => m.contains(
                    'Pug.track.purchase: extras key "amount" overridden',
                  ),
                )
                .toList();
        expect(
          warnings,
          hasLength(1),
          reason:
              'collision should produce exactly one WARN; got: '
              '${logger.warnings}',
        );
        // And nothing in the WARN message should reference snake_case.
        expect(warnings.first, isNot(contains('add_to_cart')));

        await Pug.destroy();
      },
    );

    test('typed path is best-effort: bad extras values do not throw', () async {
      // CLAUDE.md invariant: public SDK APIs must never throw. The property
      // mapper drops non-finite doubles and unsupported types with a warning.
      // A typed call that mixes good and bad extras should still queue the
      // valid fields.
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

      expect(
        () => Pug.track.purchase(
          productId: 'sku-1',
          amount: 99.50,
          currency: 'USD',
          extras: {'bad': double.nan, 'obj': Object(), 'good': 'kept'},
        ),
        returnsNormally,
      );
      await Pug.flush();

      final events = transport.batches.expand((b) => b).toList();
      expect(events, hasLength(1));
      final props = events.first.customProperties;
      // Valid typed args and valid extras survive.
      expect(props['productId']?.value, equals('sku-1'));
      expect(props['amount']?.value, equals(99.50));
      expect(props['good']?.value, equals('kept'));
      // Bad values are dropped; the mapper warns.
      expect(props.containsKey('bad'), isFalse);
      expect(props.containsKey('obj'), isFalse);
      expect(
        logger.warnings.where((m) => m.contains('dropped unsupported')),
        isNotEmpty,
      );

      await Pug.destroy();
    });
  });

  group('discouraged-path detector', () {
    setUp(TrackNamespace.resetHintedKindsForTest);

    test(
      'logs debug hint when a well-known kind is used via untyped track',
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
        Pug.track(
          'purchase',
          props: {'productId': 'sku-2'},
        ); // second call — no second log

        final hints =
            logger.debugs
                .where((m) => m.contains('consider Pug.track.purchase'))
                .toList();
        expect(hints, hasLength(1));

        await Pug.destroy();
      },
    );

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

      final hints =
          logger.debugs.where((m) => m.contains('consider Pug.track')).toList();
      expect(hints, isEmpty);

      await Pug.destroy();
    });

    test('distinct well-known kinds each get their own hint', () async {
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

      Pug.track('purchase', props: {'productId': 'sku-1'});
      Pug.track('add_to_cart', props: {'productId': 'sku-2'});

      // Two distinct hints, each referencing the camelCase method name.
      expect(
        logger.debugs.where((m) => m.contains('consider Pug.track.purchase(')),
        hasLength(1),
        reason: 'purchase kind should hint Pug.track.purchase',
      );
      expect(
        logger.debugs.where((m) => m.contains('consider Pug.track.addToCart(')),
        hasLength(1),
        reason: 'add_to_cart kind should hint Pug.track.addToCart (camelCase)',
      );

      await Pug.destroy();
    });

    test(
      'hint method names follow camelCase for representative kinds',
      () async {
        // Regression guard: the scaffold's _kindToDartMethodName must match the
        // codegen tool's conversion. If these drift, the hint will reference
        // a method that does not exist on TrackNamespace.
        final cases = <String, String>{
          'purchase': 'purchase', // single word
          'app_open': 'appOpen', // two words
          'add_to_cart': 'addToCart', // three words
          'notification_clicked': 'notificationClicked',
        };
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

        for (final entry in cases.entries) {
          Pug.track(entry.key, props: {});
          expect(
            logger.debugs.where(
              (m) => m.contains('consider Pug.track.${entry.value}('),
            ),
            hasLength(1),
            reason:
                'kind=${entry.key} should hint '
                'Pug.track.${entry.value}; got: ${logger.debugs}',
          );
        }

        await Pug.destroy();
      },
    );

    test(
      'every PugEventNames.all kind produces a valid Dart identifier hint',
      () async {
        // Iterates the full well-known-kind catalog and verifies the scaffold's
        // _kindToDartMethodName (a) emits a syntactically valid Dart identifier
        // and (b) does not collide with another kind. Together these properties
        // are equivalent to "the hint always points at a real method", because
        // the codegen tool uses the same conversion to name the methods.
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

        final identifierRe = RegExp(r'^[a-z][a-zA-Z0-9]*$');
        final extractRe = RegExp(r'consider Pug\.track\.(\w+)\(');
        final hintMethodNames = <String>{};

        for (final kind in PugEventNames.all) {
          Pug.track(kind, props: {});
        }

        for (final kind in PugEventNames.all) {
          // Hint text encodes the kind once, so we can find each kind's hint
          // by scanning the captured debug stream.
          final hint = logger.debugs.firstWhere(
            (m) => m.contains("Pug.track('$kind',"),
            orElse: () => '',
          );
          expect(
            hint,
            isNotEmpty,
            reason: 'No discouraged-path hint emitted for kind=$kind',
          );

          final match = extractRe.firstMatch(hint);
          expect(
            match,
            isNotNull,
            reason: 'Hint malformed for kind=$kind: $hint',
          );
          final methodName = match!.group(1)!;
          expect(
            identifierRe.hasMatch(methodName),
            isTrue,
            reason: 'kind=$kind produced non-identifier "$methodName"',
          );
          expect(
            hintMethodNames.add(methodName),
            isTrue,
            reason: 'kind=$kind produced duplicate method "$methodName"',
          );
        }

        // The set of hint method names should be the same size as the kind set.
        expect(hintMethodNames, hasLength(PugEventNames.all.length));

        await Pug.destroy();
      },
    );
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
      expect(logger.warnings.where((m) => m == 'hello'), isNotEmpty);
      await Pug.destroy();
    });
  });

  // ---------------------------------------------------------------------------
  // Task 8 — Golden equivalence tests
  // ---------------------------------------------------------------------------

  group('golden equivalence: untyped path for every well-known kind', () {
    // Reset hint state so the discouraged-path detector logs once-per-process
    // doesn't pollute these tests.
    setUp(TrackNamespace.resetHintedKindsForTest);
    tearDown(() async {
      await Pug.destroy();
      await Future<void>.delayed(
        Duration.zero,
      ); // drain microtasks from destroy's unawaited flushAll
    });

    for (final kind in PugEventNames.all) {
      test(
        'untyped Pug.track("$kind", ...) produces a queued payload',
        () async {
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

          final schema = wellKnownEventSchemas[kind];
          expect(
            schema,
            isNotNull,
            reason: 'wellKnownEventSchemas is missing entry for "$kind"',
          );
          final syntheticProps = <String, Object?>{
            for (final entry in schema!.fields.entries)
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
        },
      );
    }
  });

  group('typed dispatch spot checks', () {
    // Reset hint state so the discouraged-path detector does not log from
    // untyped calls in this group and interfere with other tests.
    setUp(TrackNamespace.resetHintedKindsForTest);
    tearDown(() async {
      await Pug.destroy();
      await Future<void>.delayed(
        Duration.zero,
      ); // drain microtasks from destroy's unawaited flushAll
    });

    // NOTE: These spot checks compare the Dart-model `Event.toJson()` output
    // (post merge, pre protobuf encode). They do NOT exercise PugProtoCodec or
    // HttpPugTransport. A bug in proto encoding that only manifests on typed
    // calls would not be caught here — that's intentionally the protobuf
    // wire-format layer's responsibility, validated separately at integration
    // test boundaries.

    test('Pug.track.purchase ≈ Pug.track("purchase", ...)', () async {
      final typedReqs = await _captureRequests(() {
        Pug.track.purchase(productId: 'sku-1', amount: 99.50, currency: 'USD');
      });
      final untypedReqs = await _captureRequests(() {
        Pug.track(
          'purchase',
          props: {'productId': 'sku-1', 'amount': 99.50, 'currency': 'USD'},
        );
      });

      // Both calls should have produced exactly one event.
      expect(
        typedReqs,
        hasLength(1),
        reason: 'typed purchase produced no batches',
      );
      expect(
        untypedReqs,
        hasLength(1),
        reason: 'untyped purchase produced no batches',
      );

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

      expect(
        typedReqs,
        hasLength(1),
        reason: 'typed scroll produced no batches',
      );
      expect(
        untypedReqs,
        hasLength(1),
        reason: 'untyped scroll produced no batches',
      );

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

      expect(
        typedReqs,
        hasLength(1),
        reason: 'typed signup produced no batches',
      );
      expect(
        untypedReqs,
        hasLength(1),
        reason: 'untyped signup produced no batches',
      );

      final typed = _stripVolatile(typedReqs);
      final untyped = _stripVolatile(untypedReqs);
      expect(jsonEncode(typed), equals(jsonEncode(untyped)));
    });
  });
}
