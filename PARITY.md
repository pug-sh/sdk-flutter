# Pug Flutter SDK Parity With `../sdk-web`

This document compares the Flutter SDK in this repository with the sibling web
SDK at `../sdk-web`.

The goal is product-semantic parity where it makes sense for mobile. Browser-only
behavior should not be copied directly unless there is a native mobile equivalent
that is reliable, expected, and low-risk for host apps.

Both SDKs generate their typed event catalog from the same buf source
(`buf.build/fivebits/pug`), platform-filtered per event.

## Summary

| Area | Web SDK | Flutter SDK | Parity |
| --- | --- | --- | --- |
| Singleton lifecycle | `init`, `destroy`, `reset`, `rotate` | `Pug.init/destroy/reset/rotate/flush` | Complete (+ explicit flush) |
| Manual event tracking | `track(kind, props?, opts?)` | `Pug.track(kind, props:, options:)` | Complete |
| Typed event API | `track()` + `WellKnownEventPropsMap` types | `Pug.track.<event>(...)` codegen'd methods, required fields compile-time enforced | Complete (different mechanism) |
| Public API edge cases | Repeated `init()` warns/no-ops; `identify()` before init warns/no-ops | Same | Complete |
| Identify/profile merge | First identify sends anonymous ID; later calls omit it | Same | Complete |
| Sessions | Lazy resolve, idle/max expiry, rotate/reset | Same | Complete |
| Tracking consent | `optInTracking/optOutTracking/getTrackingConsent/isTrackingEnabled`, `trackingConsent` option, persist | Same API and gating; `TrackingConsentConfig` with persist | Complete |
| Default endpoint | `https://polru.pug.sh` | `https://polru.pug.sh` | Complete |
| Persistent storage | `localStorage` with memory fallback | `SharedPreferencesPugStorage` default, with memory fallback | Complete |
| Queue semantics | Two-phase lock/commit/rollback | Same | Complete |
| Batching | Size/timer flush, immediate sends | Same | Complete |
| Transport | Connect-compatible protobuf HTTP, `x-api-key` | Same | Complete |
| Well-known event catalog | 119 names (4 DOM-only) | 123 names (8 mobile-only); **115 shared** | Complete (platform-filtered) |
| Property mapping | Schema-aware coercion for known fields in `track()` | Compile-time field types via typed API; loose for untyped/extras | Equivalent for typed calls |
| Wire validation | Client-side protovalidate | None (protovalidate has no Dart support) | Accepted divergence |
| Sampling | None | `samplingRate` enforced per event | Flutter ahead |
| Logging & DI | Fixed console logger, no DI seams | Injectable + crash-safe logger, full DI | Flutter ahead |
| Auto properties | Browser URL/referrer/title/screen/locale/UA/UTM | Mobile app/device/screen/network/locale/timezone/campaign | Mobile equivalent |
| Per-event screen context | `$url`/`$referrer`/`$pageTitle` on every event | `url`/`referrer` on `page_view` only | Low-Medium gap |
| Campaign/UTM capture | URL query params (UTM only) | App/deep links (UTM + gclid/fbclid/msclkid/ttclid) | Mobile equivalent (+ more) |
| Auto page views | `page_view` from History API/popstate | `page_view` via `PugRouteObserver` (host registers it) | Mobile equivalent |
| DOM interaction trackers | click/scroll/form/rage_click/dead_click | Not automatic (no DOM) | Intentional divergence |
| Shutdown delivery | `sendBeacon` on unload | Best-effort flush on background/destroy | Mobile equivalent |
| Push subscription | Web-push/VAPID module | Provider-neutral push API | Mobile equivalent |
| Notification tracking | `notification_clicked` | received/clicked/dismissed helpers | Flutter ahead |
| Package optionality | Push is tree-shakeable | Core is provider-neutral; no provider bundled | Complete |

## Public API

### Web

`../sdk-web/src/pug.ts` exports `init`, `track`, `identify`, `reset`, `rotate`,
`destroy`, and the consent functions `optInTracking`, `optOutTracking`,
`getTrackingConsent`, `isTrackingEnabled`.

### Flutter

`lib/src/pug.dart` exposes the same surface on the `Pug` singleton:
`init`, `track` (callable `TrackNamespace`), `identify`, `reset`, `rotate`,
`flush` (Flutter-only), `destroy`, and `optInTracking`, `optOutTracking`,
`getTrackingConsent`, `isTrackingEnabled`. `lib/src/push.dart` exposes
provider-neutral push helpers through `PugPush`.

