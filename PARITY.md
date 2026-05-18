# Pug Flutter SDK Parity With `../cotton-web-sdk`

This document compares the Flutter SDK in this repository with the sibling web SDK at `../cotton-web-sdk`.

The goal is product-semantic parity where it makes sense for mobile. Browser-only behavior should not be copied directly unless there is a native mobile equivalent that is reliable, expected, and low-risk for host apps.

## Summary

| Area                        | Web SDK                                                     | Flutter SDK                                                                 | Parity                      |
| --------------------------- | ----------------------------------------------------------- | --------------------------------------------------------------------------- | --------------------------- |
| Singleton lifecycle         | `init`, `destroy`, `reset`, `rotate`                        | `Pug.init`, `Pug.destroy`, `Pug.reset`, `Pug.rotate`, `Pug.flush`          | Complete (+ explicit flush) |
| Manual event tracking       | `track(kind, props?, opts?)`                                | `Pug.track(kind, props:, options:)`                                         | Complete                    |
| Public API edge cases       | Repeated `init()` warns/no-ops; `identify()` before init warns/no-ops | Same                                                                        | Complete                    |
| Identify/profile merge      | First identify sends anonymous ID; later calls omit it      | Same anonymous-merge behavior                                                | Complete                    |
| Sessions                    | Lazy resolve, idle/max expiry, rotate/reset                 | Same mobile semantics                                                        | Complete                    |
| Device ID                   | Push device-ID key, used for push identity/linking          | Project-scoped device-ID key, preserved across session rotation              | Complete                    |
| Persistent storage          | `localStorage` with memory fallback                         | `SharedPreferencesPugStorage` default, with memory fallback                  | Complete                    |
| Queue semantics             | Two-phase lock/commit/rollback                              | Two-phase lock/commit/rollback                                               | Complete                    |
| Batching                    | Size/timer flush, immediate sends                           | Size/timer flush, immediate sends                                            | Complete                    |
| Transport                   | Connect-compatible protobuf HTTP                            | Connect-compatible protobuf HTTP                                             | Complete                    |
| API key transport           | `x-api-key`; beacon uses query param                        | `x-api-key`                                                                  | Complete for normal HTTP    |
| Shutdown delivery           | `sendBeacon` on unload                                      | Best-effort async flush on background/destroy                                | Mobile equivalent           |
| Well-known events           | 21 names typed/validated at runtime                         | 24 names mirrored in schemas + `PugEventNames` constants                     | Flutter ahead, validation gap remains |
| Property mapping            | Typed protobuf values, schema-aware known props             | Typed protobuf values, loose property mapping                                | Partial                     |
| Wire validation             | Client-side request validation                              | No full client-side request validation                                       | Partial                     |
| Sampling                    | `samplingRate` clamped at init, not yet enforced            | `samplingRate` enforced per event                                            | Flutter ahead               |
| Logging & DI                | Fixed console logger, no DI seams                           | Injectable + crash-safe logger, full DI                                      | Flutter ahead               |
| Auto properties             | Browser URL/referrer/title/screen/locale/UA/UTM             | Mobile app/device/screen/network/locale/campaign                             | Mobile equivalent           |
| Campaign/UTM capture        | Current page URL query params                               | Initial/later app links and deep links                                       | Mobile equivalent           |
| Auto page views             | `page_view` from History API/popstate                       | `page_view` via `PugRouteObserver()` when host app registers it              | Mobile equivalent           |
| Auto clicks                 | DOM click listener                                          | Not automatic                                                                | Intentionally omitted       |
| Auto scroll                 | DOM/window scroll tracker                                   | Not automatic                                                                | Intentionally omitted       |
| Auto forms                  | DOM form/input tracker                                      | Not automatic                                                                | Intentionally omitted       |
| Frustration signals         | `rage_click`, `dead_click`                                  | Not automatic                                                                | Intentionally omitted       |
| Push subscription           | Optional web-push/VAPID module                              | Provider-neutral push API                                                    | Mobile equivalent           |
| Notification click tracking | Service worker + page helper                                | Explicit mobile notification helper hooks (received/clicked/dismissed)       | Mobile equivalent (+ more)  |
| Package optionality         | Push is tree-shakeable and optional                         | Core package is provider-neutral; FCM lives in separate package              | Complete                    |

