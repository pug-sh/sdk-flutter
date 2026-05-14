# Pug Flutter SDK Parity With `../cotton-web-sdk`

This document compares the Flutter SDK in this repository with the sibling web SDK at `../cotton-web-sdk`.

The goal is product-semantic parity where it makes sense for mobile. Browser-only behavior should not be copied directly unless there is a native mobile equivalent that is reliable, expected, and low-risk for host apps.

## Summary

| Area | Web SDK | Flutter SDK | Parity |
|---|---|---|---|
| Singleton lifecycle | `init`, `destroy`, `reset`, `rotate` | `Pug.init`, `Pug.destroy`, `Pug.reset`, `Pug.rotate` | Complete |
| Manual event tracking | `track(kind, props?, opts?)` | `Pug.track(kind, props:, options:)` | Complete |
| Best-effort `track()` | Never throws | Never throws | Complete |
| Identify/profile merge | First identify sends anonymous ID; later calls omit it | Same behavior | Complete |
| Sessions | Lazy resolve, idle/max expiry, rotate/reset | Same mobile semantics | Complete |
| Device ID | Used for push identity/linking | Project-scoped device ID, preserved across session rotation | Complete |
| Persistent storage | `localStorage` with memory fallback | `SharedPreferencesPugStorage` with memory fallback | Complete |
| Queue semantics | Two-phase lock/commit/rollback | Two-phase lock/commit/rollback | Complete |
| Batching | Size/timer flush, immediate sends | Size/timer flush, immediate sends | Complete |
| Transport | Connect-compatible protobuf HTTP | Connect-compatible protobuf HTTP | Complete |
| API key transport | `x-api-key`; beacon uses query param | `x-api-key` | Complete for normal HTTP |
| Shutdown delivery | `sendBeacon` on unload | Best-effort async flush on background/destroy | Mobile equivalent |
| Well-known events | Generated schemas + TS type overloads | Generated schemas + constants + runtime validation | Mobile/Dart equivalent |
| Property mapping | Typed protobuf values, truncation, schema-aware known props | Typed protobuf values, truncation, schema-aware known props | Complete |
| Auto properties | Browser URL/referrer/title/screen/locale/UA/UTM | Mobile app/device/screen/network/locale/campaign | Mobile equivalent |
| Campaign/UTM capture | Current page URL query params | Initial/later app links and deep links | Mobile equivalent |
| Auto page views | `page_view` from History API/popstate | Not automatic | Not implemented |
| Auto clicks | DOM click listener | Not automatic | Intentionally omitted |
| Auto scroll | DOM/window scroll tracker | Not automatic | Intentionally omitted |
| Auto forms | DOM form/input tracker | Not automatic | Intentionally omitted |
| Frustration signals | `rage_click`, `dead_click` | Not automatic | Intentionally omitted |
| Push subscription | Optional web-push/VAPID module | Provider-neutral push API plus FCM provider | Mobile equivalent |
| Notification click tracking | Service worker + page helper | Explicit mobile notification helper hooks | Mobile equivalent |
| Package optionality | Push is tree-shakeable and optional | Core barrel avoids FCM exports, but package still depends on FCM | Partial |

## Public API

### Web

`../cotton-web-sdk/src/pug.ts` exports:

- `init(projectId, options)`
- `track(kind, props?, opts?)`
- `identify(externalId, traits?)`
- `reset()`
- `rotate()`
- `destroy()`

The web barrel also exports push helpers from `push.ts`.

### Flutter

`lib/src/pug.dart` exposes:

- `Pug.init(projectId, options)`
- `Pug.track(kind, props:, options:)`
- `Pug.identify(externalId, traits:)`
- `Pug.reset()`
- `Pug.rotate()`
- `Pug.flush()`
- `Pug.destroy()`

`lib/src/push.dart` exposes provider-neutral push helpers through `PugPush`.

**Parity note:** Dart cannot match TypeScript's overloaded `TrackFn` and `WellKnownEventPropsMap` ergonomics directly. Flutter exposes `PugEventNames` constants and performs runtime schema-aware validation instead.

## Initialization And Lifecycle

Web `init()` configures session/profile state, warms UA client hints, creates the batched transport, and installs browser auto-trackers. `destroy()` removes tracker cleanups, destroys transport state, clears session/profile runtime state, and allows re-init.

Flutter `Pug.init()` asynchronously prepares shared preferences storage and system auto-properties, then starts `PugClient`. `PugClient.start()` validates config, attaches lifecycle observation, captures campaign links when enabled, emits `app_open` if already foregrounded, and schedules flushing. `destroy()` cancels timers, starts a best-effort final flush, disposes queue state, removes lifecycle observation, and stops campaign link listening.