**Typed events:** Flutter exposes a typed method per well-known event
(`Pug.track.purchase(...)`) with compile-time required-field and value-type
checking — an ergonomic the web SDK approximates with `WellKnownEventPropsMap`.
The untyped `Pug.track('kind', props:)` escape hatch remains for custom kinds and
emits a debug hint when used with a well-known kind.

## Tracking Consent

Both SDKs gate **all** capture on consent: `track()` (typed and untyped),
`identify()`, and automatic capture are dropped while consent is denied and
resume once granted. Consent defaults to `granted`.

- Configured via `PugOptions.trackingConsent` (`TrackingConsentConfig`):
  `defaultConsent` seeds first-run state; `persist` mirrors opt in/out to
  `__pug_<projectId>_consent__` and restores it on the next `init()`.
- Runtime controls: `Pug.optInTracking()`, `Pug.optOutTracking()`,
  `Pug.getTrackingConsent()`, `Pug.isTrackingEnabled()`.
- Consent is independent of `dryRun`, which suppresses delivery without changing
  consent. `identify()` returns normally (no throw) when consent is denied.

**Parity status:** Complete.

## Event Creation And Property Mapping

Both SDKs build `sdk.events.v1.Event` payloads with event ID, kind, session ID,
distinct ID, occurrence time, custom properties, and auto-properties. Strings are
truncated to 1024 UTF-8 bytes; `null` and non-finite numbers are dropped.

Mapping differs in mechanism:

- **Web** validates a well-known event against its generated schema in `track()`
  and picks the proto scalar oneof from the field type (`scalarToPropertyValue`),
  so an integer-valued double field still serializes as `doubleValue`.
- **Flutter** achieves the same wire types through the **typed** `Pug.track.*`
  layer: Dart parameter types (`double amount`) force the correct oneof at compile
  time. The **untyped** `Pug.track('purchase', props: {'amount': 99})` path uses
  loose runtime mapping (`int` → `intValue`), so it does not schema-coerce known
  fields the way web's `track()` does. `mapEventProperties` does not consult the
  schema registry; that registry is used only to detect well-known kinds.

**Parity status:** Equivalent for typed calls; minor divergence for untyped
well-known calls and client-side validation (see Wire Validation).

## Auto Properties

Verified by diffing the `$`-prefixed keys each SDK emits.

- **Shared (12):** `$projectId`, `$sdkVersion`, `$locale`, `$os`, `$osVersion`,
  `$screenWidth`, `$screenHeight`, `$utmSource`, `$utmMedium`, `$utmCampaign`,
  `$utmContent`, `$utmTerm`.
- **Web-only (7):** `$url`, `$referrer`, `$pageTitle`, and the UA client hints
  `$browser`, `$browserVersion`, `$device`, `$mobile`.
- **Flutter-only (15):** app identity (`$appName`, `$appPackage`, `$appVersion`,
  `$appBuild`), device identity (`$platform`, `$deviceManufacturer`,
  `$deviceModel`, `$deviceName`), context (`$networkType`, `$timezone`,
  `$screenScale`), and campaign click IDs (`$gclid`, `$fbclid`, `$msclkid`,
  `$ttclid`).

The shared core plus each platform's natural extras. Web tags every event with
current `$url`/`$referrer`/`$pageTitle`; Flutter attaches `url`/`referrer` to
`page_view` events only (see Remaining Gaps).

**Parity status:** Mobile equivalent.

## Sessions And Identity

Both SDKs lazily resolve sessions on event creation, default to 30 minute idle /
1440 minute max duration, rotate sessions while preserving device ID, reset both
session and device identity, prefix anonymous IDs with `anon-`, send the anonymous
ID only on the first successful identify merge, and persist the external ID.
Flutter stores state under project-scoped keys for session, profile, device ID,
external ID, queue, campaign, and (when persisted) consent.

**Parity status:** Complete.

## Queue And Transport

Both SDKs queue events, flush by batch size and max wait, support immediate sends,
use lock/commit/rollback for in-flight batches, drop permanent failures and roll
back transient ones, and send binary protobuf to Connect-compatible endpoints with
`x-api-key`. Shared RPC paths:

- `/sdk.events.v1.EventsService/BatchCreate`
- `/sdk.profiles.v1.ProfilesSDKService/Identify`
- `/sdk.devices.v1.DevicesService/Subscribe`

Web uses `navigator.sendBeacon` on unload; Flutter uses best-effort async flush on
background/destroy. Behavioral nuances: web debounces `localStorage` writes while
Flutter persists synchronously on queue mutations; Flutter doubles its retry
backoff once (`max(maxWaitMs, 1000) * 2`).

