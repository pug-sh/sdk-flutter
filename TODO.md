# Feature Parity With `../cotton-web-sdk`

## Completed

- [x] Generate and use well-known event proto definitions.
  - Add `common/v1/well_known_events.proto`.
  - Run `make protos`.
  - Validate well-known event properties before enqueueing.
  - Preserve schema scalar types for known fields, while accepting extra properties.

- [x] Improve in-flight queue durability semantics.
  - Exclude locked events from queue `size`.
  - Prevent concurrent locks from relocking the in-flight batch.
  - Avoid dropping locked in-flight events when the queue is full.

- [x] Expose well-known event names/types in the public API where Dart can do so ergonomically.
  - Added public `PugEventNames` constants and a `PugProperties` typedef.

- [x] Add out-of-the-box persistent Flutter storage.
  - Added `SharedPreferencesPugStorage`.
  - `Pug.init(...)` is async and defaults to shared-preferences storage; persistence is opt-out via `storage: MemoryPugStorage()` or another custom `PugStorage`.

## Completed In Follow-Up

- [x] Add fuller mobile auto-properties.
  - Include app version/build, device manufacturer/model, screen size, and network type where available without sensitive permissions.
  - Keep existing `$projectId`, `$sdkVersion`, `$platform`, `$os`, `$osVersion`, `$locale`, and `$timezone`.

- [x] Improve lifecycle flush/destroy parity.
  - Flush queued events on app background and destroy opportunities.
  - Keep events durable if a flush is in flight.

- [x] Revisit push packaging.
  - Web keeps push optional for bundle size.
  - Core barrel no longer exports FCM symbols; FCM users import `pug_flutter_fcm.dart`.
  - Full dependency-level optionality would require a separate package because Dart packages do not support optional dependencies.

- [x] Add docs/tests for each parity feature as it lands.
  - Keep tests focused on behavior shared with the web SDK and mobile-specific expectations from `mobile-sdk-ai-spec.md`.

- [x] Add auto page view tracking.
  - Added `autoPageViews` option (default: true).
  - Added `PugRouteObserver` that tracks `page_view` events on route changes.
  - Added `$url` and `$referrer` properties to page_view events.
  - Host apps must register `Pug.routeObserver` with their Navigator.
