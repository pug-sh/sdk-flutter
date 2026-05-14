# Pug Mobile SDK AI Implementation Spec

Use this document as the prompt/spec for building first-party Pug SDKs for Android
(Kotlin) and iOS (Swift). The mobile SDKs must match the product semantics of the
existing `pug-web` SDK in this repository while using idiomatic native APIs.

## Context From The Web SDK

Pug is an analytics, profile identity, session, batching, and push device
registration SDK. The current web SDK exposes:

- `init(projectId, options)`
- `track(kind, props?, options?)`
- `identify(externalId, traits?)`
- `reset()`
- `destroy()`
- `rotate()` for forcing a new session
- optional push APIs: subscribe/unsubscribe push and notification click tracking

Core invariants to preserve:

- Public SDK APIs must never throw or crash the host app. They are best-effort
  only.
- `init()`, `identify()`, and push registration should log/report failures
  without throwing to the host app.
- SDK state is single-instance by default. Repeated `init()` should warn/no-op.
- Events are protobuf `sdk.events.v1.Event` messages sent through
  `sdk.events.v1.EventsService.BatchCreate`.
- API calls must send the API key with an `x-api-key` header.
- Use binary protobuf over ConnectRPC or an equivalent backend-compatible
  transport.
- Do not expose internal modules as public API.
- Use persistent local storage with in-memory fallback when persistence fails.
- Keep push support modular so apps that do not use push do not need push
  dependencies.

Backend services used by web:

- `sdk.events.v1.EventsService.BatchCreate`
- `sdk.profiles.v1.ProfilesSDKService.Identify`
- `sdk.devices.v1.DevicesService.Subscribe`

Well-known event names currently include:

`add_to_cart`, `app_close`, `app_open`, `checkout_completed`,
`checkout_started`, `click`, `dead_click`, `error_occurred`, `form_start`,
`form_submit`, `login`, `logout`, `notification_clicked`,
`notification_dismissed`, `notification_received`, `page_view`, `purchase`,
`rage_click`, `scroll`, `search`, `share`, `signup`, `video_pause`,
`video_play`.

## Goal

Build two SDKs:

- Android: Kotlin, distributed as an Android library.
- iOS: Swift, distributed as a Swift Package.

Both SDKs must share the same conceptual API, same backend protocol, same storage
keys where practical, same event/property semantics, and same extensibility model.

The implementation must be extensible beyond FCM/APNs. Push delivery provider
support must be interface-driven so future providers such as Huawei Push Kit,
OneSignal, Expo, custom enterprise providers, or web push bridges can be added
without rewriting device registration, identity linking, or notification event
tracking.

## Public API Shape

Keep names idiomatic per platform but conceptually aligned.

### Android Kotlin

```kotlin
object Pug {
  fun init(context: Context, projectId: String, options: PugOptions)
  fun track(kind: String, props: Map<String, Any?> = emptyMap(), options: TrackOptions = TrackOptions())
  suspend fun identify(externalId: String, traits: Map<String, Any?> = emptyMap())
  fun reset()
  fun rotate()
  fun destroy()
}

data class PugOptions(
  val apiKey: String,
  val endpoint: String = "http://localhost:8080",
  val samplingRate: Double = 1.0,
  val batch: BatchConfig = BatchConfig(),
  val session: SessionConfig = SessionConfig(),
  val autoTrack: Boolean = true,
  val dryRun: Boolean = false,
  val logger: PugLogger = NoopOrPlatformLogger,
  val storage: PugStorage? = null,
  val transport: PugTransport? = null,
)

data class TrackOptions(
  val immediate: Boolean = false,
  val timestampMillis: Long? = null,
)
```

### iOS Swift

```swift
public final class Pug {
  public static let shared = Pug()

  public func initialize(projectId: String, options: PugOptions)
  public func track(_ kind: String, properties: [String: Any?] = [:], options: TrackOptions = .init())
  public func identify(externalId: String, traits: [String: Any?] = [:]) async throws
  public func reset()
  public func rotate()
  public func destroy()
}

public struct PugOptions {
  public var apiKey: String
  public var endpoint: URL
  public var samplingRate: Double
  public var batch: BatchConfig
  public var session: SessionConfig
  public var autoTrack: Bool
  public var dryRun: Bool
  public var logger: PugLogger
  public var storage: PugStorage?
  public var transport: PugTransport?
}

public struct TrackOptions {
  public var immediate: Bool
  public var timestampMillis: Int64?
}
```