**Parity status:** Complete, with mobile lifecycle substitutions.

## Event Creation

Both SDKs build protobuf `sdk.events.v1.Event` payloads with:

- fresh event ID
- kind
- top-level session ID
- top-level distinct ID
- occurrence time
- custom properties
- auto-properties

Both SDKs preserve schema scalar types for well-known fields and accept loose extra properties when they can be represented as `PropertyValue`.

Differences:

- Web supports JavaScript `bigint` and maps safe integers to integer values.
- Flutter maps Dart `int` to integer values and finite `num`/`double` to double values.
- Web uses generated TypeScript schema types for compile-time narrowing.
- Flutter uses constants plus runtime validation.

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

**Parity status:** Mobile equivalent. Browser URL, referrer, page title, and UA client hints do not map cleanly to native mobile apps.

## Campaign Capture

Web parses UTM params from `location.search`.

Flutter uses `app_links` through `PugLinkProvider`:

- reads the initial app/deep link on start
- listens for later app/deep links
- stores the latest campaign context under `__pug_<projectId>_campaign__`
- attaches campaign fields to later events as auto-properties

Host apps must still configure platform deep linking, such as Android App Links, iOS Universal Links, or a custom URL scheme.

**Parity status:** Mobile equivalent for link-open attribution. Deferred install referrer attribution is not implemented.

## Sessions And Identity

Both SDKs:

- lazily resolve sessions on event creation
- default to 30 minute idle timeout and 1440 minute max duration
- rotate sessions while preserving device ID
- reset both session and device identity
- use anonymous profile IDs prefixed with `anon-`
- send anonymous ID only on the first successful identify merge
- persist external ID for future events

Web additionally has browser cross-tab session coordination. Flutter does not need that exact behavior because there are no same-origin browser tabs sharing one local storage namespace.

**Parity status:** Complete for mobile.

## Queue And Transport

Both SDKs:

- queue events before sending
- flush by batch size and max wait
- support immediate sends
- use lock/commit/rollback for in-flight batches
- permanently drop permanent failures
- roll back transient failures
- send binary protobuf payloads to Connect-compatible endpoints
- send API keys with `x-api-key`

Web additionally uses `navigator.sendBeacon` during page unload and puts the API key in a query param for beacon requests because beacon cannot carry headers.

Flutter performs best-effort async flush on background and destroy.

**Parity status:** Complete for normal transport; mobile equivalent for shutdown.

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

### Not Ported To Flutter

The browser trackers are not copied because mobile has different UX, routing, privacy expectations, and widget architecture. Automatically observing every tap, form field, scroll, or "dead click" equivalent in Flutter would be invasive and brittle without explicit app instrumentation.

Potential future mobile APIs:

- explicit `Pug.trackScreen(name, properties?)`
- route observer integration for screen views
- optional app-provided UI instrumentation hooks

**Parity status:** Intentional mobile divergence.

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

It includes an FCM provider in `pug_flutter_fcm.dart`.

Notification event names align:

- `notification_received`
- `notification_clicked`
- `notification_dismissed`

Both SDKs default missing `campaignId` on notification clicks to `(unknown)`.

**Parity status:** Mobile equivalent. Dependency-level optionality is partial because the Flutter package still depends on `firebase_messaging`; a separate FCM package would be needed for full optionality.

## Remaining Gaps

- No automatic screen/page view tracking in Flutter.
- No explicit `Pug.trackScreen(...)` helper yet.
- No Flutter route observer integration.
- No install referrer or deferred deep-link attribution.
- No automatic tap/form/scroll/frustration tracking, by design.
- Push provider is API-neutral, but FCM is still a package dependency.
- No `sendBeacon` equivalent; background/destroy flush remains best-effort.
- No compile-time well-known event property narrowing equivalent to TypeScript overloads.

## Compatibility Notes

The Flutter SDK currently supports:

- Dart `>=3.7.0 <4.0.0`
- Flutter `>=3.29.0`

This floor is driven primarily by the checked-in generated protobuf code and `protobuf` runtime compatibility.

## Maintenance Checklist

When changing parity-sensitive behavior:

- Update this document.
- Update `CLAUDE.md` if agent guidance changes.
- Update `TODO.md` if a gap is closed or a new gap is accepted.
- Add tests in `test/pug_flutter_sdk_test.dart` for shared semantics or mobile substitutions.
- Prefer injected fakes for platform features, especially link capture, storage, transport, clock, ID generation, and push providers.