**Parity status:** Complete for normal transport; mobile equivalent for shutdown.

## Well-Known Event Catalog

Verified by diffing the generated catalogs:

- Web: 119 names. Flutter: 123 names. **115 shared.**
- **Web-only (4):** `click`, `dead_click`, `page_view`, `rage_click` — DOM events
  filtered out of the mobile catalog. (Flutter still emits `page_view` as an
  untyped event via the route observer.)
- **Flutter-only (8):** `app_open`, `app_close`, `app_backgrounded`,
  `app_foregrounded`, `app_install`, `app_update`, `app_crashed`, `screen_view` —
  mobile lifecycle events filtered out of the web catalog.

The differences are intentional platform filtering from the shared buf source, not
a coverage gap. Of the auto-emitted ones, Flutter fires only `app_open`/`app_close`
(and `page_view`); the rest are available as typed methods for manual use.

**Parity status:** Complete (platform-filtered).

## Wire Validation

The shared proto contract carries `buf.validate` rules. The web SDK runs
client-side protovalidate before sending; the Flutter SDK does not, because
`protovalidate` has no Dart support. Malformed payloads are rejected server-side
rather than failing fast in the SDK.

**Parity status:** Accepted divergence.

## Where Flutter Exceeds The Web SDK

- Compile-time typed event props and required-field enforcement via `Pug.track.*`.
- Per-event sampling is actually enforced (web clamps but has no sampler).
- Logging, storage, transport, clock, ID generation, and link capture are injectable; `SafePugStorage`/`SafePugLogger` provide crash-safe fallbacks.
- Richer device/app/network auto-properties and extra campaign click IDs.
- received/clicked/dismissed notification helpers (web has clicked only).
- Explicit `Pug.flush()`.

## Web-Only Features With No Mobile Analogue

Correctly not implemented in Flutter: multi-tab coordination, `navigator.sendBeacon`,
high-entropy UA client hints, service-worker registration, and
`history.pushState`/`replaceState` patching.

## Remaining Gaps

Severity: **High** = analytics correctness/coverage, **Medium** = behavior/DX
mismatch, **Low** = language/platform limitation.

| # | Gap | Web | Flutter status | Severity |
| --- | --- | --- | --- | --- |
| 1 | Screen/route context on events | `$url`/`$referrer`/`$pageTitle` on every event | `url`/`referrer` on `page_view` only; no current-route auto-prop | Low-Medium |
| 2 | URL/PII sanitizer hook | `sanitizeUrl` option, fails closed | None (Flutter emits route names, not URLs) | Low |
| 3 | Client-side wire validation | protovalidate before send | None (no Dart support) | Low |
| 4 | Schema coercion on untyped well-known track | `track()` coerces known fields by schema | Untyped path is loose; use typed `Pug.track.*` for correct types | Low |
| 5 | DOM interaction auto-trackers | click/scroll/form/rage/dead click | No DOM; intentionally omitted | Low (platform) |
| 6 | Install referrer / deferred attribution | n/a | Link-open UTM captured; install-referrer not | Low-Medium |
| 7 | Hard delivery guarantee on app kill | `sendBeacon` on `pagehide` | Best-effort `flushAll()` | Low (platform) |

Closed since the previous revision: tracking consent, the production endpoint
default, compile-time typed event props, and auto page-view tracking.

## Compatibility Notes

- Dart `>=3.7.0 <4.0.0`
- Flutter `>=3.29.0`

## Maintenance Checklist

When changing parity-sensitive behavior:

- Update this document and `TODO.md` if a gap is closed or accepted.
- Add tests in `test/` for shared semantics or mobile substitutions.
- Prefer injected fakes for platform features.

## Source Of Evidence

- **Flutter SDK** — audited against `lib/src/*.dart`, `lib/pug_sdk.dart`, and
  `test/` on the current branch. Generated code under `lib/src/gen/` was excluded.
- **Web SDK** — audited against `../sdk-web/src/*.ts`, including `pug.ts`,
  `track.ts`, `tracking-consent.ts`, `session.ts`, `push.ts`, `parsers.ts`, and
  `well-known-events.generated.ts`.
- **Method** — event-name and auto-property sets were extracted from both
  codebases and diffed directly; semantic claims were checked against source.
- **Shared backend contract** — both SDKs target `BatchCreate`, `Identify`, and
  `Subscribe` with `buf.validate` rules carried in `proto/**`.
