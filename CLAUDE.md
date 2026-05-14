# CLAUDE.md

This file provides guidance to Claude Code when working in this repository.

## Project Overview

Pug Flutter SDK is a Flutter/Dart analytics, identity, session, batching, and push device registration SDK. It is intended to match the product semantics of `../cotton-web-sdk` while using Flutter-native lifecycle and storage APIs.

The public barrel is `lib/pug_flutter_sdk.dart`. Core runtime logic lives under `lib/src/`; generated protobuf Dart code lives under `lib/src/gen/` and is produced from `proto/**/*.proto`.

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

- `Pug.init(projectId, options)` initializes synchronously with caller-provided storage or memory fallback.
- `Pug.initPersistent(projectId, options)` initializes asynchronously with `SharedPreferencesPugStorage` by default.
- `Pug.track(kind, props:, options:)` is best-effort and must never throw.
- `Pug.identify(externalId, traits:)` reports errors to the caller.
- `Pug.reset()`, `Pug.rotate()`, and `Pug.destroy()` manage identity/session/runtime state.

`PugPush` in `lib/src/push.dart` exposes provider-neutral push subscription, unsubscription, and notification event helpers.

### Runtime

`PugClient` in `lib/src/runtime.dart` owns transport, queue, storage, session/profile state, sampling, flush scheduling, and Flutter lifecycle observation. `track()` builds an `Event`, queues or sends it immediately, and catches all failures.

Auto tracking is conservative for mobile: when `autoTrack` is enabled, lifecycle changes emit `app_open` and `app_close`.

### Storage

`PugStorage` is synchronous by design so event/session/profile reads can happen inside `track()`.

- `MemoryPugStorage` is the fallback.
- `SafePugStorage` wraps a primary store and switches to memory if persistence throws.
- `SharedPreferencesPugStorage` provides default persistent storage for `Pug.initPersistent(...)`.

State keys are project-namespaced:

- `__pug_<projectId>_session__`
- `__pug_<projectId>_profile__`
- `__pug_<projectId>_external_id__`
- `__pug_<projectId>_queue__`

### Queue

`PugEventQueue` uses a two-phase lock/commit/rollback protocol:

- `push(event)` appends an event, dropping oldest unlocked events when full.
- `lock(limit)` reserves unlocked events for a flush and returns `[]` if a batch is already locked.
- `commit()` removes locked events after success.
- `rollback()` restores locked events after transient failure.
- `size` counts only unlocked events, matching the web SDK's in-flight semantics.

Do not change this behavior casually; it prevents duplicate locks and avoids dropping in-flight events.

### Transport

`HttpPugTransport` sends binary protobuf payloads over Connect-compatible HTTP endpoints with `x-api-key` and `connect-protocol-version: 1`.

RPC paths:

- `/sdk.events.v1.EventsService/BatchCreate`
- `/sdk.profiles.v1.ProfilesSDKService/Identify`
- `/sdk.devices.v1.DevicesService/Subscribe`

Permanent HTTP failures drop events; transient failures roll back and retry later.

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

Well-known event schemas are generated from `proto/common/v1/well_known_events.proto` and mirrored by the runtime registry in `lib/src/events.dart`. Known fields are schema-aware, so integer-valued double fields still serialize as `doubleValue`; extra properties remain accepted through loose mapping.

`PugEventNames` in `lib/src/well_known_events.dart` exposes public constants for all well-known event names.

### Identity And Sessions

Sessions are lazily resolved on event creation. Defaults match the web/mobile spec: 30 minute idle timeout and 1440 minute max duration. `rotate()` creates a new session while preserving device ID. `reset()` rotates both session and device identity and clears profile identity.

Anonymous profile IDs are prefixed with `anon-`. The first successful `identify()` includes anonymous ID for backend merge semantics; subsequent identifies omit it.

### Push

Push is provider-neutral at the API level through `PushProvider`, but the package currently depends directly on `firebase_messaging` for the built-in `FcmPushProvider`. This differs from `../cotton-web-sdk`, where push is imported as an optional module and non-push users avoid push bundle cost.

Notification helper events:

- `notification_received`
- `notification_clicked`
- `notification_dismissed`

Notification payload sanitization keeps only flat strings, booleans, finite numbers, and timestamps. `notification_clicked` defaults missing `campaignId` to `(unknown)`.

## Design Invariants

- `track()` must never throw or crash the host app.
- `init()`, `identify()`, and push registration may report explicit failures.
- Repeated init warns and no-ops.
- Keep generated protobuf code generated; update `.proto` files and run `make protos`.
- Do not log API keys, push tokens, or full request payloads by default.
- Prefer small injectable interfaces over hard-coded platform dependencies.

## Current Feature Parity With `../cotton-web-sdk`

Implemented parity:

- Singleton init/destroy/reset/rotate lifecycle.
- Best-effort `track()` invariant.
- Batched event transport with binary protobuf and `x-api-key`.
- Persistent queue semantics with lock/commit/rollback.
- Session expiry, rotation, reset, and profile distinct ID behavior.
- `identify()` first-call anonymous merge behavior and device ID linking.
- Well-known event names and schema-aware property mapping.
- Provider-neutral push registration model.
- Notification received/clicked/dismissed helpers.
- Dry run, sampling rate clamping, custom logger, injectable storage/transport/clock/ID generator.

Flutter/mobile-specific parity:

- App lifecycle auto tracking for `app_open` and `app_close`.
- `SharedPreferencesPugStorage` via async `Pug.initPersistent(...)`.
- Built-in FCM provider.

Remaining gaps:

- Mobile auto-properties are still thinner than the mobile spec and web auto-properties. Current properties include `$projectId`, `$sdkVersion`, `$platform`, `$os`, `$osVersion`, `$locale`, and `$timezone`; pending work should add app version/build, device manufacturer/model, screen size, and network type where safe.
- Lifecycle flush/destroy parity is incomplete. The SDK flushes on app close/background, but does not yet have a web-style beacon equivalent or a fully documented destroy-while-flushing recovery story.
- Push packaging is not at web parity. Web keeps push optional/tree-shakeable; this Flutter package currently has `firebase_messaging` in the main dependency graph.
- Dart cannot match TypeScript's overloaded `TrackFn`/`WellKnownEventPropsMap` ergonomics directly. Current parity is constants plus runtime schema-aware validation.
- No browser-style auto trackers for click, scroll, forms, rage click, dead click, page URL/referrer/title, UTM, or UA client hints. These are mostly web-specific and intentionally not implemented for mobile unless a future product requirement says otherwise.

Keep `TODO.md` synchronized when closing or adding parity items.
