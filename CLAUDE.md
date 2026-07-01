# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Project Overview

Pug Flutter SDK is a Flutter/Dart analytics, identity, session, batching, and push device registration SDK. It is intended to match the product semantics of `../sdk-web` while using Flutter-native lifecycle and storage APIs.

The public barrel is `lib/pug_sdk.dart`. Core runtime logic lives under `lib/src/`; generated protobuf Dart code lives under `lib/src/gen/` and is produced from `proto/**/*.proto`.

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
- All public SDK calls are best-effort and must never throw.
- `Pug.identify(externalId, traits:)` logs failures and completes normally.
- `Pug.reset()`, `Pug.rotate()`, `Pug.flush()`, and `Pug.destroy()` manage identity/session/runtime state.
- `Pug.optInTracking()`, `Pug.optOutTracking()`, `Pug.getTrackingConsent()`, and `Pug.isTrackingEnabled()` manage tracking consent. See `### Tracking Consent`.
- `Pug.track` is a callable `TrackNamespace`:
  - `Pug.track('kind', props: {...})` — custom/dynamic event names (untyped, discouraged for well-known events).
  - `Pug.track.<event>(...)` — one typed method per well-known event (codegen'd from `proto/`). Required fields are compile-time enforced; `extras: Map<String, Object?>` is always available for ad-hoc props.

`PugPush` in `lib/src/push.dart` exposes provider-neutral push subscription, unsubscription, and notification event helpers.

### Runtime

`PugClient` in `lib/src/runtime.dart` owns transport, queue, storage, session/profile state, sampling, flush scheduling, and Flutter lifecycle observation. `track()` builds an `Event`, queues or sends it immediately, and catches all failures.

Auto tracking is conservative for mobile: when `autoTrack` is enabled, lifecycle changes emit `app_open` and `app_close`. When `autoPageViews` is enabled (default), route changes emit `page_view` events with `url` and `referrer` properties; host apps must add `PugRouteObserver()` to their Navigator's `navigatorObservers` to enable this feature. `Pug.init(...)` binds `PugRouteObserver.onRouteChanged` to the active client.

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

`ConnectPugTransport` (in `lib/src/connect_transport.dart`) sends binary protobuf payloads over Connect-compatible HTTP endpoints. It sets `x-api-key`; the `connectrpc` client adds `connect-protocol-version: 1`. The default endpoint is `https://polru.pug.sh` (matching the web SDK); override it via `PugOptions.endpoint`. Unknown/unwrapped transport errors (e.g. `SocketException`) are treated as transient so the batch is retried, not dropped.

RPC paths:

- `/sdk.events.v1.EventsService/BatchCreate`
- `/sdk.profiles.v1.ProfilesSDKService/Identify`
- `/sdk.devices.v1.DevicesService/Subscribe`

Permanent HTTP failures drop events; transient failures roll back and retry later.

### Auto Properties

`PugAutoPropertyProvider` supplies auto-properties synchronously during event creation. `SystemPugAutoPropertyProvider.create(...)` preloads async platform metadata for `Pug.init(...)` unless callers supply one.

Auto properties include `$projectId`, `$sdkVersion`, `$platform`, `$os`, `$osVersion`, `$locale`, `$timezone`, screen dimensions, app version/build/package where available, device manufacturer/model where available, and a coarse connectivity category (`$networkType`: `wifi`, `mobile`, `ethernet`, `vpn`, `bluetooth`, `other`, `none`, or `unknown`) where available.

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

`TrackingConsentController` in `lib/src/tracking_consent.dart` holds consent state and gates capture, matching the web SDK's consent model. When consent is `denied`, `track()` (typed and untyped), `identify()`, and automatic capture (lifecycle, page views, notifications) are dropped; `identify()` returns normally without hitting transport. The gate lives in `PugClient.track()`/`identify()` and is checked before sampling. Automatic campaign/deep-link capture is *not* gated: while denied, campaign parameters are still written to `__pug_<projectId>_campaign__` and attached to later events, but nothing is transmitted until consent is granted (event creation is gated). Consent activity — denied-drop debug logs, an invalid persisted value, or a `SafePugStorage` persistence failure — is reported only through the configured `PugLogger`; the default `NoopPugLogger` discards debug/warn/error, so configure a logger to observe consent behavior.

Consent is configured through `PugOptions.trackingConsent` (`TrackingConsentConfig`): `defaultConsent` (default `granted`) seeds first-run state, and `persist` (default `false`) mirrors opt in/out to the project-scoped key `__pug_<projectId>_consent__` and restores it on the next `init()`. The runtime exposes `optInTracking()`, `optOutTracking()`, `trackingConsent`, and `isTrackingEnabled`, surfaced publicly on `Pug`. Consent is independent of `dryRun`, which suppresses delivery without changing consent. `destroy()` does not clear persisted consent, so a user's opt-out survives teardown.

### Push

Push is provider-neutral at the API level through `PushProvider`. No concrete provider ships with the SDK; host apps supply their own `PushProvider` implementation. The notification received/clicked/dismissed tracking helpers on `PugPush` are implemented today; an FCM (or other) provider may be packaged as a separate add-on. All three notification helpers send immediately, since notification callbacks often fire while the app is backgrounded.

Notification helper events:

- `notification_received`
- `notification_clicked`
- `notification_dismissed`

Notification payload sanitization keeps only flat strings, booleans, finite numbers, and timestamps. `notification_clicked` defaults missing `campaignId` to `(unknown)`.

## Design Invariants

- `track()` (typed and untyped), `reset()`, `rotate()`, `flush()`, `destroy()`, and the `PugPush` helpers are best-effort: they catch failures, log, and never throw or crash the host app.
- `init()` and `identify()` are the exceptions: they throw on invalid input, and re-throw init/transport failures after logging, so callers can await and handle them. Push registration logs failures and completes normally.
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
- Dry run, sampling rate clamping, custom logger, injectable storage/transport/clock/ID generator.
- Typed track API.
  - Per-event typed methods on `Pug.track.*` codegen'd from the buf catalog.
  - Untyped `Pug.track(kind, props:)` retained as the escape hatch with a debug-only hint on well-known kinds.

Flutter/mobile-specific parity:

- App lifecycle auto tracking for `app_open` and `app_close`.
- `SharedPreferencesPugStorage` via async `Pug.init(...)`.
- Automatic campaign capture from app links/deep links using `app_links` 3.x.

Remaining gaps:

- No concrete push provider ships with the SDK. The push API is provider-neutral and the notification tracking helpers are implemented; an FCM (or other) token provider can be packaged as a separate add-on.
- No browser-style auto trackers for click, scroll, forms, rage click, dead click, page URL/referrer/title, or UA client hints. UTM-style campaign capture is implemented from app/deep links, but this SDK does not capture install referrer/deferred attribution automatically.

Keep `TODO.md` synchronized when closing or adding parity items.
