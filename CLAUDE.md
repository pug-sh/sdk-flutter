# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Project Overview

Pug Flutter SDK is a Flutter/Dart analytics, identity, session, batching, and push device registration SDK. It is intended to match the product semantics of `../sdk-web` while using Flutter-native lifecycle and storage APIs.

The public barrel is `lib/pug_flutter.dart`. Core runtime logic lives under `lib/src/`; generated protobuf Dart code lives under `lib/src/gen/` and is produced from `proto/**/*.proto`.

Minimum supported SDKs are Dart `>=3.7.0 <4.0.0` and Flutter `>=3.29.0`. This floor is driven by the generated protobuf code and the `protobuf` runtime.

## Build And Development Commands

```bash
make protos       # Generate Dart protobuf files from proto/**/*.proto
dart format lib test
flutter analyze
flutter test
make check        # protos + format + analyze + test
```

`make protos` requires `protoc` and `protoc-gen-dart` at `~/.pub-cache/bin/protoc-gen-dart`.

## Architecture

### Public API

`Pug` in `lib/src/pug.dart` is the singleton entry point:

- `Pug.init(projectId, options)` initializes asynchronously with `SharedPreferencesPugStorage` and enhanced mobile auto-properties by default.
- Persistence is opt-out: provide `storage: MemoryPugStorage()` or another custom `PugStorage` to override the default.
- All public SDK calls are best-effort and never throw, except `init()`, which throws synchronously on invalid input (empty `projectId`/`apiKey`) so a misconfiguration surfaces at the call site. See `## Design Invariants`.
- `Pug.identify(externalId, traits:)` never throws — invalid input and transport failures are logged and the future completes normally, matching the web SDK.
- `Pug.reset()`, `Pug.rotate()`, `Pug.flush()`, and `Pug.destroy()` manage identity/session/runtime state.
- `Pug.optInTracking()`, `Pug.optOutTracking()`, `Pug.getTrackingConsent()`, and `Pug.isTrackingEnabled()` manage tracking consent. See `### Tracking Consent`.
- `Pug.track` is a callable `TrackNamespace`:
  - `Pug.track('kind', props: {...})` — custom/dynamic event names (untyped, discouraged for well-known events).
  - `Pug.track.<event>(...)` — one typed method per well-known event (codegen'd from `proto/`). Required fields are compile-time enforced; `extras: Map<String, Object?>` is always available for ad-hoc props.

`PugPush` in `lib/src/push.dart` exposes provider-neutral push subscription, unsubscription, and notification event helpers.

### Runtime

`PugClient` in `lib/src/runtime.dart` owns transport, queue, storage, session/profile state, flush scheduling, and Flutter lifecycle observation. `track()` builds an `Event`, queues or sends it immediately, and catches all failures.

Auto tracking is conservative for mobile: when `autoTrack` is enabled, lifecycle changes emit `app_open` and `app_close`. When `autoPageViews` is enabled (default), route changes emit navigation events — `screen_view` (with the required `screenName` property) on iOS/Android, `page_view` on web (`kIsWeb`), matching the proto platform annotations ("use screen_view for native mobile screens"). Desktop (macOS/Windows/Linux) and other native targets emit no navigation event, because the schema restricts `screen_view` to iOS/Android and `page_view` to web; route state is still updated for the `$url`/`$referrer` auto-properties. Host apps must add `PugRouteObserver()` to their Navigator's `navigatorObservers` to enable this feature. `Pug.init(...)` binds `PugRouteObserver.onRouteChanged` to the active client. Route changes update the current/previous route, attached to every event as the `$url`/`$referrer` auto-properties (matching the web SDK). This route state is tracked whenever the observer reports a change — even when `autoPageViews` is disabled — and the navigation event carries no explicit `url`/`referrer` props, relying on the auto-properties instead. A null route (e.g. the last route being removed) updates route state without emitting a native navigation event, since `screen_view` requires a non-empty name. Likewise, on desktop and other non-iOS/Android native targets the route state advances but no navigation event is emitted.

Campaign capture is enabled by default through `PugOptions.autoCaptureCampaigns`. On start, `PugClient` reads the initial app/deep link and listens for later links through `PugLinkProvider`/`AppLinksPugLinkProvider`; host apps must still configure Android App Links, iOS Universal Links, or custom URL schemes.

### Storage

`PugStorage` is synchronous by design so event/session/profile reads can happen inside `track()`.

- `MemoryPugStorage` is the fallback and explicit persistence opt-out.
- `SafePugStorage` wraps a primary store and switches to memory if a storage call throws synchronously. (`SharedPreferencesPugStorage` write/remove failures surface asynchronously, so they are logged — key only — but do not trip the memory fallback.)
- `SharedPreferencesPugStorage` provides default persistent storage for `Pug.init(...)`.

State keys are project-namespaced:

- `__pug_<projectId>_session__`
- `__pug_<projectId>_profile__`
- `__pug_<projectId>_device_id__`
- `__pug_<projectId>_external_id__`
- `__pug_<projectId>_queue__`
- `__pug_<projectId>_campaign__`
- `__pug_<projectId>_consent__` (only when `trackingConsent.persist` is set)

### Queue

`PugEventQueue` uses a two-phase lock/commit/rollback protocol:

- `push(event)` appends an event, dropping oldest unlocked events when full.
- `lock(limit)` reserves unlocked events for a flush and returns `[]` if a batch is already locked.
- `commit()` removes locked events after success.
- `rollback()` restores locked events after transient failure.
- `size` counts only unlocked events, matching the web SDK's in-flight semantics.

Do not change this behavior casually; it prevents duplicate locks and avoids dropping in-flight events.

### Transport

`ConnectPugTransport` (in `lib/src/connect_transport.dart`) sends binary protobuf payloads over Connect-compatible HTTP endpoints using `package:http`. It POSTs the serialized request proto to the procedure path and sets `x-api-key` plus `connect-protocol-version: 1`. This is a hand-rolled Connect *unary* client (the only RPC style the SDK uses) rather than a dependency on `connectrpc`, which caps `protobuf` at `<5.0.0` and so cannot coexist with the 6.x runtime the generated code needs. Successful (HTTP 200) responses are acknowledgements the SDK never reads, so they are not decoded. Non-200 responses are parsed as Connect errors — `code`/`message` from the JSON error body, falling back to an HTTP-status→code map — and mapped to a `PugTransportException`. Permanent Connect codes (`invalid_argument`, `not_found`, `already_exists`, `permission_denied`, `failed_precondition`, `unimplemented`, `unauthenticated`) drop the batch; everything else, and unknown/unwrapped transport errors (e.g. `SocketException`, `http.ClientException`), are treated as transient so the batch is retried, not dropped. The default endpoint is `https://api.pugs.dev` (matching the web SDK); override it via `PugOptions.endpoint`. Inject a custom `http.Client` for tests.

RPC paths:

- `/sdk.events.v1.EventsService/BatchCreate`
- `/sdk.profiles.v1.ProfilesSDKService/Identify`
- `/sdk.devices.v1.DevicesService/Subscribe`

Permanent HTTP failures drop events; transient failures roll back and retry later.

### Auto Properties

`PugAutoPropertyProvider` supplies auto-properties synchronously during event creation. `SystemPugAutoPropertyProvider.create(...)` preloads async platform metadata for `Pug.init(...)` unless callers supply one.

Auto properties include `$projectId`, `$sdkVersion`, `$platform`, `$deviceType`, `$os`, `$osVersion`, `$locale`, `$timezone` (the IANA identifier via `flutter_timezone`, preloaded in `create(...)`; falls back to the platform abbreviation when unavailable), screen dimensions, app version/build/package where available, device manufacturer/model where available, and a coarse connectivity category (`$networkType`: `wifi`, `mobile`, `ethernet`, `vpn`, `bluetooth`, `other`, `none`, or `unknown`) where available. `$deviceName` is deliberately not sent — user-assigned device names are PII.

`$platform` is a cross-SDK contract, not a Flutter detail: the backend promotes it into a dedicated `platform` column verbatim, with no normalization or validation on the ingest path, so casing that diverges from the rest of the family splits a cross-SDK breakdown into per-SDK buckets. `SystemPugAutoPropertyProvider.platformName` returns `web` when `kIsWeb`, else `Platform.operatingSystem` lowercased — so `$platform` and `$os` are one value from one source, exactly as `sdk-react-native` reports both from `Platform.OS`.

Do **not** derive `$platform` from `defaultTargetPlatform`. That is a UI-theming signal: `.name` reproduces the enum's casing (`iOS`, `macOS`), on web it resolves to the *browser's host* OS, and it *throws* `FlutterError` on any target outside its six-member enum — raised inside `properties()`, which `_createEvent` calls unguarded, that would breach the never-throw invariant. `kIsWeb` must still be checked first (the same ordering `runtime.dart` uses to choose `page_view` over `screen_view`).

This rule is scoped to `$platform`. `runtime.dart` still reads `defaultTargetPlatform` to choose `screen_view` over `page_view`, which is a deliberate exception: it picks between proto event kinds whose platform annotations cover exactly the enum's members, and `debugDefaultTargetPlatformOverride` is what makes that branch testable on a Linux host. It inherits the throw-on-unknown-target risk, so a target outside the enum needs handling there before it is supported.

Across the family the set is `web | ios | android | server | macos | linux | windows | fuchsia`, plus any other value `Platform.operatingSystem` reports; `server` comes from `@pug-sh/node` and the desktop values are Flutter-only. The set is open rather than validated — an unrecognised target reports its own name instead of being folded into a neighbouring platform.

`deviceProperties` dispatches on `Platform.operatingSystem` rather than the `Platform.isX` getters, so the routing is unit-testable without platform channels. An unrecognised target returns no device properties rather than calling a `device_info_plus` channel with nothing registered behind it. Do not add branches for targets Flutter has no build support for (tvOS, watchOS, visionOS): they are unreachable, and the fallthrough already degrades correctly if that changes.

`$deviceType` reports the form factor as `tv`, `mobile`, or `desktop`, and is omitted where there is no honest answer (web, where the browser's host device is not knowable from Dart). It is derived from `Platform.operatingSystem` except for `tv`: Android TV reports `android` like any other Android device, so only the `systemFeatures` list in the device-info payload separates them. `androidProperties` therefore emits `$deviceType: tv` on the `android.software.leanback`/`android.hardware.type.television` features and omits the key otherwise, letting the OS-derived `mobile` stand — the same `_staticProperties`-spreads-last override that `$osVersion` and `$timezone` use. Keeping Android TV on `$platform: android` is deliberate: `sdk-react-native` sends `Platform.OS` there too, and a Flutter-only `androidtv` would split the cross-SDK breakdown.

`_appleModel` treats the plugin's `Unknown device`/`Unknown Model` table misses as absent and falls back to the coarse identifier (`"iPhone"`, `"MacBookPro18,3"`) — the placeholders are non-empty, so an emptiness check alone would ship them as `$deviceModel`. The device mappers omit an empty `$osVersion` rather than sending it: `_staticProperties` spreads last in `properties()`, so an empty value would clobber the `Platform.operatingSystemVersion` fallback, and the property mapper drops only `null`, never `""`.

Campaign auto-properties are merged from the latest captured app/deep link: `$utmSource`, `$utmMedium`, `$utmCampaign`, `$utmTerm`, `$utmContent`, `$gclid`, `$fbclid`, `$msclkid`, and `$ttclid`. They are stored under the project-scoped campaign key and attached to later events.

Tests should prefer `PugStaticAutoPropertyProvider` to avoid platform plugin dependencies.

Tests for campaign capture should inject a fake `PugLinkProvider` instead of invoking platform channels from `app_links`.

### Events

`Event` and `PropertyValue` are SDK-internal Dart models converted to generated protobuf messages by `PugProtoCodec`.

Property mapping:

- `String` -> `stringValue`, truncated to 1024 UTF-8 bytes.
- `bool` -> `boolValue`.
- `int` -> `intValue`.
- finite `double`/`num` -> `doubleValue`.
- `DateTime` -> `timestampValue`.
- JSON-encodable maps/lists/objects -> JSON `stringValue`.
- `null` is dropped silently.
- unsupported or non-finite values are dropped with a warning.

Well-known event schemas are generated from the `proto/common/events/v1/*_events.proto` files and emitted as the `wellKnownEventSchemas` registry in `lib/src/well_known_event_schemas.dart` (re-exported from the barrel; the hand-written models stay in `lib/src/events.dart`). The registry is used only to detect well-known kinds (for the typed-track hint) — `mapEventProperties` itself maps loosely by Dart value type. Correct int-vs-double wire types for known fields come from the typed `Pug.track.*` parameter types at compile time (e.g. a `double` param serializes an integer-valued argument as `doubleValue`); the untyped `track()` path and `extras` use loose runtime mapping.

`PugEventNames` in `lib/src/well_known_events.dart` exposes public constants for all well-known event names.

### Identity And Sessions

Sessions are lazily resolved on event creation. Defaults match the web/mobile spec: 30 minute idle timeout and 1440 minute max duration. Device identity is stored separately from session state under a project-scoped device key. `rotate()` creates a new session while preserving device ID. `reset()` rotates both session and device identity and clears profile identity.

Anonymous profile IDs are prefixed with `anon-`. The first successful `identify()` includes anonymous ID for backend merge semantics; subsequent identifies omit it.

### Tracking Consent

`TrackingConsentController` in `lib/src/tracking_consent.dart` holds consent state and gates capture, matching the web SDK's consent model. When consent is `denied`, `track()` (typed and untyped), `identify()`, and automatic capture (lifecycle, page views, notifications) are dropped; `identify()` returns normally without hitting transport. The gate lives in `PugClient.track()`/`identify()` and is checked before event creation. Automatic campaign/deep-link capture is *not* gated: while denied, campaign parameters are still written to `__pug_<projectId>_campaign__` and attached to later events, but nothing is transmitted until consent is granted (event creation is gated). Consent activity — denied-drop debug logs, an invalid persisted value, or a `SafePugStorage` persistence failure — is reported only through the configured `PugLogger`; the default `NoopPugLogger` discards debug/warn/error, so configure a logger to observe consent behavior.

Consent is configured through `PugOptions.trackingConsent` (`TrackingConsentConfig`): `defaultConsent` (default `granted`) seeds first-run state, and `persist` (default `false`) mirrors opt in/out to the project-scoped key `__pug_<projectId>_consent__` and restores it on the next `init()`. The runtime exposes `optInTracking()`, `optOutTracking()`, `trackingConsent`, and `isTrackingEnabled`, surfaced publicly on `Pug`. Consent is independent of `dryRun`, which suppresses delivery without changing consent. `destroy()` does not clear persisted consent, so a user's opt-out survives teardown.

### Push

Push is provider-neutral at the API level through `PushProvider`. No concrete provider ships with the SDK; host apps supply their own `PushProvider` implementation. The notification received/clicked/dismissed tracking helpers on `PugPush` are implemented today; an FCM (or other) provider may be packaged as a separate add-on. All three notification helpers send immediately, since notification callbacks often fire while the app is backgrounded.

Notification helper events:

- `notification_received`
- `notification_clicked`
- `notification_dismissed`

Notification payload sanitization keeps only flat strings, booleans, finite numbers, and timestamps. All three notification helpers default a missing, empty, or non-string `campaignId` to `(unknown)` — the notification_* schemas mark `campaign_id` as required (buf.validate `required`), so an event without a usable value is expected to be rejected server-side as a permanent (silently dropped) failure.

## Design Invariants

- `track()` (typed and untyped), `identify()`, `reset()`, `rotate()`, `flush()`, `destroy()`, and the `PugPush` helpers are best-effort: they catch failures, log, and never throw or crash the host app.
- `init()` is the exception: it throws synchronously (before the async gap) on invalid input (empty `projectId`/`apiKey`), matching the web SDK's synchronous `init()`, so a misconfiguration surfaces at the call site rather than as a rejected future. Validation lives in the non-`async` `initialize()`; the async setup is delegated to `_start()`. Setup/start failures are logged and swallowed (best-effort degrade), matching the web SDK, which throws on invalid input but continues past failed persistence/session/profile setup. `identify()` is awaitable but never throws — invalid input and transport failures are logged and the future completes normally. Push registration logs failures and completes normally.
- The internal `PugClient.identify` still throws on invalid input and transport failure; the `Pug.identify` facade catches and swallows those, so the never-throw guarantee lives at the public boundary.
- Repeated init warns and no-ops.
- Background lifecycle transitions should flush queued events even when `autoTrack` is disabled.
- `destroy()` is async and awaits a best-effort final flush before disposing local runtime resources; the detached singleton resets synchronously so a follow-up `init()` works even if the caller does not await.
- Keep generated protobuf code generated; update `.proto` files and run `make protos`.
- Do not log API keys, push tokens, or full request payloads by default.
- Prefer small injectable interfaces over hard-coded platform dependencies.

## Current Feature Parity With `../sdk-web`

Implemented parity:

- Singleton init/destroy/reset/rotate lifecycle.
- Best-effort `track()` invariant.
- Batched event transport with binary protobuf and `x-api-key`.
- Persistent queue semantics with lock/commit/rollback.
- Session expiry, rotation, reset, and profile distinct ID behavior.
- `identify()` first-call anonymous merge behavior and device ID linking.
- Tracking consent gate (opt in/out, optional persistence) over track/identify/auto-capture.
- Well-known event names, typed track methods, and type-based property mapping.
- Provider-neutral push registration model.
- Notification received/clicked/dismissed helpers.
- Fuller mobile auto-properties through `PugAutoPropertyProvider`.
- Explicit `Pug.flush()` and background/destroy best-effort flushes.
- Dry run, custom logger, injectable storage/transport/clock/ID generator.
- Typed track API.
  - Per-event typed methods on `Pug.track.*` codegen'd from the buf catalog.
  - Untyped `Pug.track(kind, props:)` retained as the escape hatch with a debug-only hint on well-known kinds.

Flutter/mobile-specific parity:

- App lifecycle auto tracking for `app_open` and `app_close`.
- `SharedPreferencesPugStorage` via async `Pug.init(...)`.
- Automatic campaign capture from app links/deep links using `app_links` 3.x.

Remaining gaps:

- No concrete push provider ships with the SDK. The push API is provider-neutral and the notification tracking helpers are implemented; an FCM (or other) token provider can be packaged as a separate add-on.
- No browser-style auto trackers for click, scroll, forms, rage click, dead click, page title, or UA client hints. Page `$url`/`$referrer` are attached to every event from `PugRouteObserver` route changes. UTM-style campaign capture is implemented from app/deep links, but this SDK does not capture install referrer/deferred attribution automatically.