## Required Internal Interfaces

Create small interfaces/protocols so the SDK can evolve without broad rewrites.

### Storage

Android:

```kotlin
interface PugStorage {
  fun getString(key: String): String?
  fun setString(key: String, value: String)
  fun remove(key: String)
}
```

iOS:

```swift
public protocol PugStorage {
  func string(forKey key: String) -> String?
  func set(_ value: String, forKey key: String)
  func removeValue(forKey key: String)
}
```

Default implementations:

- Android: `SharedPreferencesPugStorage`.
- iOS: `UserDefaultsPugStorage`.
- Persistent storage is the default. Callers opt out by supplying in-memory or
  custom storage explicitly.
- Provide in-memory fallback for restricted or failing persistence.

### Transport

```kotlin
interface PugTransport {
  suspend fun send(event: Event)
  suspend fun sendBatch(events: List<Event>)
}
```

```swift
public protocol PugTransport {
  func send(event: Event) async throws
  func sendBatch(events: [Event]) async throws
}
```

Default implementation must call ConnectRPC/protobuf backend with binary
protobuf and `x-api-key`.

### Queue Storage

Use a two-phase queue protocol:

- `push(event)`
- `lock(limit): List<Event>`
- `commit()`
- `rollback()`
- `peekUnlocked()`
- `size`
- `dispose()`

Implement a persistent queue backed by platform storage, with in-memory fallback.
The lock/commit/rollback behavior prevents losing events when a batch is in
flight.

### Clock And IDs

Abstract time and ID generation for tests.

- Default event IDs and session IDs should be UUIDv7 if available. If native
  UUIDv7 support is not practical, implement a small UUIDv7 generator or use a
  stable library. Avoid random UUIDv4 unless absolutely necessary.
- Use epoch milliseconds for public timestamp options.

### Logger

Provide a logger interface with `debug`, `warn`, and `error`. Default to Android
Log / Apple OSLog or a no-op logger depending on platform conventions. Never log
API keys, push tokens, or full request payloads by default.

## Event Creation

Every event must contain:

- fresh `eventId`
- `projectId` as auto property `$projectId`
- `kind`
- `sessionId`
- `distinctId`
- `occurTime`
- `customProperties`
- mobile auto properties

Use the generated protobuf `PropertyValue` oneof for custom and auto
properties.

Property mapping:

- `String` -> `stringValue`, truncated to 1024 UTF-8 bytes.
- `Boolean` -> `boolValue`.
- finite integer numeric values -> `intValue`.
- finite floating numeric values -> `doubleValue`.
- dates/instants -> `timestampValue`.
- maps/lists/arrays/objects -> JSON string if safely serializable.
- `null`/`nil` -> drop silently.
- unsupported/non-finite values -> drop and warn.

For well-known events, validate against generated protobuf property schemas when
the platform protobuf/protovalidate tooling makes this practical. Extra
properties not in the well-known schema should still be accepted and serialized
through the loose mapping above. Invalid well-known events should be dropped with
an error log, not thrown from `track()`.

Mobile auto properties should include at least:

- `$projectId`
- `$sdkVersion`
- `$platform` (`android` or `ios`)
- `$os`
- `$osVersion`
- `$deviceManufacturer` where available
- `$deviceModel`
- `$appVersion`
- `$appBuild`
- `$locale`
- `$timezone`
- `$screenWidth`
- `$screenHeight`
- `$networkType` if available without sensitive permissions

Do not collect advertising IDs, contacts, precise location, or other sensitive
data unless a future explicit option is added.

## Session Management

Match web SDK behavior conceptually:

- Sessions are lazily resolved on each `track()`.
- Default idle timeout: 30 minutes.
- Default max session duration: 1440 minutes.
- Expire and rotate when either timeout is exceeded.
- Persist under project-namespaced keys:
  - `__pug_<projectId>_session__`
  - `__pug_<projectId>_profile__`
  - `__pug_<projectId>_device_id__`
  - `__pug_<projectId>_external_id__`
  - `__pug_<projectId>_queue__`
