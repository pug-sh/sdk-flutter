# Pug Flutter SDK Parity With `../cotton-web-sdk`

This document compares the Flutter SDK in this repository with the sibling web SDK at `../cotton-web-sdk`.

The goal is product-semantic parity where it makes sense for mobile. Browser-only behavior should not be copied directly unless there is a native mobile equivalent that is reliable, expected, and low-risk for host apps.

## Summary

| Area                        | Web SDK                                                     | Flutter SDK                                                                  | Parity                             |
| --------------------------- | ----------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------- |
| Singleton lifecycle         | `init`, `destroy`, `reset`, `rotate`                        | `Pug.init`, `Pug.destroy`, `Pug.reset`, `Pug.rotate`, `Pug.flush`            | Complete (+ explicit flush)        |
| Manual event tracking       | `track(kind, props?, opts?)`                                | `Pug.track(kind, props:, options:)`                                          | Complete                           |
| Best-effort public APIs     | `track()` never throws; `init()`/`identify()` throw         | No public call throws; failures go to the logger                             | Mobile stricter                    |
| Identify/profile merge      | First identify sends anonymous ID; later calls omit it      | Same anonymous-merge behavior                                                | Complete                           |
| Sessions                    | Lazy resolve, idle/max expiry, rotate/reset                 | Same mobile semantics                                                        | Complete                           |
| Device ID                   | Push device-ID key, used for push identity/linking          | Project-scoped device-ID key, preserved across session rotation              | Complete                           |
| Persistent storage          | `localStorage` with memory fallback                         | `SharedPreferencesPugStorage` default, with memory fallback                  | Complete                           |
| Queue semantics             | Two-phase lock/commit/rollback                              | Two-phase lock/commit/rollback                                               | Complete                           |
| Batching                    | Size/timer flush, immediate sends                           | Size/timer flush, immediate sends                                            | Complete                           |
| Transport                   | Connect-compatible protobuf HTTP                            | Connect-compatible protobuf HTTP                                             | Complete                           |
| API key transport           | `x-api-key`; beacon uses query param                        | `x-api-key`                                                                  | Complete for normal HTTP           |
| Shutdown delivery           | `sendBeacon` on unload                                      | Best-effort async flush on background/destroy                                | Mobile equivalent                  |
| Well-known events           | 24 names, generated schemas + TS type overloads             | 24 names, generated schemas + `PugEventNames` constants + runtime validation | Mobile/Dart equivalent             |
| Property mapping            | Typed protobuf values, truncation, schema-aware known props | Typed protobuf values, truncation, schema-aware known props                  | Complete                           |
| Wire validation             | Client-side request validation (e.g. `identify`)            | Well-known event property _types_ only                                       | Partial                            |
| Sampling                    | `samplingRate` clamped at init, not yet enforced (`TODO`)   | `samplingRate` enforced per event                                            | Flutter ahead                      |
| Logging & DI                | Fixed console logger, no DI seams                           | Injectable + crash-safe logger, full DI                                      | Flutter ahead                      |
| Auto properties             | Browser URL/referrer/title/screen/locale/UA/UTM             | Mobile app/device/screen/network/locale/campaign                             | Mobile equivalent                  |
| Campaign/UTM capture        | Current page URL query params                               | Initial/later app links and deep links                                       | Mobile equivalent                  |
| Auto page views             | `page_view` from History API/popstate                       | Not automatic                                                                | Not implemented (High)             |
| Auto clicks                 | DOM click listener                                          | Not automatic                                                                | Intentionally omitted              |
| Auto scroll                 | DOM/window scroll tracker                                   | Not automatic                                                                | Intentionally omitted              |
| Auto forms                  | DOM form/input tracker                                      | Not automatic                                                                | Intentionally omitted              |
| Frustration signals         | `rage_click`, `dead_click`                                  | Not automatic                                                                | Intentionally omitted              |
| Push subscription           | Optional web-push/VAPID module                              | Provider-neutral push API plus FCM provider                                  | Mobile equivalent                  |
| Notification click tracking | Service worker + page helper                                | Explicit mobile notification helper hooks (received/clicked/dismissed)       | Mobile equivalent (+ more helpers) |
| Package optionality         | Push is tree-shakeable and optional                         | Core barrel avoids FCM exports, but package still depends on FCM             | Partial                            |

