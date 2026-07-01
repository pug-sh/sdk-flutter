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
