## Unreleased

* `Pug.identify()` no longer throws: invalid input and transport failures are
  now logged and the future completes normally, matching the web SDK's
  never-throw `identify()`. `Pug.init()` still throws on invalid input (empty
  `projectId`/`apiKey`) — now synchronously, before the async gap, so it
  surfaces at the call site — but logs and swallows setup/start failures
  instead of re-throwing them, matching the web SDK's degrade-and-continue init.
* Route changes now emit `screen_view` (with the required `screenName`
  property) on iOS/Android and `page_view` on web, matching the proto platform
  annotations. Desktop (macOS/Windows/Linux) emits no navigation event; route
  context still rides on the `$url`/`$referrer` auto-properties.
* All notification helpers (`received`/`clicked`/`dismissed`) now default a
  missing, empty, or non-string `campaignId` to `(unknown)`. The notification
  schemas require a non-empty campaign_id, so received/dismissed events
  without one were being rejected by the server.
* `$timezone` now reports the IANA identifier (e.g. `Asia/Kolkata`) via
  `flutter_timezone`, falling back to the platform abbreviation when
  unavailable.
* Removed the `$deviceName` auto-property — user-assigned device names are PII.
* Removed the `samplingRate` option and its client-side event sampling. The web
  SDK does not sample on the client, so this was a non-parity extension; every
  consented event is now sent (sampling, if any, is a server-side concern).

## 0.0.1

Initial release.

* Analytics `track` API: untyped `Pug.track('kind', props: {...})` plus codegen'd
  typed `Pug.track.<event>(...)` methods for well-known events.
* Identity, sessions, and device registration: `init`, `identify`, `reset`,
  `rotate`, `flush`, and async `destroy()` (returns `Future<void>` and awaits a
  best-effort final flush before teardown — `await` it to drain queued events;
  the singleton detaches synchronously so a follow-up `init()` is safe).
* Batched binary-protobuf transport over Connect with lock/commit/rollback queue
  persistence; offline/transient failures retry, permanent failures drop.
* Mobile auto-properties, app lifecycle auto-tracking, auto page-views via
  `PugRouteObserver`, and automatic campaign capture from app/deep links.
* Provider-neutral push registration with notification
  received/clicked/dismissed helpers (all sent immediately).
* Pluggable storage (`SharedPreferences` default, in-memory opt-out), logger,
  clock, and ID generator.
