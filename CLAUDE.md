# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Project Overview

Pug Flutter SDK is a Flutter/Dart analytics, identity, session, and batching SDK. Push device registration is built but not on the public surface (see `### Not On The Public Surface`). It is intended to match the product semantics of `../sdk-web` while using Flutter-native lifecycle and storage APIs.

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

`make protos` requires `protoc` and `protoc-gen-dart` at `~/.pub-cache/bin/protoc-gen-dart`. Use `dart pub global activate protoc_plugin 25.0.0`: it reproduces the committed `lib/src/gen` byte for byte, whereas 25.1.0 depends on `protobuf ^6.1.0`, above this package's `>=6.0.0` floor. `google/protobuf/descriptor.pbenum.dart` is generated from the `descriptor.proto` bundled with the local `protoc`, not from `proto/`, so a newer `protoc` adds unrelated enums there (libprotoc 36.1 adds `FeatureSet_ProtoLimitsFeature_EnforceProtoLimits`); restore that file from git unless the change is intended.

## Architecture

### Public API

`Pug` in `lib/src/pug.dart` is the singleton entry point:

- `Pug.init(projectId, options)` initializes asynchronously with `SharedPreferencesPugStorage` and enhanced mobile auto-properties by default.
- Persistence is opt-out: provide `storage: MemoryPugStorage()` or another custom `PugStorage` to override the default.
- A new `PugOptions` field has to be carried through both `copyWith` (which `Pug.init` uses to fill in defaults) and `normalizePugOptions` (which `PugClient` applies). Each rebuilds the options field by field, so a field missing from either one is silently dropped.
- All public SDK calls are best-effort and never throw, except `init()`, which throws synchronously on invalid input (empty `projectId`/`apiKey`) so a misconfiguration surfaces at the call site. See `## Design Invariants`.
- `Pug.identify(externalId, traits:)` never throws — invalid input and transport failures are logged and the future completes normally, matching the web SDK. A `reset()` or `destroy()` that lands during the transport await wins: `identify` re-reads the profile afterwards and skips the write-back if the anonymous ID changed, rather than resurrecting the identity the caller just cleared.
- `Pug.reset()`, `Pug.rotate()`, `Pug.flush()`, and `Pug.destroy()` manage identity/session/runtime state.
- `Pug.optInTracking()`, `Pug.optOutTracking()`, `Pug.getTrackingConsent()`, and `Pug.isTrackingEnabled()` manage tracking consent. See `### Tracking Consent`.
- Campaign capture, push device registration, and the notification helpers are **built but off the public surface**: the backend does not accept them yet. See `### Not On The Public Surface`.
- `Pug.track` is a callable `TrackNamespace`:
  - `Pug.track('kind', props: {...})` — custom/dynamic event names (untyped, discouraged for well-known events).
  - `Pug.track.<event>(...)` — one typed method per well-known event (codegen'd from `proto/`). Required fields are compile-time enforced; `extras: Map<String, Object?>` is always available for ad-hoc props.

`PugPush` in `lib/src/push.dart` exposes provider-neutral push subscription, unsubscription, and notification event helpers. It is **not exported** from the barrel — see `### Not On The Public Surface`.

### Not On The Public Surface

Campaigns, devices, push registration, and subscriptions are not live on the backend, so their entry points were removed from the public API while the code stayed in the package. Concretely:

- `lib/pug_flutter.dart` no longer exports `src/campaign.dart` or `src/push.dart`, so `PugLinkProvider`, `campaignPropertiesFromUri`, `PugPush`, `PushProvider`, `PushSubscription`, and `PushSubscribeOptions` are package-internal.
- `PugOptions` lost `autoCaptureCampaigns` and `linkProvider`. `PugClient` still constructs `CampaignTracker`, but `start()` does not call `start()` on it and `_createEvent` does not merge `_campaign.properties()`, so no `$utm*`/click-id auto-properties are attached. `destroy()` still calls `clear()` so stale campaign state from an earlier version is purged.
- `PugTransport` no longer declares `subscribeDevice`. It moved to `PugDeviceTransport` in `lib/src/push_models.dart`, which `ConnectPugTransport` implements; `PushManager` resolves it once in its constructor and warns on every `subscribe()` if the injected transport does not implement it. A custom transport is no longer required to implement device registration.
- `PugClient.subscribePush`, `unsubscribePush`, and `trackNotificationOpened`/`Received`/`Dismissed` are annotated `@internal` (the same convention `Pug.logger`/`Pug.capture` already use) so they stay callable from `PugPush` and tests without being public API.
- The `notification_clicked`/`received`/`dismissed` event kinds stay public through the typed `Pug.track.*` methods and `PugEventNames`: they are ordinary events on the live events endpoint, and they are regenerated from `proto/` by `make protos`.

Re-enabling is: restore the two barrel exports, the two `PugOptions` fields, the `await _campaign.start()` call and the campaign properties in `_createEvent`, and fold `subscribeDevice` back into `PugTransport`. `test/campaign_tracker_test.dart` covers `CampaignTracker` directly in the meantime, and the push tests reach the entry points through `package:pug_flutter/src/`.

### Runtime

`PugClient` in `lib/src/runtime.dart` is a coordinator: it constructs and wires the collaborators below, gates capture on consent and `dryRun`, assembles `Event`s in `_createEvent`, and owns start/destroy ordering. It catches all failures. The concerns that own state live in their own files:

- `EventDispatcher` (`lib/src/dispatcher.dart`) — queue, transport, flush timer, and the permanent-vs-transient failure policy. Flushes are serialized through a chained future rather than dropped while one is in flight, so `flushAll()` — and so `destroy()` — waits for a batch it did not start; `pending` counts locked events too, so the "discarded N undelivered" warning cannot miss an in-flight batch. Every post-`await` `commit`/`rollback`/`push` is guarded on `_disposed`, or it would re-persist the batch into a queue key `destroy()` has already purged.
- `PugIdentity` (`lib/src/identity.dart`) — device, session, and profile state.
- `CampaignTracker` (`lib/src/campaign_tracker.dart`) — app/deep-link capture and replay (constructed but not started; see below).
- `NavigationTracker` (`lib/src/navigation.dart`) — route state and the platform-specific navigation event kind.
- `AppLifecycleTracker` (`lib/src/lifecycle.dart`) — the foreground/background state machine behind `app_open`/`app_close`. Its `capture` callback returns whether the event was really captured, and the foreground flag only advances when it was: a consent-denied `app_open` must not leave an unpaired `app_close` behind once consent is granted. Only `hidden`/`paused`/`detached` emit `app_close`; `inactive` is a transient loss of input focus with the app still visible (incoming call, app switcher, control-centre swipe), so it emits none. It *does* still flush, and so does any state Flutter adds later: the desktop embedders send only `resumed`/`inactive`/`hidden` — never `paused`/`detached`, and `hidden` only on minimize/occlusion — so on macOS/Windows/Linux `inactive` can be the last state before the process exits, and skipping the flush there would strand the queue. `handleStateChange` is deliberately an if/else rather than a `switch`: an exhaustive switch over `AppLifecycleState` becomes a *compile error* (`non_exhaustive_switch_statement`) inside this package the next time Flutter adds a member, which host apps cannot patch.
- `InstallTracker` (`lib/src/install_tracker.dart`) — the `app_install`/`app_update` check, run once per `start()`.
- `PushManager` (`lib/src/push_manager.dart`) — device token subscribe/unsubscribe.
- `TrackingConsentController` — as described below.

The storage-backed collaborators share `PugStorageKeys`. `PugRouteObserver` lives in `lib/src/route_observer.dart` and `normalizePugOptions` (option clamping plus the `SafePugLogger` wrap) in `lib/src/options_normalizer.dart`.

Ordering that matters in `start()`: campaign capture does not run today (see `### Not On The Public Surface`), but when it is re-enabled it must go before `AppLifecycleTracker.syncInitialState`, so the launch `app_open` carries the campaign auto-properties from the launch link. `PugClient` keeps the `WidgetsBindingObserver` mixin and forwards `didChangeAppLifecycleState` to the tracker; the tracker is deliberately not the registered observer, since dropping the mixin would narrow `PugClient`'s public type.

Auto tracking is conservative for mobile: when `autoTrack` is enabled, lifecycle changes emit `app_open` and `app_close`. When `autoInstallEvents` is enabled (default), `start()` emits `app_install` or `app_update` once per app version (see `### Install And Update`). When `autoPageViews` is enabled (default), route changes emit navigation events — `screen_view` (with the required `screenName` property) on iOS/Android, `page_view` on web (`kIsWeb`), matching the proto platform annotations ("use screen_view for native mobile screens"). Desktop (macOS/Windows/Linux) and other native targets emit no navigation event, because the schema restricts `screen_view` to iOS/Android and `page_view` to web; route state is still updated for the `$url`/`$referrer` auto-properties. Host apps must add `PugRouteObserver()` to their Navigator's `navigatorObservers` to enable this feature. `Pug.init(...)` binds `PugRouteObserver.onRouteChanged` to the active client, whose `notifyRouteChanged` forwards to `NavigationTracker`. `PugRouteObserver` takes top-route transitions from `NavigatorObserver.didChangeTop` alone, not from the per-operation callbacks: `Navigator` calls it after any push/pop/replace/remove that actually changes the topmost route, whereas `didRemove` hands over the route *below* the removed one — removing `/b` from `/a → /b → /c` would report `/a` while `/c` is still on screen. `didChangeTop` is not called when the stack empties, so `didPop`/`didRemove` are kept solely to report the null route in that case. Whether the stack emptied is tracked by counting routes (`didPush` up, `didPop`/`didRemove` down): a null `previousRoute` is *not* the signal, because `Navigator` passes null whenever the bottom-most route goes, which happens routinely with routes still on screen — `pushAndRemoveUntil` clears the stack from the bottom up under a route it has already pushed. A removal seen while the count is already zero is ignored, so an observer attached to a Navigator that already had routes stays quiet rather than guessing. The observer reports a `referrer`, but it is unused: the tracker derives the previous route from its own last-known route, which is what `$referrer` reflects. Route changes update the current/previous route, attached to every event as the `$url`/`$referrer` auto-properties (matching the web SDK). This route state is tracked whenever the observer reports a change — even when `autoPageViews` is disabled — and the navigation event carries no explicit `url`/`referrer` props, relying on the auto-properties instead. A null or empty route (e.g. the last route being removed) updates route state without emitting a navigation event on *any* platform, web included: `screen_view` requires a non-empty name, and a `page_view` with no `$url` says nothing. Likewise, on desktop and other non-iOS/Android native targets the route state advances but no navigation event is emitted.

Campaign capture is implemented in `CampaignTracker` — it reads the initial app/deep link and listens for later links through an injected `PugLinkProvider` — but `PugClient.start()` does not start it, and host apps have no way to configure it. No concrete provider ships any more: the `app_links` adapter and the dependency were dropped, since nothing could reach them while capture is off and every host app still paid for the plugin's platform registration. `start()` warns and returns when no provider was supplied, so re-enabling capture means restoring an adapter and the dependency alongside the other steps below. See `### Not On The Public Surface`.

### Install And Update

`InstallTracker` (`lib/src/install_tracker.dart`) compares the `$appVersion` auto-property against the version stored under `__pug_<projectId>_last_version__` and emits `app_install` or `app_update` (with `previousVersion`) once per version. It is gated on its own `PugOptions.autoInstallEvents` (default `true`), independent of `autoTrack` in the same way `autoPageViews` is: a one-shot check at start is a different capture family from a lifecycle subscription. The key name and the ordering below are a cross-SDK contract, not a Flutter detail. The version is the only input, so a provider that could not read package info (or a `PugStaticAutoPropertyProvider` in tests) disables detection rather than guessing.

Three things are load-bearing:

- `check()` runs in `start()` *before* `AppLifecycleTracker.syncInitialState` — so a launch install/update precedes the launch `app_open` — and before anything else in `start()` writes a project-scoped key. The install branch only fires when no key in `PugStorageKeys.priorActivity` exists; without that probe, adding this SDK to an app that already used Pug would report every existing user as a new install. Its own state would trip that probe if it ran later. `priorActivity` is `all` minus `consent` and `lastVersion`: consent is a user preference rather than tracking activity, and it is the one key `destroy()` keeps, so counting it would suppress the `app_install` of an install that was denied consent at first launch and granted it later.
- The stored version only advances when the capture callback reports the event was really captured, the same contract `AppLifecycleTracker` uses: a consent-denied `app_install` is retried on the next launch instead of being lost for good.
- `destroy()` purges `last_version` alongside identity, campaign, and queue (owning clients only), matching the cross-SDK rule that teardown purges every project key except consent. A destroy/re-init cycle therefore does look like a fresh install — defensible, in that no prior state is left, but a reason not to call `destroy()` routinely.

No platform gate, matching `app_open`/`app_close`: the proto annotates all four as iOS/Android, but `AppLifecycleTracker` emits regardless of platform. (`NavigationTracker` does gate, because there the proto offers a different kind per platform.) On web this means a cleared browser store reads as a fresh install — `autoInstallEvents: false` is the escape hatch, which is part of why the check has its own option.

### Storage

`PugStorage` is synchronous by design so event/session/profile reads can happen inside `track()`.

- `MemoryPugStorage` is the fallback and explicit persistence opt-out.
- `SafePugStorage` wraps a primary store and switches to memory if a storage call throws synchronously. (`SharedPreferencesPugStorage` write/remove failures surface asynchronously, as a rejected future or a `false` result, so they are logged — key only — but do not trip the memory fallback.)
- `SharedPreferencesPugStorage` provides default persistent storage for `Pug.init(...)`.

State keys are project-namespaced and defined once, in `PugStorageKeys` (`lib/src/state_storage.dart`), alongside the `decodeStoredJsonMap` helper the state owners share:

- `__pug_<projectId>_session__`
- `__pug_<projectId>_profile__`
- `__pug_<projectId>_device_id__`
- `__pug_<projectId>_external_id__`
- `__pug_<projectId>_queue__`
- `__pug_<projectId>_campaign__`
- `__pug_<projectId>_consent__` (only when `trackingConsent.persist` is set)
- `__pug_<projectId>_last_version__`

`PugStorageKeys.all` lists them all, and `PugStorageKeys.priorActivity` narrows that to the keys whose presence proves prior tracking (everything but `consent` and `lastVersion`). `InstallTracker` probes the latter to tell a fresh install from an app that already had Pug on it, so a key added to `all` but not to the purge in `destroy()` (or the reverse) silently changes install detection.

### Queue

`PugEventQueue` uses a two-phase lock/commit/rollback protocol:

- `push(event)` appends an event, dropping oldest unlocked events when full.
- `lock(limit)` reserves unlocked events for a flush and returns `[]` if a batch is already locked.
- `commit()` removes locked events after success.
- `rollback()` restores locked events after transient failure.
- `size` counts only unlocked events, matching the web SDK's in-flight semantics.

Do not change this behavior casually; it prevents duplicate locks and avoids dropping in-flight events.

### Transport

`ConnectPugTransport` (in `lib/src/connect_transport.dart`) sends binary protobuf payloads over Connect-compatible HTTP endpoints using `package:http`. It POSTs the serialized request proto to the procedure path and sets `x-api-key` plus `connect-protocol-version: 1`. This is a hand-rolled Connect *unary* client (the only RPC style the SDK uses) rather than a dependency on `connectrpc`, which caps `protobuf` at `<5.0.0` and so cannot coexist with the 6.x runtime the generated code needs. Successful (HTTP 200) responses are acknowledgements the SDK never reads, so they are not decoded. That includes `BatchCreateResponse.accepted`/`dropped`/`droppedByReason`. sdk-web reads `accepted` and warns when it falls short of the number sent; this SDK skips that because today the server drops only cookieless events per-event, and this SDK never sends one. If the server starts dropping other events that way, add the same warning. Non-200 responses are parsed as Connect errors — `code`/`message` from the JSON error body, falling back to an HTTP-status→code map — and mapped to a `PugTransportException`. Permanent Connect codes (`invalid_argument`, `not_found`, `already_exists`, `permission_denied`, `failed_precondition`, `unimplemented`, `unauthenticated`) drop the batch; everything else, and unknown/unwrapped transport errors (e.g. `SocketException`, `http.ClientException`), are treated as transient so the batch is retried, not dropped. The default endpoint is `https://api.pugs.dev` (matching the web SDK); override it via `PugOptions.endpoint`. `PugOptions.httpClient` hands a host `http.Client` (`cupertino_http`, `cronet_http`, a `MockClient` in tests) to the default `ConnectPugTransport`; without it, `package:http`'s default `Client()` is `dart:io`'s `HttpClient` on native platforms. `../sdk-go` has the same option as `Options.HTTPClient`. The host owns an injected client — `ConnectPugTransport.close()` only closes one it created — so `destroy()` leaves it open for a later `init()`. `PugClient` ignores it, with a warning, when `PugOptions.transport` is set. `EventDispatcher` closes the transport on dispose only when `PugClient` constructed it (`ownsTransport: _options.transport == null`): a host may hand the same `ConnectPugTransport` to two successive `init()` calls, and closing its `http.Client` makes every later send fail as `Client is already closed`, which `mapConnectError` classifies as *transient* — so the replacement would retry forever instead of failing loudly.

RPC paths:

- `/sdk.events.v1.EventsService/BatchCreate`
- `/sdk.profiles.v1.ProfilesSDKService/Identify`
- `/sdk.devices.v1.DevicesService/Subscribe`

Permanent HTTP failures drop events; transient failures roll back and retry later.

### Auto Properties

`PugAutoPropertyProvider` supplies auto-properties synchronously during event creation. `SystemPugAutoPropertyProvider.create(...)` preloads async platform metadata for `Pug.init(...)` unless callers supply one.

Auto properties include `$projectId`, `$sdkVersion`, `$platform`, `$deviceType`, `$os`, `$osVersion`, `$locale`, `$timezone` (the IANA identifier via `flutter_timezone`, preloaded in `create(...)`; falls back to the platform abbreviation when unavailable), screen dimensions, app version/build/package where available, device manufacturer/model where available, and a coarse connectivity category (`$networkType`: `wifi`, `mobile`, `ethernet`, `vpn`, `bluetooth`, `other`, `none`, or `unknown`) where available. `$deviceName` is deliberately not sent — user-assigned device names are PII.

`$platform` is a cross-SDK contract, not a Flutter detail: the backend promotes it into a dedicated `platform` column verbatim, with no normalization or validation on the ingest path, so casing that diverges from the rest of the family splits a cross-SDK breakdown into per-SDK buckets. `SystemPugAutoPropertyProvider.platformName` returns `web` when `kIsWeb`, else `Platform.operatingSystem` lowercased — so `$platform` and `$os` are one value from one source, as they are elsewhere in the family.

Do **not** derive `$platform` from `defaultTargetPlatform`. That is a UI-theming signal: `.name` reproduces the enum's casing (`iOS`, `macOS`), on web it resolves to the *browser's host* OS, and it *throws* `FlutterError` on any target outside its six-member enum — raised inside `properties()`, which `_createEvent` calls unguarded, that would breach the never-throw invariant. `kIsWeb` must still be checked first (the same ordering `navigation.dart` uses to choose `page_view` over `screen_view`).

This rule is scoped to `$platform`. `NavigationTracker` (`lib/src/navigation.dart`) still reads `defaultTargetPlatform` to choose `screen_view` over `page_view`, which is a deliberate exception: it picks between proto event kinds whose platform annotations cover exactly the enum's members, and `debugDefaultTargetPlatformOverride` is what makes that branch testable on a Linux host. It inherits the throw-on-unknown-target risk, so a target outside the enum needs handling there before it is supported.

Across the family the set is `web | ios | android | server | macos | linux | windows | fuchsia`, plus any other value `Platform.operatingSystem` reports; `server` comes from `@pug-sh/node` and the desktop values are Flutter-only. The set is open rather than validated — an unrecognised target reports its own name instead of being folded into a neighbouring platform.

`deviceProperties` dispatches on `Platform.operatingSystem` rather than the `Platform.isX` getters, so the routing is unit-testable without platform channels. An unrecognised target returns no device properties rather than calling a `device_info_plus` channel with nothing registered behind it. Do not add branches for targets Flutter has no build support for (tvOS, watchOS, visionOS): they are unreachable, and the fallthrough already degrades correctly if that changes.

`$deviceType` reports the form factor as `tv`, `mobile`, or `desktop`, and is omitted where there is no honest answer (web, where the browser's host device is not knowable from Dart). It is derived from `Platform.operatingSystem` except for `tv`: Android TV reports `android` like any other Android device, so only the `systemFeatures` list in the device-info payload separates them. `androidProperties` therefore emits `$deviceType: tv` on the `android.software.leanback`/`android.hardware.type.television` features and omits the key otherwise, letting the OS-derived `mobile` stand — the same `_staticProperties`-spreads-last override that `$osVersion` and `$timezone` use. Keeping Android TV on `$platform: android` is deliberate: the rest of the family reports it as plain `android` too, and a Flutter-only `androidtv` would split the cross-SDK breakdown.

`_appleModel` treats the plugin's `Unknown device`/`Unknown Model` table misses as absent and falls back to the coarse identifier (`"iPhone"`, `"MacBookPro18,3"`) — the placeholders are non-empty, so an emptiness check alone would ship them as `$deviceModel`. The device mappers omit an empty `$osVersion` rather than sending it: `_staticProperties` spreads last in `properties()`, so an empty value would clobber the `Platform.operatingSystemVersion` fallback, and the property mapper drops only `null`, never `""`.

Campaign auto-properties are **not currently attached** (see `### Not On The Public Surface`). When capture is re-enabled they are merged from the latest captured app/deep link: `$utmSource`, `$utmMedium`, `$utmCampaign`, `$utmTerm`, `$utmContent`, `$gclid`, `$fbclid`, `$msclkid`, and `$ttclid`. They are stored under the project-scoped campaign key and attached to later events.

Tests should prefer `PugStaticAutoPropertyProvider` to avoid platform plugin dependencies.

Tests for campaign capture must inject a fake `PugLinkProvider`; there is no default provider to fall back on.

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

`PugIdentity` in `lib/src/identity.dart` owns device, session, and profile state, including the `SessionState`/`ProfileState` models and their persistence. Sessions are lazily resolved on event creation. Defaults match the web/mobile spec: 30 minute idle timeout and 1440 minute max duration. Device identity is stored separately from session state under a project-scoped device key. `PugClient.rotate()` (`PugIdentity.rotateSession()`) creates a new session while preserving device ID. `reset()` rotates both session and device identity and clears profile identity; the order in which it draws IDs is load-bearing for tests that inject a sequence generator.

Anonymous profile IDs are prefixed with `anon-`. The first successful `identify()` includes anonymous ID for backend merge semantics; subsequent identifies omit it.

External IDs must not start with `cookieless-` (`reservedDistinctIdPrefix` in `identity.dart`). The server mints its cookieless identities with that prefix and rejects it on a client-sent `external_id` and on every `distinct_id` in a batch. The batch check is a CEL rule over the whole `BatchCreateRequest`, so one such event fails the entire batch as `invalid_argument`, which `EventDispatcher` drops as permanent. Three guards; the first two match sdk-web, which lacks the third. `PugClient.identify` throws `ArgumentError` on the prefix, checked with the empty-ID check before the consent gate, so a new identify can never persist one; the `Pug.identify` facade logs it. `PugIdentity.resolveProfile` discards a stored one, whether it comes from the profile JSON or the `external_id` seed, logs a warning, and removes it from both; this is for devices that identified with such an ID before the server reserved the prefix. `PugEventQueue` drops persisted events whose `distinctId` carries the prefix when it loads, because events queued before that discard would otherwise fail the first batch after the upgrade, healthy events included.

### Tracking Consent

`TrackingConsentController` in `lib/src/tracking_consent.dart` holds consent state and gates capture, matching the web SDK's `granted`/`denied` states. sdk-web's third `cookieless` state, which is also its default, is not implemented (see "Remaining gaps" below). When consent is `denied`, `track()` (typed and untyped), `identify()`, and automatic capture (lifecycle, page views, notifications) are dropped; `identify()` returns normally without hitting transport. The gate lives in `PugClient.track()`/`identify()` and is checked before event creation. Campaign capture is not started (see `### Not On The Public Surface`), so nothing is written to `__pug_<projectId>_campaign__` and no campaign auto-properties are attached. When it is re-enabled, capture is deliberately *not* consent-gated: while denied, parameters are still recorded locally and attached to later events, but nothing is transmitted until consent is granted (event creation is gated). Consent activity — denied-drop debug logs, an invalid persisted value, or a `SafePugStorage` persistence failure — is reported only through the configured `PugLogger`; the default `NoopPugLogger` discards debug/warn/error, so configure a logger to observe consent behavior.

Consent is configured through `PugOptions.trackingConsent` (`TrackingConsentConfig`): `defaultConsent` (default `granted`) seeds first-run state, and `persist` (default `false`) mirrors opt in/out to the project-scoped key `__pug_<projectId>_consent__` and restores it on the next `init()`. The runtime exposes `optInTracking()`, `optOutTracking()`, `trackingConsent`, and `isTrackingEnabled`, surfaced publicly on `Pug`. Consent is independent of `dryRun`, which suppresses delivery without changing consent. `destroy()` does not clear persisted consent, so a user's opt-out survives teardown.

### Push

`PushManager` in `lib/src/push_manager.dart` performs subscribe/unsubscribe against the transport, resolving the device and profile from `PugIdentity`; `PugClient` only adds the destroyed-client guard and routes the three notification helpers through `notificationEventProperties`. Push is not on the public surface (see `### Not On The Public Surface`). Push is provider-neutral at the API level through `PushProvider`. No concrete provider ships with the SDK; host apps supply their own `PushProvider` implementation. The notification received/clicked/dismissed tracking helpers on `PugPush` are implemented today; an FCM (or other) provider may be packaged as a separate add-on. All three notification helpers send immediately, since notification callbacks often fire while the app is backgrounded.

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
- `destroy()` is async and awaits a best-effort final flush before disposing local runtime resources; the detached singleton resets synchronously so a follow-up `init()` works even if the caller does not await. `Pug.init()` awaits any teardown still in flight before constructing the replacement, so the two clients never share the persisted queue. Direct `PugClient` users can still overlap, so ownership is also tracked at the runtime level: `start()` records the client in `PugClient._storageOwners`, keyed by `(projectId, primary storage)` — two clients on the same project but different `PugStorage` instances share no namespace — and hands ownership over by calling `_releaseStorage()` on the previous owner. A released client stops sending (the replacement has already adopted its persisted events, so sending them again would double-deliver) and stops persisting (its `lock`/`commit`/`rollback`/`dispose` writes would otherwise overwrite the new owner's queue). Only an owning client purges identity, campaign, and queue keys in `destroy()`; a client that never started never owned them, so it purges nothing.
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
- `app_install`/`app_update` detection per app version.
- `SharedPreferencesPugStorage` via async `Pug.init(...)`.

Remaining gaps:

- No concrete push provider ships with the SDK. The push API is provider-neutral and the notification tracking helpers are implemented; an FCM (or other) token provider can be packaged as a separate add-on.
- Campaign capture is **built but not available**. `CampaignTracker` implements app/deep-link capture and replay, but `PugOptions` exposes no way to configure it, `PugClient.start()` never calls `CampaignTracker.start()`, and no `PugLinkProvider` adapter ships — so no `$utm*`/click-id auto-properties are attached. See `### Not On The Public Surface` for what re-enabling takes.
- No browser-style auto trackers for click, scroll, forms, rage click, dead click, page title, or UA client hints. Page `$url`/`$referrer` are attached to every event from `PugRouteObserver` route changes. This SDK does not capture install referrer/deferred attribution automatically either.
- No `cookieless` consent state. In sdk-web it is the default: events carry no identity, nothing is stored on the device, and `Event.cookieless` tells the server to derive a daily-rotating ID. This SDK has only `granted`/`denied` and never sets the flag.