- Session state should include:
  - `sessionId`
  - `startTime`
  - `lastActivityTime`
  - `deviceId`
- `rotate()` creates a new session but preserves device ID.
- `reset()` rotates both session and device identity and clears profile identity.
- Device ID is a project-scoped SDK identity. Store it separately from session
  state and copy it into session records when needed for payload compatibility.
- Use app lifecycle hooks to track app foreground/background. Track `app_open`
  and `app_close` automatically if `autoTrack` is enabled.

## Profile Identity

Implement anonymous and identified profiles:

- Anonymous IDs are persistent and prefixed with `anon-`.
- `resolveDistinctId()` returns external ID after identify, otherwise anonymous
  ID.
- `identify(externalId, traits)` calls `ProfilesSDKService.Identify`.
- First identify includes anonymous ID so the backend can merge anonymous into
  identified profile.
- Subsequent identify calls omit anonymous ID and update traits only.
- If a device ID exists, first identify should include it for push device
  linking if the backend request type supports that field.

`identify()` should log/report errors without throwing to the caller. `track()`
should not throw.

## Batching

Defaults:

- `maxSize = 10`
- `maxWaitMs = 5000`
- `maxQueueSize = 1000`

Behavior:

- Queue events before sending.
- Flush when `maxSize` is reached.
- Flush after `maxWaitMs`.
- Flush on app background/termination opportunities.
- `TrackOptions.immediate` attempts direct send first, then queues on transient
  errors.
- Permanent errors drop events and log.
- Transient errors rollback locked events and retry later.
- Do not retry forever in a tight loop. Use timers/backoff and lifecycle flushes.

Classify gRPC/Connect errors similarly to the web SDK:

- Permanent: InvalidArgument, NotFound, AlreadyExists, PermissionDenied,
  FailedPrecondition, Unimplemented, Unauthenticated.
- Transient: unavailable, deadline exceeded, resource exhausted, aborted,
  internal/unknown network failures that are likely retryable.

## Push Extensibility Model

Do not hard-code the SDK to FCM. FCM/APNs should be default provider
implementations behind interfaces.

### Shared Concepts

Define a provider-neutral device subscription model:

```kotlin
data class PushSubscription(
  val provider: String,
  val platform: String,
  val token: String,
  val deviceId: String,
  val profileId: String? = null,
  val profileExternalId: String? = null,
  val properties: Map<String, Any?> = emptyMap(),
)
```

```swift
public struct PushSubscription {
  public var provider: String
  public var platform: String
  public var token: String
  public var deviceId: String
  public var profileId: String?
  public var profileExternalId: String?
  public var properties: [String: Any?]
}
```

`provider` examples: `fcm`, `apns`, `hms`, `onesignal`, `expo`, `custom`.

`platform` examples: `android`, `ios`, `web`. If the backend currently expects
only `web` in examples, still design the mobile SDK to send `android`/`ios` and
make this visible as a backend compatibility requirement.

### Android Push Interfaces

```kotlin
interface PushProvider {
  val provider: String
  val platform: String
  suspend fun getToken(context: Context): String
  suspend fun deleteToken(context: Context)
  fun notificationDataFromIntent(intent: Intent): Map<String, Any?>
}

interface DeviceRegistrar {
  suspend fun subscribe(subscription: PushSubscription)
}
```

Default Android implementation:

- `FcmPushProvider` in a separate optional artifact/module if possible:
  `pug-android-push-fcm`.
- Depends on Firebase Messaging only in that optional artifact.
- Core SDK must not require Firebase.

Android API:

```kotlin
object PugPush {
  suspend fun subscribe(
    context: Context,
    provider: PushProvider,
    options: PushSubscribeOptions = PushSubscribeOptions(),
  )

  suspend fun unsubscribe(context: Context, provider: PushProvider)

  fun trackNotificationOpened(intent: Intent)
  fun trackNotificationReceived(data: Map<String, Any?>)
  fun trackNotificationDismissed(data: Map<String, Any?>)
}
```

### iOS Push Interfaces