## Public API

### Web

`../cotton-web-sdk/src/pug.ts` exports:

- `init(projectId, options)` — throws on empty `projectId`/`apiKey`
- `track(kind, props?, opts?)` — never throws
- `identify(externalId, traits?)` — throws on invalid input and re-throws transport errors
- `reset()`
- `rotate()`
- `destroy()`

The web barrel also exports push helpers from `push.ts`.

### Flutter

`lib/src/pug.dart` exposes:

- `Pug.init(projectId, options)` — asynchronous; never throws
- `Pug.track(kind, props:, options:)` — never throws
- `Pug.identify(externalId, traits:)` — asynchronous; never throws
- `Pug.reset()`
- `Pug.rotate()`
- `Pug.flush()` — Flutter-only public API; web has no public flush
- `Pug.destroy()`

`lib/src/push.dart` exposes provider-neutral push helpers through `PugPush`.

**Parity note:** Dart cannot match TypeScript's overloaded `TrackFn` and `WellKnownEventPropsMap` ergonomics directly. Flutter exposes `PugEventNames` constants and performs runtime schema-aware validation instead.

**Parity note:** The Flutter SDK is intentionally stricter than the web SDK on error handling — _no_ public call throws. Web's `init()` and `identify()` surface errors to the caller; Flutter logs them through the configured logger and completes normally. See [Error Handling And Resilience](#error-handling-and-resilience).

## Initialization And Lifecycle

Web `init()` configures session/profile state, warms UA client hints, creates the batched transport, and installs browser auto-trackers. `destroy()` removes tracker cleanups, destroys transport state, clears session/profile runtime state, and allows re-init.

Flutter `Pug.init()` asynchronously prepares shared preferences storage and system auto-properties, then starts `PugClient`. `PugClient.start()` validates config, attaches lifecycle observation, captures campaign links when enabled, emits `app_open` if already foregrounded, and schedules flushing. Invalid config (empty `projectId`/`apiKey`) is logged and the call returns without installing a client. `destroy()` cancels timers, starts a best-effort final flush, disposes queue state, removes lifecycle observation, and stops campaign link listening.

