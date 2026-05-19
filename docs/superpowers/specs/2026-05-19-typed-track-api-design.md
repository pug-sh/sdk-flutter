# Typed Track API — Design Spec

- **Date:** 2026-05-19
- **Status:** Awaiting user review of this document
- **Branch:** `feat/typed-track-api`
- **Scope:** Public event-tracking API only. No changes to runtime, queue, transport, sessions, profiles, push, or storage.

## 1. Problem and goal

The public `Pug.track(String kind, {Map<String, Object?> props})` API is fully untyped: event names are arbitrary strings, property bags are open maps, and required fields are not enforced by the compiler. The previous runtime property validation was removed in commit `489f256` (4 days ago), so today there is *no* mechanism — compile-time or runtime — that catches typos, missing required fields, or wrong-typed property values before bytes hit the wire.

Type safety is positioned as the product USP. The `.proto` source of truth at `proto/common/v1/well_known_events.proto` already declares typed messages per event and explicitly states the SDKs "use these to provide autocomplete, compile-time checks, and consistent type/struct hints across languages." Generated Dart classes already exist at `lib/src/gen/common/v1/well_known_events.pb.dart`. The typed shape is in the repo; it is not wired to the public API.

The goal of this design is to deliver compile-time typed event tracking — required fields enforced, value types checked — while preserving the existing untyped path as a discouraged-but-functional escape hatch for custom events and gradual migration.

## 2. Non-goals

- **Client-side `buf.validate` constraint enforcement.** Rules such as `amount > 0`, `currency.length == 3`, and cross-field CEL constraints ("currency required when amount is set") remain server-side until `protovalidate` ships Dart support. Per `TODO.md` line 47, this is an accepted gap.
- **Typed `identify()` traits.** No proto-defined trait schema exists today. Separate decision, separate spec.
- **Migration of `PugEventNames` constants.** They stay — useful for switch/case on event kind and for the discouraged-path detector.
- **Replacing the existing `Pug.track(...)` signature.** This design is purely additive at the public API surface.

## 3. Approach

### 3.1 Call-site shape

A single `Pug.track` member that is both a callable namespace and an object with typed methods:

```dart
// Custom events — unchanged signature
Pug.track('cart_abandoned_v2', props: {'cartId': 'c-1', 'value': 41.0});

// Typed well-known events — codegen'd from the buf catalog
Pug.track.purchase(
  productId: 'sku-1',
  amount: 99.50,
  currency: 'USD',
  extras: {'cohort': 'A'},
);
Pug.track.signup();
Pug.track.scroll(percent: 75, scrollY: 1340);

// Compile error — productId required:
Pug.track.purchase(amount: 99.50);
```

The mechanism is Dart's `call` method: a `_TrackNamespace` class with a `call(...)` method matching the current `Pug.track(String, {props, options})` signature, plus one typed method per well-known event. `Pug.track` becomes a `static final _TrackNamespace` instance. Dart desugars `Pug.track(x)` to `Pug.track.call(x)`, so `Pug.track(...)` and `Pug.track.purchase(...)` both resolve against the same instance.

### 3.2 Catalog source

The TypeScript SDK pulls its catalog from the buf-published package `@buf/fivebits_pug.bufbuild_es` (~75 events). The Flutter SDK currently mirrors a 24-event subset locally; the drift is explicitly accepted in `TODO.md` line 50.

This design closes the gap: Flutter adopts the full buf catalog as the single source of truth.

- **Sync mechanism:** `make sync-protos` runs `buf export buf.build/fivebits/pug --output proto/` to mirror the canonical schemas into `proto/`. The `buf` CLI is the only new tooling requirement.
- **Pinning policy:** the catalog is pinned in `proto/`, updated by an explicit `make sync-protos` invocation. Routine local development (`make protos`) does not re-fetch from the network.
- **TODO.md:** the "accept catalog drift" item moves from accepted to closed.

### 3.3 Codegen

`make typed-track` (also rolled into `make protos`) generates `lib/src/track_namespace.g.dart`. The generator:

1. Reads the generated `*.pb.dart` files under `lib/src/gen/common/...`.
2. Walks message classes whose names end in `Properties`.
3. Maps each class to its event kind via the `<X>Properties` → `snake_case(X)` convention (e.g., `AddToCartProperties` → `add_to_cart`). A small explicit override table in the generator handles renames and any edge case where the convention does not apply.
4. Reads each field's `(buf.validate.field).required = true` annotation from the generated descriptor to decide whether the Dart param is `required` or nullable.
5. Emits one Dart method on `_TrackNamespace` per event.

Generated method conventions:
- **Method name:** snake_case event kind → camelCase (`add_to_cart` → `addToCart`).
- **Field name:** snake_case proto field → camelCase (`product_id` → `productId`).
- **Required:** proto fields marked `(buf.validate.field).required = true` become Dart `required` named params. All others are nullable named params.
- **Always present:** every method has `extras: Map<String, Object?> = const {}` and `options: TrackOptions = const TrackOptions()`.
- **Body:** assembles a `Map<String, Object?>` from non-null named args, merges `extras` (explicit args win on collision), calls `_pug.capture(kind, props: merged, options: options)`.

Generated file is committed to the repo and treated as code (analyzed, formatted, but not hand-edited). One file keeps catalog-change diffs reviewable as a single artifact.

### 3.4 Runtime path

All typed methods land in `PugClient.track(kind, props:)` — the same entry point as the existing `Pug.track`. The queue, transport, sampling, sessions, profile state, and auto-properties are not modified. The typed surface is purely a compile-time projection over the existing runtime.

## 4. Public API surface