```swift
public protocol PushProvider {
  var provider: String { get }
  var platform: String { get }
  func requestAuthorization(options: UNAuthorizationOptions) async throws -> Bool
  func currentToken() async throws -> String
  func deleteToken() async throws
  func notificationData(from userInfo: [AnyHashable: Any]) -> [String: Any?]
}

public protocol DeviceRegistrar {
  func subscribe(_ subscription: PushSubscription) async throws
}
```

Default iOS implementation:

- `ApnsPushProvider` in the core iOS package if it only uses Apple frameworks.
- If an FCM-on-iOS provider is desired, place it in an optional product:
  `PugFirebasePush`.
- Core SDK must not require Firebase.

iOS API:

```swift
public enum PugPush {
  public static func subscribe(
    provider: PushProvider,
    options: PushSubscribeOptions = .init()
  ) async throws

  public static func unsubscribe(provider: PushProvider) async throws

  public static func trackNotificationOpened(userInfo: [AnyHashable: Any])
  public static func trackNotificationReceived(userInfo: [AnyHashable: Any])
  public static func trackNotificationDismissed(userInfo: [AnyHashable: Any])
}
```

### Push Device Registration

Push subscribe must:

- get or create persistent SDK device ID
- ask provider for its token
- call `DevicesService.Subscribe`
- send:
  - `deviceId`
  - `platform`
  - `token`
  - `profileId` if supplied
  - `profileExternalId` if supplied
  - `properties` if supplied
- include provider name in `properties` if the backend proto has no explicit
  `provider` field yet, for example `properties["pushProvider"] = "fcm"`.

Push unsubscribe should remove/delete the provider token locally when supported.
If the backend later adds an unsubscribe RPC, implement it behind
`DeviceRegistrar` without changing app-facing APIs.

### Notification Event Tracking

Track these events when app integrations call the SDK hooks:

- `notification_received`
- `notification_clicked`
- `notification_dismissed`

Sanitize notification data before sending:

- keep only flat strings, numbers, booleans, and timestamps
- drop nested objects/arrays unless explicitly JSON-stringified by caller
- ensure `campaignId` exists on `notification_clicked`; default to `(unknown)`

The SDK should not own the app's notification UI. It should provide small hooks
that apps can call from `FirebaseMessagingService`, `Application`, `Activity`,
`UNUserNotificationCenterDelegate`, or `AppDelegate`.

## Auto Tracking

Mobile auto tracking should be native and conservative:

Android:

- register `Application.ActivityLifecycleCallbacks`
- track `app_open` when app enters foreground
- track `app_close` when app enters background
- optionally track screen/page views through explicit `Pug.trackScreen(name)` or
  lifecycle callbacks when Activity names are acceptable

iOS:

- observe `UIApplication.didBecomeActiveNotification`,
  `UIApplication.didEnterBackgroundNotification`, and scene lifecycle where
  appropriate
- track `app_open` and `app_close`
- optionally expose `Pug.trackScreen(name)`

Avoid invasive click/form/dead-click style tracking on mobile for the first
version unless explicitly requested later.

## Packaging

Android:

- `pug-android-core`: analytics, identity, session, batching, transport, storage.
- `pug-android-push-fcm`: optional Firebase Messaging provider.
- Optional future modules: `pug-android-push-hms`, `pug-android-push-onesignal`.
- Use Kotlin coroutines for async work.
- Support minSdk that matches project needs; if unknown, choose a conservative
  minSdk such as 23 and document it.

iOS:

- Swift Package with product `Pug`.
- Optional product `PugFirebasePush` only if Firebase support is implemented.
- Use Swift concurrency for async work.
- Support iOS 13+ unless project constraints require otherwise.

## Testing Requirements

Add tests for:

- init validation and repeated init behavior
- `track()` never throws
- event property mapping and string truncation
- session expiry and rotation
- profile identify first-call anonymous merge behavior
- reset clears profile and rotates device/session identity
- batching lock/commit/rollback
- transient vs permanent transport errors
- push provider registration using a fake provider
- notification payload sanitization

Use fake storage, fake transport, fake clock, fake ID generator, and fake push
provider. Do not require Firebase/APNs in core SDK tests.

## Deliverables

For each platform, produce:

- source code for the SDK
- README with installation and usage
- API reference for public types
- push integration guide
- tests
- sample app or minimal integration snippet

The implementation should be idiomatic native code, but the product behavior
should stay aligned with the web SDK described above.