## Public API

### Web

`../cotton-web-sdk/src/pug.ts` exports:

- `init(projectId, options)` — throws on empty `projectId`/`apiKey`
- `track(kind, props?, opts?)` — never throws
- `identify(externalId, traits?)` — throws on invalid input and re-throws transport errors
- `reset()`
- `rotate()`
- `destroy()`

### Flutter

`lib/src/pug.dart` exposes:

- `Pug.init(projectId, options)` — asynchronous; throws on invalid input or init failure; repeated init warns/no-ops
- `Pug.track(kind, props:, options:)` — never throws
- `Pug.identify(externalId, traits:)` — asynchronous; throws on invalid input or transport failure; warns/no-ops before init
- `Pug.reset()`
- `Pug.rotate()`
- `Pug.flush()` — Flutter-only public API
- `Pug.destroy()`

`lib/src/push.dart` exposes provider-neutral push helpers through `PugPush`.

**Parity note:** Dart cannot match TypeScript's overloaded `TrackFn` and `WellKnownEventPropsMap` ergonomics directly. Flutter exposes `PugEventNames` constants, but not typed prop overloads. Also, the current web SDK code only types and validates 21 well-known event names in `src/well-known-events.ts`, while Flutter mirrors 24 names from `lib/src/events.dart`.

## Initialization And Lifecycle

Web `init()` configures session/profile state, creates the batched transport, warms UA data, and installs browser auto-trackers. `destroy()` removes tracker cleanups, destroys transport state, clears persisted identity/session state, and allows re-init.

Flutter `Pug.init()` asynchronously prepares shared-preferences storage and system auto-properties, then starts `PugClient`. `destroy()` cancels timers, starts a best-effort final flush, disposes queue state, removes lifecycle observation, stops campaign link listening, and clears persisted SDK state.

**Parity status:** Complete, with mobile lifecycle substitutions.

## Event Creation

Both SDKs build protobuf `sdk.events.v1.Event` payloads with event ID, kind, session ID, distinct ID, occurrence time, custom properties, and auto-properties.

Important differences:

- Web validates 21 well-known events against generated schemas and preserves schema scalar types for known fields.
- Flutter currently does not validate well-known events against the mirrored schema registry. `PropertyMapper.mapEventProperties(...)` delegates directly to loose `mapProperties(...)`, so known-field type rules, required fields, and range constraints are not enforced client-side.
- Flutter currently treats three names as well-known that the web SDK does not yet type/validate in code: `checkout_completed`, `login`, and `logout`.

Strings are truncated to 1024 UTF-8 bytes in Flutter. The shared proto limit is 1024 codepoints, so Flutter is conservative but not byte-for-byte identical to web behavior.

**Parity status:** Partial.

## Auto Properties

### Web Auto Properties

The web SDK includes browser-oriented auto-properties such as:

- `$projectId`
- `$url`
- `$referrer`
- `$locale`
- `$screenWidth`
- `$screenHeight`
- `$pageTitle`
- `$sdkVersion`
- UA client hints where available
- UTM params from the current URL

### Flutter Auto Properties

The Flutter SDK includes mobile-oriented auto-properties such as:

- `$projectId`
- `$sdkVersion`
- `$platform`
- `$os`
- `$osVersion`
- `$locale`
- `$timezone`
- `$screenWidth`
- `$screenHeight`
- `$screenScale`
- `$appName`
- `$appPackage`
- `$appVersion`
- `$appBuild`
- `$deviceManufacturer`
- `$deviceModel`
- `$deviceName` where available
- `$networkType`

Campaign auto-properties are captured from app/deep links and persisted:

- `$utmSource`
- `$utmMedium`
- `$utmCampaign`
- `$utmTerm`
- `$utmContent`
- `$gclid`
- `$fbclid`
- `$msclkid`
- `$ttclid`

**Parity status:** Mobile equivalent.

## Sessions And Identity

Both SDKs:

- lazily resolve sessions on event creation
- default to 30 minute idle timeout and 1440 minute max duration
- rotate sessions while preserving device ID
- reset both session and device identity
- use anonymous profile IDs prefixed with `anon-`
- send anonymous ID only on the first successful identify merge
- persist external ID for future events

Flutter stores state under project-scoped keys for session, profile, device ID, external ID, queue, and campaign context.

**Parity status:** Complete.

## Queue And Transport

Both SDKs:

- queue events before sending
- flush by batch size and max wait
- support immediate sends
- use lock/commit/rollback for in-flight batches
- drop permanent failures and roll back transient failures
- send binary protobuf payloads to Connect-compatible endpoints
- send API keys with `x-api-key`

The transport RPC paths are shared:

- `/sdk.events.v1.EventsService/BatchCreate`
- `/sdk.profiles.v1.ProfilesSDKService/Identify`
- `/sdk.devices.v1.DevicesService/Subscribe`

Web uses `navigator.sendBeacon` during unload. Flutter uses best-effort async flush on background/destroy.

**Parity status:** Complete for normal transport; mobile equivalent for shutdown.

## Error Handling And Resilience

Compared with the web SDK:

- `track()`, `reset()`, `rotate()`, `flush()`, `destroy()`, and `PugPush` helpers are best-effort and catch/log failures.
- `Pug.init()` matches web on invalid-input throwing and repeated-init warn/no-op behavior.
- `Pug.identify()` matches web on invalid-input throwing, transport-failure propagation, and pre-init warn/no-op behavior.
- `SafePugLogger` prevents a buggy caller-supplied logger from crashing the app.
- `SafePugStorage` falls back to in-memory storage if persistence fails.

**Parity status:** Complete for public API edge cases. Remaining mismatches are elsewhere in validation and transport details.

## Behavioral Differences

1. **Queue persistence cadence.** Web debounces `localStorage` writes; Flutter persists synchronously on `push`, `lock`, `commit`, and `rollback`.
2. **Retry backoff.** Web retries at fixed `maxWaitMs`; Flutter doubles once with `max(maxWaitMs, 1000) * 2`.

## Auto Tracking

### Implemented In Web

The web SDK auto-tracks:

- `page_view`
- `click`
- `scroll`
- `form_start`
- `form_submit`
- `rage_click`
- `dead_click`

### Implemented In Flutter

The Flutter SDK auto-tracks:

- `app_open`
- `app_close`
- `page_view` via `PugRouteObserver`, when the host app registers that observer with `Navigator`

### Not Ported To Flutter

The DOM-centric trackers are intentionally not copied. Mobile UI instrumentation would be invasive and brittle without explicit host-app participation.

**Parity status:** Intentional mobile divergence for DOM-centric trackers. Screen/page-view parity is implemented through route observation.

## Push And Notifications

### Web

The web SDK exposes optional push helpers for VAPID/service-worker-based web push.

### Flutter

The Flutter SDK exposes provider-neutral APIs:

- `PugPush.subscribe(provider, options:)`
- `PugPush.unsubscribe(provider)`
- `PugPush.trackNotificationOpened(data)`
- `PugPush.trackNotificationReceived(data)`
- `PugPush.trackNotificationDismissed(data)`

The core package is provider-neutral. FCM support now lives in the separate `pug_flutter_fcm` package.

**Parity status:** Mobile equivalent, and ahead in helper surface area.

## Well-Known Event Catalog Drift

The sibling web SDK's README lists 24 well-known events, but the current code in `../cotton-web-sdk/src/well-known-events.ts` only includes 21:

- `checkout_completed` is not present in the web runtime schema map.
- `login` is not present in the web runtime schema map.
- `logout` is not present in the web runtime schema map.