| Surface | Behavior |
|---|---|
| `Pug.track('kind', props: {...}, options: ...)` | Custom events; unchanged signature. Resolves via `_TrackNamespace.call(...)`. |
| `Pug.track.<event>(required..., optional..., extras:, options:)` | One per well-known event, codegen'd from the buf catalog. |
| `Pug.track` as a value | Returns the `_TrackNamespace` instance (was: a function reference). See §6. |
| `PugEventNames.*` constants | Unchanged. |
| `wellKnownEventSchemas` map | Unchanged. Used by the discouraged-path detector and reserved for future client-side validation. |

### 4.1 Extras semantics

Every typed method accepts `extras: Map<String, Object?>` for ad-hoc properties on a well-known event. This mirrors the TypeScript SDK's intersection-type pattern (`WellKnownEventPropsMap[K] & Record<string, JsonValue>`), made explicit by a dedicated parameter.

**Collision policy:** explicit named args take precedence. If a caller writes `purchase(amount: 99.50, extras: {'amount': 42.0})`, the produced event has `amount: 99.50`; the extras entry is dropped, and a debug-level message is logged. This matches the principle of least surprise — the typed contract is authoritative.

### 4.2 Discouraged-path detection

When `Pug.track('purchase', props: {...})` is called with a kind present in `wellKnownEventSchemas`, the SDK emits a one-time-per-process debug-level log via the configured `PugLogger`: *"Pug.track('purchase', ...) — consider Pug.track.purchase(...) for compile-time typed properties."* The default logger (`DebugPrintPugLogger`) routes through Flutter's `debugPrint`, which is suppressed in release builds — so production users see nothing without an explicit opt-in (e.g., supplying a custom `PugLogger` that retains debug output). The call itself proceeds normally; behavior is unchanged.

## 5. Error handling

| Failure | Detection | User experience |
|---|---|---|
| Missing required field on a typed method | Compile-time | Dart analyzer error at call site |
| Wrong-typed value on a typed method | Compile-time | Dart analyzer error at call site |
| Extras key collides with an explicit named arg | Runtime | Explicit arg kept; extras key dropped; debug log |
| Extras value of unsupported type | Runtime | Existing `PropertyMapper` drops with warning |
| Known event kind used via untyped track | Runtime | Debug-only log; production silent |
| Custom event kind | None / runtime | Existing behavior; `PropertyMapper` coerces |

The CLAUDE.md invariant *"All public SDK calls are best-effort and must never throw"* is preserved everywhere except at compile time, where errors prevent the binary from being built at all.

## 6. Backward compatibility

- **Call-site syntax:** `Pug.track('x', props: {...}, options: ...)` is unchanged.
- **Tear-off behavior:** `final fn = Pug.track;` previously yielded a function reference; it now yields the `_TrackNamespace` instance. Invoking `fn('x', props: {...})` still works (via `call`). Assignments to an explicit function type (`void Function(String, {Map<String, Object?> props}) fn = Pug.track;`) break and must change to `Pug.track.call`. This is a minor type-level break; the changelog will document it.
- **`PugEventNames`** and `wellKnownEventSchemas`: unchanged.
- **Existing tests** for `Pug.track('purchase', props: {...})` keep passing untouched.

## 7. Testing strategy

- **Golden equivalence tests, one per typed method.** For each well-known event, assert that `Pug.track.<event>(...)` produces a queued event byte-identical to the legacy `Pug.track('<event>', props: {...})` equivalent. The loop is driven by the codegen catalog itself; no per-event test maintenance.
- **Compile-fail tests.** A small `test/compile_fail/` directory contains `.dart` files with `// expect_error:` markers and a script that runs `dart analyze` and asserts the expected errors fire. Verifies that omitting `productId` from `purchase` fails to compile.
- **Collision behavior test.** `purchase(amount: 99.50, extras: {'amount': 42.0})` produces `amount: 99.50`, drops the extras entry, logs at debug.
- **Discouraged-path log test.** Calling `Pug.track('purchase', props: {...})` under a debug-level logger emits the one-time hint exactly once per process; production-level logger emits nothing.
- **Tear-off type test.** `final fn = Pug.track; fn('x', props: {...});` continues to produce a queued event.
- **Existing test suite** must continue to pass unchanged.

## 8. Codegen mechanics

- **Trigger:** `make typed-track` (also part of `make protos`).
- **Input:** generated `*.pb.dart` files plus the source `.proto` files (for the `// kind:` comments).
- **Output:** `lib/src/track_namespace.g.dart`, committed to the repo.
- **Drift detection:** CI runs `make typed-track && git diff --exit-code` to ensure the committed generated file matches the protos.
- **Override table:** a small Dart map in the generator script handles edge cases (e.g., if a proto field name collides with a Dart reserved word, the generator emits an annotated alternative).

## 9. Documentation

- Update `README.md` to lead with the typed surface and demote the untyped path to "for custom or dynamic event names."
- Update `CLAUDE.md`:
  - Public API section adds `Pug.track.<event>` namespace.
  - "Remaining gaps" loses the catalog-drift entry.
- Update `TODO.md`:
  - Close the catalog-drift item.
  - Add a new "Completed" entry for the typed-track API.

## 10. Roll-out

Single PR on the `feat/typed-track-api` branch, since:
- All changes are additive at the public surface.
- Backward compatibility is preserved (modulo the documented tear-off type break).
- Codegen and call-site adoption land together to keep one coherent diff.

No feature flag is needed; the typed surface is opt-in by virtue of being a new entry point.

## 11. Open questions

None at design time. Sub-decisions during implementation (e.g., exact override-table contents for ambiguous event-name → message mappings) are implementation details handled in the plan.
