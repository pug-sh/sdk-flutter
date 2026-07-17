## 0.0.3

* Fix the `$platform` auto-property to send the cross-SDK lowercase value set:
  `web`, `android`, `ios`, `macos`, `linux`, `windows`, `fuchsia`. It previously
  came from `defaultTargetPlatform.name`, which keeps the enum's casing, so this
  SDK reported `iOS`/`macOS` where the rest of the Pug SDKs send `ios`/`macos`.
  The backend promotes `$platform` into a dedicated column verbatim, so the
  mismatch split one platform into per-SDK buckets in any cross-SDK breakdown.
* Fix `$platform` on Flutter web, which reported the *browser's host* OS rather
  than `web` — a web app on an iPhone was indistinguishable from native iOS
  traffic. `$platform` is now always `web` there, and equals `$os` on every
  native target.
* Document the auto-properties attached to every event in the README.

Dashboards, filters, or saved segments that match the old `iOS`/`macOS` casing
(or that treated Flutter web traffic as iOS) need updating to the lowercase set.

## 0.0.2

* Replace the `connectrpc` dependency with a hand-rolled native Connect *unary*
  transport over `package:http`. This drops the `dependency_overrides: protobuf:
  ^6.0.0` workaround that 0.0.1 forced consumers to add: the SDK now resolves
  cleanly against the `protobuf` 6.x runtime the generated code requires. Connect
  error bodies are parsed for `code`/`message`; permanent codes drop the batch
  while transient/unknown errors (e.g. `SocketException`) retry.
* Add a runnable example app under `example/`.

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