**Parity status:** Complete, with mobile lifecycle substitutions. Note the divergent `destroy()` storage side-effects covered in [Behavioral Differences](#behavioral-differences).

## Event Creation

Both SDKs build protobuf `sdk.events.v1.Event` payloads with:

- fresh event ID
- kind
- top-level session ID
- top-level distinct ID
- occurrence time
- custom properties
- auto-properties

`$projectId` travels as an auto-property; the proto `Event` message has no top-level `project_id` field.

Both SDKs preserve schema scalar types for well-known fields and accept loose extra properties when they can be represented as `PropertyValue`.

Differences:

- Web supports JavaScript `bigint` and maps safe integers to integer values.
- Flutter maps Dart `int` to integer values and finite `num`/`double` to double values.
- Web uses generated TypeScript schema types for compile-time narrowing.
- Flutter uses constants plus runtime validation. A mistyped known field drops the whole event (`PropertyMapper.mapEventProperties` returns `null`); unknown extra properties are still accepted via loose mapping.
- Strings are truncated to 1024 UTF-8 bytes. The shared `property_value.proto` caps `string_value` at 1024 _codepoints_, so Flutter's byte-based truncation is conservative but not an exact match for multi-byte text.

**Parity status:** Complete for backend event semantics.

## Auto Properties

### Web Auto Properties

The web SDK includes browser-oriented auto-properties:

- `$projectId`
- `$url`
- `$referrer`
- `$locale`
- `$screenWidth`
- `$screenHeight`
- `$pageTitle`
- `$sdkVersion`
- UA client hints where available: `$browser`, `$browserVersion`, `$os`, `$osVersion`, `$device`, `$mobile`
- UTM params from the current URL

### Flutter Auto Properties

The Flutter SDK includes mobile-oriented auto-properties:

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

Platform/OS/locale/timezone/screen values are read live on each event; app, device, and network values are read once during `SystemPugAutoPropertyProvider.create(...)` and cached for the process lifetime.

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

**Parity status:** Mobile equivalent. Browser URL, referrer, page title, and UA client hints do not map cleanly to native mobile apps; the Flutter SDK collects richer device/app/network metadata in their place.

## Campaign Capture

Web parses UTM params from `location.search`.

Flutter uses `app_links` through `PugLinkProvider` (`autoCaptureCampaigns`, on by default):

- reads the initial app/deep link on start
- listens for later app/deep links
- extracts UTM params and click IDs (`gclid`/`fbclid`/`msclkid`/`ttclid`)
- stores the latest campaign context under `__pug_<projectId>_campaign__`
- attaches campaign fields to later events as auto-properties

Host apps must still configure platform deep linking, such as Android App Links, iOS Universal Links, or a custom URL scheme.

**Parity status:** Mobile equivalent for link-open attribution. Deferred install-referrer attribution is not implemented.

## Sessions And Identity

Both SDKs:

- lazily resolve sessions on event creation
- default to 30 minute idle timeout and 1440 minute max duration
- rotate sessions while preserving device ID
- reset both session and device identity
- use anonymous profile IDs prefixed with `anon-`
- send anonymous ID only on the first successful identify merge
- persist external ID for future events

The Flutter SDK keeps state under six project-scoped storage keys: `__pug_<projectId>_session__`, `__pug_<projectId>_profile__`, `__pug_<projectId>_device_id__`, `__pug_<projectId>_external_id__`, `__pug_<projectId>_queue__`, and `__pug_<projectId>_campaign__`. The device ID lives in its own key (the source of truth) and is also copied into session state; `rotate()` preserves it, `reset()` rotates it.

Web additionally has browser cross-tab session coordination (a `tabs` registry, heartbeats, and "all tabs closed → rotate session"). Flutter does not need that behavior because mobile is single-process.

`identify()` device-linking differs between the SDKs — see [Behavioral Differences](#behavioral-differences).

**Parity status:** Complete for mobile.

## Queue And Transport

Both SDKs:

- queue events before sending
- flush by batch size and max wait
- support immediate sends
- use lock/commit/rollback for in-flight batches
- drop permanent failures and roll back transient failures
- send binary protobuf payloads to Connect-compatible endpoints
- send API keys with `x-api-key`

Defaults match: `BatchConfig` 10 / 5000 ms / 1000, `SessionConfig` 30 min / 1440 min. Neither SDK has a byte-size batch cap.

Web additionally uses `navigator.sendBeacon` during page unload and puts the API key in a query param for beacon requests because beacon cannot carry headers. Flutter performs best-effort async flush on background and destroy.

The transport RPC paths are shared:

- `/sdk.events.v1.EventsService/BatchCreate`
- `/sdk.profiles.v1.ProfilesSDKService/Identify`
- `/sdk.devices.v1.DevicesService/Subscribe`

`HttpPugTransport` sets `connect-protocol-version: 1` and `content-type: application/proto` explicitly; the web SDK relies on `@connectrpc/connect-web` to add them. The Flutter push path reuses the shared transport; the web SDK builds its own.

**Parity status:** Complete for normal transport; mobile equivalent for shutdown. Error classification and persistence cadence differ — see [Behavioral Differences](#behavioral-differences).

## Error Handling And Resilience

The Flutter SDK treats _every_ public entry point as best-effort:

- `track()`, `init()`, `identify()`, `reset()`, `rotate()`, `flush()`, `destroy()`, and the `PugPush` helpers all catch their own failures and report them through the configured logger instead of throwing.
- Invalid input (empty `projectId`/`apiKey`/`externalId`) is logged and the call returns; the web SDK throws in the equivalent cases.
- `SafePugLogger` wraps the caller-supplied logger so a buggy custom logger cannot crash the host app — if the delegate throws, it falls back to `debugPrint`.
- `SafePugStorage` wraps the primary store and transparently fails over to in-memory storage if persistence throws.
- Stored session/profile/queue/campaign JSON that fails to decode is logged and treated as absent rather than propagated.
- `FcmPushProvider` returns an empty token / a "not supported" `NotificationSettings` sentinel on failure rather than throwing.

`PugException` remains defined in `lib/src/errors.dart` but is no longer thrown anywhere in the SDK. `PugTransportException` is still used internally by the transport layer to carry permanent-vs-transient classification.

**Parity status:** Mobile stricter. This is a deliberate divergence: a mobile analytics SDK should never be able to crash its host app, even on misuse.

## Behavioral Differences

Both SDKs do the same job, but some mechanics differ in ways that can surprise:

1. **Public-API throwing.** Web `init()`/`identify()` throw on invalid input and `identify()` re-throws transport errors; web `track()` never throws. Flutter makes _all_ public calls non-throwing (see above). Consequence: web callers can `try/catch` an identify failure; Flutter callers must read the logger.
2. **`destroy()` storage side-effects.** Web `destroy()` wipes persisted session, tabs, profile, and external-id state. Flutter `destroy()` only disposes the runtime and persists the queue — it _keeps_ session/profile/external-id/device/campaign state. Consequence: on web, `destroy()` then re-`init()` starts a fresh identity; on Flutter it resumes the prior identity and session. For mobile this is arguably the better default, but it is not parity.
3. **Error-classification space.** Web classifies permanent-vs-transient by **gRPC code** (`{3, 5, 6, 7, 9, 12, 16}`). Flutter classifies by **HTTP status** (`{400, 401, 403, 404, 409, 412, 422, 501}`). These are semantically aligned (InvalidArgument↔400, Unauthenticated↔401, PermissionDenied↔403, NotFound↔404, AlreadyExists↔409, FailedPrecondition↔412, Unimplemented↔501) but not mechanically identical.
4. **Unexpected (non-typed) errors.** Web treats an untyped error as **permanent** and drops the batch, deliberately defending against poison events. Flutter treats it as **transient** and retries with backoff. Flutter's poison-event exposure is lower because properties are validated at `track()` time before reaching the queue.
5. **`identify()` device linking.** Web sends `deviceId` only on the _first_ identify, sourced from its push device-ID key. Flutter sends `deviceId` on _every_ identify, sourced from `__pug_<projectId>_device_id__`. Note: `profiles.proto` documents that `device_id` should be sent "on first identify and on account switch — not on every call, to avoid unnecessary DB writes," so Flutter currently over-sends relative to the documented contract.
6. **Queue persistence cadence.** Web debounces `localStorage` writes (committing immediately only on lock/commit/rollback). Flutter persists synchronously on every `push`, `lock`, `commit`, and `rollback`. Flutter is more durable per-event; web is cheaper under burst.
7. **Retry backoff.** Web retries at a fixed `maxWaitMs` interval. Flutter does one doubling step (`max(maxWaitMs, 1000) * 2`) on transient failure. Neither is true exponential backoff.

## Auto Tracking

### Implemented In Web

The web SDK installs browser trackers during `init()`:

- `page_view`
- `click`
- `scroll`
- `form_start`
- `form_submit`
- `rage_click`
- `dead_click`

### Implemented In Flutter

The Flutter SDK intentionally keeps mobile auto tracking conservative:

- `app_open`
- `app_close`

These are driven by a `WidgetsBindingObserver` lifecycle FSM with a foreground flag that de-dupes open/close. Background transitions also flush the queue even when `autoTrack` is disabled.

### Not Ported To Flutter

The browser trackers are not copied because mobile has different UX, routing, privacy expectations, and widget architecture. Automatically observing every tap, form field, scroll, or "dead click" equivalent in Flutter would be invasive and brittle without explicit app instrumentation. The well-known schemas for these events still exist, so host apps can emit them manually.

Potential future mobile APIs:

- explicit `Pug.trackScreen(name, properties?)`
- route observer integration for screen views
- optional app-provided UI instrumentation hooks

**Parity status:** Intentional mobile divergence, except for screen/page views — see [Remaining Gaps](#remaining-gaps).

## Push And Notifications

### Web

The web SDK exposes optional push helpers:

- `subscribePush(vapidPublicKey, options)`
- `unsubscribePush(options?)`
- `setupNotificationClickTracking(track)`

Push relies on web push subscriptions, service workers, and VAPID.

### Flutter

The Flutter SDK exposes provider-neutral APIs:

- `PugPush.subscribe(provider, options:)`
- `PugPush.unsubscribe(provider)`
- `PugPush.trackNotificationOpened(data)`
- `PugPush.trackNotificationReceived(data)`
- `PugPush.trackNotificationDismissed(data)`

It includes an FCM provider in `pug_flutter_fcm.dart`. Push registration calls `Subscribe`; neither SDK de-registers the device server-side on unsubscribe (the `DevicesService.UpdateStatus`/`UpdateToken` RPCs are not used by either client).

Notification event names align:

- `notification_received`
- `notification_clicked`
- `notification_dismissed`

Both SDKs default missing `campaignId` on notification clicks to `(unknown)`. Notification payloads are sanitized to flat strings, booleans, finite numbers, and timestamps.

**Parity status:** Mobile equivalent, and ahead in surface area — the web SDK ships only the click helper, while Flutter ships received/clicked/dismissed. Dependency-level optionality is partial because the Flutter package still depends on `firebase_messaging`; a separate FCM package would be needed for full optionality.

## Wire Validation

The shared proto contract (`proto/**/*.proto`) carries `buf.validate` rules: field constraints (`required`, `string.uuid`, string length, numeric ranges, `repeated.max_items`) and message-level CEL expressions (event `kind` must not start with `pug.`, `auto_properties` keys must start with `$`, `custom_properties` keys must not).

- The **web SDK** validates outbound requests client-side before sending (confirmed for `IdentifyRequest`, which throws on invalid input).
- The **Flutter SDK** validates only well-known event property _types_ at `track()` time, against the hand-mirrored `wellKnownEventSchemas` registry. It does not run a protovalidate pass over the full `Event`, `IdentifyRequest`, or `SubscribeRequest`, does not enforce value constraints (ranges, lengths, `required`, CEL rules), and does not reject `custom_properties` keys that begin with `$`. There is no protovalidate runtime in the Dart dependency graph.

Consequence: malformed `identify`/`subscribe` payloads are caught server-side rather than failing fast on the client.

**Parity status:** Partial. Tracked as gap #3.

## Where Flutter Exceeds The Web SDK

- **Sampling is actually enforced.** `_sampledIn()` gates `track()`. The web SDK only clamps `samplingRate` at init and has an explicit `TODO(sampling)` no-op.
- **Injectable, crash-safe logging.** `PugLogger` with `NoopPugLogger`/`DebugPrintPugLogger`, all wrapped in `SafePugLogger`. Web logging is a fixed `console` wrapper with no hook.
- **Full dependency injection.** `PugOptions` accepts `transport`, `storage`, `autoPropertyProvider`, and `linkProvider`; `PugClient` also takes `clock` and `idGenerator`. The web SDK exposes no DI seams.
- **`SafePugStorage`** — a first-class storage wrapper that fails over to memory; web has only scattered per-call `try/catch`.
- **Provider-neutral push** — a `PushProvider` abstraction with FCM built in; web is Web Push/VAPID only.
- **All three notification helpers** (received/clicked/dismissed); web ships only the click helper.
- **Richer device/app auto-properties** — `$appName`/`$appPackage`/`$appVersion`/`$appBuild`, `$deviceManufacturer`/`$deviceModel`/`$deviceName`, `$networkType`, `$timezone`, `$screenScale`.
- **Explicit `Pug.flush()`** public API.
- **All public APIs non-throwing** — web's `init()`/`identify()` throw.

## Web-Only Features With No Mobile Analogue

Correctly _not_ implemented in Flutter:

- **Multi-tab coordination** — tab registry, heartbeats, "all tabs closed → rotate session". Mobile is single-process.
- **`navigator.sendBeacon`** — no Flutter equivalent; the closest is the `immediate` `app_close` event plus the background flush.
- **High-entropy UA client hints** — mobile exposes OS/locale/device directly via `Platform`, `defaultTargetPlatform`, and `device_info_plus`.
- **Service-worker registration** — FCM (Android) / APNs (iOS) provide the server-to-device path instead.
- **`history.pushState`/`replaceState` patching** — Flutter routing would be observed via `NavigatorObserver` if screen-view tracking lands.

## Remaining Gaps

Severity: **High** = changes analytics correctness/coverage; **Medium** = DX or durability foot-gun; **Low** = web-specific or language-limited.

| #   | Gap                                                                                     | Web                                               | Flutter status                                                                                 | Severity                                  |
| --- | --------------------------------------------------------------------------------------- | ------------------------------------------------- | ---------------------------------------------------------------------------------------------- | ----------------------------------------- |
| 1   | Screen/page-view auto-tracking                                                          | `page_view` auto-emitted on init + history nav    | `page_view` auto-emitted via `NavigatorObserver` when `autoPageViews: true` (default)         | Closed (High)                             |
| 2   | Screen/route context on events                                                          | `$url`, `$referrer`, `$pageTitle` auto-properties | `$url` and `$referrer` included in `page_view` events; host app must register observer        | Low–Medium (tied to #1, partially closed) |
| 3   | Wire-level protovalidate enforcement                                                    | Client-side request validation                    | Well-known event prop _types_ only; no full `Event`/`IdentifyRequest`/`SubscribeRequest` check | Low–Medium                                |
| 4   | Install referrer / deferred attribution                                                 | n/a (URL is always present)                       | Link-open UTM is captured; install-referrer / deferred deep-link attribution is not            | Low–Medium                                |
| 5   | Compile-time typed event props                                                          | `WellKnownEventPropsMap` + overloaded `TrackFn`   | Runtime schema validation only                                                                 | Low (Dart language limit)                 |
| 6   | DOM interaction auto-trackers (`click`, `scroll`, `form_*`, `rage_click`, `dead_click`) | 5 auto-trackers installed by `autoTrack`          | Schemas exist, no trackers                                                                     | Low (DOM-specific, intentionally omitted) |
| 7   | Hard delivery guarantee on app kill                                                     | `navigator.sendBeacon` on `pagehide`              | Best-effort `flushAll()` only; no synchronous-beacon equivalent                                | Low (platform limit)                      |
| 8   | Package-level FCM optionality                                                           | Push is tree-shakeable and optional               | Core barrel avoids FCM exports, but `firebase_messaging` stays in the dependency graph         | Low–Medium                                |

## Compatibility Notes

The Flutter SDK currently supports:

- Dart `>=3.7.0 <4.0.0`
- Flutter `>=3.29.0`

This floor is driven primarily by the checked-in generated protobuf code and `protobuf` runtime compatibility.

## Maintenance Checklist

When changing parity-sensitive behavior:

- Update this document. It is the single canonical parity reference — do not fork a second parity file.
- Update `CLAUDE.md` if agent guidance changes.
- Update `TODO.md` if a gap is closed or a new gap is accepted.
- Add tests in `test/pug_flutter_sdk_test.dart` for shared semantics or mobile substitutions.
- Prefer injected fakes for platform features, especially link capture, storage, transport, clock, ID generation, and push providers.
- Reference files and symbols rather than line numbers — line numbers rot fast.

## Source Of Evidence

- **Flutter SDK** — audited against `lib/src/*.dart`, `lib/pug_flutter_sdk.dart`, `lib/pug_flutter_fcm.dart`, `proto/**`, and `test/pug_flutter_sdk_test.dart` at commit `cc9196e` ("Make public SDK calls non-throwing"), 2026-05-14. Generated code under `lib/src/gen/` was excluded.
- **Web SDK** — spot-checked against `cotton-web-sdk` `src/*.ts` at commit `0330738`: sampling no-op (`pug.ts`), gRPC error codes (`batch.ts`), debounced queue persistence (`batch.ts`), `init`/`identify` throwing (`pug.ts`), `destroy()` storage wipe (`pug.ts`), and multi-tab coordination (`session.ts`).
- **Shared backend contract** — both SDKs target `sdk.events.v1.EventsService/BatchCreate`, `sdk.profiles.v1.ProfilesSDKService/Identify`, and `sdk.devices.v1.DevicesService/Subscribe`, with `buf.validate` rules now carried in `proto/**`.
