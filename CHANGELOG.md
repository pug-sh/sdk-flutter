## 0.0.1

Initial release.

* Analytics `track` API: untyped `Pug.track('kind', props: {...})` plus codegen'd
  typed `Pug.track.<event>(...)` methods for well-known events, with compile-time
  checking of required fields and value types.
* Identity, sessions, and device registration: `init`, `identify`, `reset`,
  `rotate`, `flush`, and async `destroy()` (awaits a best-effort final flush before
  teardown; the singleton detaches synchronously so a follow-up `init()` is safe).
* `identify()` first-call anonymous-ID merge and device-ID linking. `identify()`
  never throws; `init()` throws synchronously only on invalid input (empty
  `projectId`/`apiKey`) and otherwise logs and swallows setup failures.
* Batched binary-protobuf transport over Connect with lock/commit/rollback queue
  persistence; offline/transient failures retry, permanent failures drop.
* Tracking-consent gate (opt in/out, optional persistence) over track, identify,
  and automatic capture.
* Mobile auto-properties, app-lifecycle auto-tracking (`app_open`/`app_close`), and
  automatic campaign capture from app/deep links (requires `app_links` 6.x).
* Auto page-views via `PugRouteObserver`: route changes emit `screen_view` (with a
  `screenName` property) on iOS/Android and `page_view` on web; every event also
  carries `$url`/`$referrer` auto-properties. Desktop emits no navigation event.
* `$timezone` reports the IANA identifier (e.g. `Asia/Kolkata`), falling back to
  the platform abbreviation when unavailable; `$deviceName` is intentionally not
  sent (PII).
* Provider-neutral push registration with notification
  received/clicked/dismissed helpers (all sent immediately; a missing, empty, or
  non-string `campaignId` defaults to `(unknown)`).
* Pluggable storage (`SharedPreferences` default, in-memory opt-out), logger,
  clock, and ID generator.