Flutter already mirrors all 24 names in `lib/src/events.dart` and `lib/src/well_known_events.dart`.

**Parity status:** Flutter is ahead on mirrored event names, but still behind on runtime validation behavior.

## Wire Validation

The shared proto contract carries `buf.validate` rules for field constraints and message-level CEL expressions.

- The **web SDK** validates outbound requests client-side before sending.
- The **Flutter SDK** does not currently run client-side protovalidate checks for full `Event`, `IdentifyRequest`, or `SubscribeRequest` payloads because `protovalidate` does not currently support Dart.
- Flutter also does not currently enforce the mirrored well-known event schemas at `track()` time, including the 21 names the web SDK currently validates.

Consequence: malformed payloads are rejected server-side rather than failing fast in the SDK.

**Parity status:** Accepted divergence.

## Where Flutter Exceeds The Web SDK

- Sampling is actually enforced.
- Logging, storage, transport, clock, ID generation, and link capture are injectable.
- `SafePugStorage` provides first-class persistence fallback.
- Push is provider-neutral in core.
- Flutter exposes received/clicked/dismissed notification helpers.
- Flutter has richer device/app/network auto-properties.
- Flutter exposes explicit `Pug.flush()`.

## Web-Only Features With No Mobile Analogue

Correctly not implemented in Flutter:

- multi-tab coordination
- `navigator.sendBeacon`
- high-entropy UA client hints
- service-worker registration
- `history.pushState` / `replaceState` patching

## Remaining Gaps

Severity: **High** = analytics correctness/coverage, **Medium** = behavior or DX mismatch, **Low** = language/platform limitation.

| # | Gap | Web | Flutter status | Severity |
|---|---|---|---|---|
| 1 | Screen/page-view auto-tracking | `page_view` auto-emitted on init + history nav | `page_view` auto-emitted via `NavigatorObserver` when `autoPageViews: true` | Closed (High) |
| 2 | Screen/route context on events | `$url`, `$referrer`, `$pageTitle` auto-properties | `url` and `referrer` are attached to `page_view` events only | Low-Medium |
| 3 | Install referrer / deferred attribution | n/a | Link-open UTM is captured; install-referrer / deferred deep-link attribution is not | Low-Medium |
| 4 | Compile-time typed event props | `WellKnownEventPropsMap` + overloaded `TrackFn` | Constants only; no compile-time prop typing | Low |
| 5 | DOM interaction auto-trackers | Installed by `autoTrack` | Schemas exist, no trackers | Low |
| 6 | Hard delivery guarantee on app kill | `navigator.sendBeacon` on `pagehide` | Best-effort `flushAll()` only | Low |
| 7 | Package-level FCM optionality | Push is tree-shakeable and optional | FCM moved to `pug_flutter_fcm` | Closed (Low-Medium) |
## Compatibility Notes

The Flutter SDK currently supports:

- Dart `>=3.7.0 <4.0.0`
- Flutter `>=3.29.0`

## Maintenance Checklist

When changing parity-sensitive behavior:

- Update this document.
- Update `TODO.md` if a gap is closed or a new gap is accepted.
- Add tests in `test/pug_flutter_sdk_test.dart` for shared semantics or mobile substitutions.
- Prefer injected fakes for platform features.

## Source Of Evidence

- **Flutter SDK** — audited against `lib/src/*.dart`, `lib/pug_flutter_sdk.dart`, `proto/**`, and `test/pug_flutter_sdk_test.dart` at commit `51857f1`. Generated code under `lib/src/gen/` was excluded.
- **Web SDK** — spot-checked against `../cotton-web-sdk/src/*.ts` at commit `9ebd5c2`, including `pug.ts`, `track.ts`, `well-known-events.ts`, `session.ts`, and `push.ts`.
- **Shared backend contract** — both SDKs target `sdk.events.v1.EventsService/BatchCreate`, `sdk.profiles.v1.ProfilesSDKService/Identify`, and `sdk.devices.v1.DevicesService/Subscribe`, with `buf.validate` rules carried in `proto/**`.
