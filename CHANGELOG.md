## 0.0.5

* **Breaking:** remove campaign capture, push device registration, and device
  subscription from the public API. The backend does not accept them yet, so
  shipping the entry points invited calls that could not succeed. The code stays
  in the package and the features will be turned back on in a later release.
  * `package:pug_flutter/pug_flutter.dart` no longer exports `PugPush`,
    `PushProvider`, `PushSubscription`, `PushSubscribeOptions`,
    `PugLinkProvider`, `AppLinksPugLinkProvider`, or `campaignPropertiesFromUri`.
  * `PugOptions` no longer has `autoCaptureCampaigns` or `linkProvider`, and no
    campaign auto-properties (`$utmSource`, `$gclid`, and the rest) are attached
    to events.
  * `PugTransport` no longer declares `subscribeDevice`; a custom transport does
    not have to implement it. It moved to an internal `PugDeviceTransport` that
    `ConnectPugTransport` still implements.
* The `notification_clicked`, `notification_received`, and
  `notification_dismissed` event kinds are unaffected: they are ordinary events
  on the live events endpoint, still reachable through `Pug.track.*` and
  `PugEventNames`.
* Add automatic `app_install` and `app_update` tracking, controlled by the new
  `PugOptions.autoInstallEvents` (default on, independent of `autoTrack`).
  `app_install` is emitted on the first launch the SDK sees on a device, and
  `app_update` — carrying `previousVersion` — on the first launch after the app
  version changes. Detection compares the `$appVersion` auto-property against a
  version persisted under `__pug_<projectId>_last_version__`, so it is inactive
  when a custom `PugAutoPropertyProvider` supplies no app version. The install
  event is suppressed when other Pug state is already on the device, so adding
  this SDK to an app that already used Pug does not report its existing users as
  new installs. `Pug.destroy()` clears that state, so a destroy/re-init cycle
  does look like a fresh install.

## 0.0.4

* Add the `$deviceType` auto-property, reporting the form factor as `tv`,
  `mobile`, or `desktop`. Android TV is detected from the device's system
  features rather than the operating system, which reports plain `android`
  there; `$platform` stays `android` so the value keeps matching the other Pug
  SDKs. Omitted on web, where the host device is not detectable from Dart.
* Fix `$deviceModel` shipping the literal `"Unknown device"`/`"Unknown Model"`
  placeholders that `device_info_plus` returns when its marketing-name lookup
  misses. Those now fall back to the device identifier (`iPhone`,
  `MacBookPro18,3`). macOS was affected on any Mac absent from the plugin's
  table, which previously had no placeholder check at all.
* Omit `$osVersion` when the device-info payload has no version, instead of
  sending an empty string that overwrote the `Platform.operatingSystemVersion`
  fallback.
* Derive `$platform` from `Platform.operatingSystem` instead of
  `defaultTargetPlatform`, so `$platform` and `$os` are one value from one
  source. No change to the value on any supported platform: this removes a
  lookup table, a debug-only spoofing vector, and a `FlutterError` that
  `defaultTargetPlatform` raises on targets outside its six-member enum.
* Include the underlying error in the auto-property warning logs, which
  previously reported only that a category had failed.

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
