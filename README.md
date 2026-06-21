# Pug Flutter SDK

Flutter SDK for Pug analytics, profile identity, session tracking, batching, and push device registration.

The SDK sends binary protobuf payloads to the Pug backend and keeps transport, storage, and push providers injectable for tests and custom integrations.

Requires Dart `>=3.7.0 <4.0.0` and Flutter `>=3.29.0`.

## Features

- Event tracking with typed property mapping.
- Persistent anonymous identity, profile identity, and session state.
- Local event queue with lock, commit, and rollback semantics.
- Batched protobuf transport with `x-api-key` authentication.
- `identify()` profile merge semantics with first-call anonymous ID linking.
- Provider-neutral push registration.
- Built-in Firebase Cloud Messaging provider.
- Automatic campaign capture from app links and deep links.
- Notification received, opened, and dismissed event helpers.
- Injectable storage, transport, clock, ID generator, logger, and push provider for tests.
- Well-known event constants for the shared event catalog.
- Shared-preferences-backed initialization with richer mobile auto-properties.

## Install

Add the package to your app:

```yaml
dependencies:
  pug_sdk:
    git:
      url: git@github.com:pug-sh/sdk-flutter.git
```

If you use FCM, configure Firebase for your Flutter app and initialize Firebase before asking FCM for a token:

```dart
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}
```

## Initialize

```dart
import 'package:pug_sdk/pug_sdk.dart';

Future<void> configurePug() async {
  await Pug.init(
    'project-id',
    const PugOptions(
      apiKey: 'pug_api_key',
      endpoint: 'https://api.example.com',
    ),
  );
}
```

Useful options:

```dart
await Pug.init(
  'project-id',
  PugOptions(
    apiKey: 'pug_api_key',
    endpoint: 'https://api.example.com',
    samplingRate: 1.0,
    autoTrack: true,
    batch: const BatchConfig(
      maxSize: 10,
      maxWaitMs: 5000,
      maxQueueSize: 1000,
    ),
    session: const SessionConfig(
      idleTimeout: Duration(minutes: 30),
      maxDuration: Duration(minutes: 1440),
    ),
    logger: const DebugPrintPugLogger(),
  ),
);
```

`Pug.init(...)` uses shared-preferences-backed storage and fuller auto-properties such as app version/build, device model, screen size, and network type by default. To opt out of persistence, provide `storage: MemoryPugStorage()` or another custom `PugStorage`.

Most public SDK calls are best-effort and do not throw. `Pug.track()`, `Pug.reset()`, `Pug.rotate()`, `Pug.flush()`, `Pug.destroy()`, and `PugPush` helpers catch and log runtime failures. `Pug.init()` still throws on invalid input or init failure, and `Pug.identify()` still throws on invalid input or transport failure. Repeated init calls and `identify()` calls before init are ignored with a warning.

When `autoTrack` is enabled, the SDK tracks `app_open` when the app is already
resumed at init or later enters foreground. It tracks `app_close` when the app
leaves foreground.

When `autoPageViews` is enabled (default), the SDK tracks `page_view` events when
the user navigates between routes. To enable this feature, host apps must register
the route observer with their Navigator:

```dart
// In your MaterialApp/Navigator setup
MaterialApp(
  navigatorObservers: [
    PugRouteObserver(),
  ],
  // ...
)
```

Each `page_view` event includes `url` (the route name) and `referrer` (the previous route).

Campaign capture is enabled by default. When the app receives an app link or
deep link containing UTM-style query parameters, Pug stores the latest campaign
context and attaches it to later events as auto-properties:

- `$utmSource`
- `$utmMedium`
- `$utmCampaign`
- `$utmTerm`
- `$utmContent`
- `$gclid`
- `$fbclid`
- `$msclkid`
- `$ttclid`

The host app must still configure platform deep linking, such as Android App
Links, iOS Universal Links, or a custom URL scheme. To disable campaign capture:

```dart
await Pug.init(
  'project-id',
  const PugOptions(
    apiKey: 'pug_api_key',
    autoCaptureCampaigns: false,
  ),
);
```

## Track Events

Use the typed methods for well-known events — required fields, value types,
and method names are all compile-time checked:

```dart
Pug.track.purchase(
  productId: 'sku-1',
  amount: 99.50,
  currency: 'USD',
  extras: {'cohort': 'A'},
);
Pug.track.signup();
Pug.track.search(query: 'shoes');
```

For custom or dynamic event names, the untyped form remains available:

```dart
Pug.track('cart_abandoned_v2', props: {'cartId': 'c-1', 'value': 41.0});
```

Using `Pug.track(...)` with a well-known event name still works, but emits a
debug-level hint suggesting the typed alternative. The hint is sent through the
configured `PugLogger.debug` channel, so the default `DebugPrintPugLogger`
drops it in release builds (via Flutter's `debugPrint`); custom loggers may see
it in any build mode.

### Custom Events

Custom events can use any event name and any supported property values:

```dart
Pug.track('checkout_step_viewed');

Pug.track(
  'checkout_step_viewed',
  props: {
    'step': 'shipping',
    'cartValue': 84.50,
    'hasCoupon': true,
  },
);
```

Send immediately when the event is important. If the immediate send fails with a transient error, the event is queued for retry.

```dart
Pug.track(
  'purchase',
  props: {
    'orderId': 'order-123',
    'total': 84.50,
  },
  options: const TrackOptions(immediate: true),
);
```

You can also provide an explicit timestamp:

```dart
Pug.track(
  'video_buffered',
  props: {
    'videoId': 'intro-123',
    'durationMs': 900,
  },
  options: TrackOptions(
    timestampMillis: DateTime.now().millisecondsSinceEpoch,
  ),
);
```

### Well-Known Events

Well-known events have a typed method on `Pug.track.*` with compile-time property
checking. Each method accepts an optional `extras` map for ad-hoc properties:

```dart
Pug.track.purchase(
  productId: 'sku-123',
  amount: 49.0,
  currency: 'USD',
  orderId: 'ord-1001',
);

Pug.track.search(query: 'running shoes');

Pug.track.notificationClicked(
  campaignId: 'spring-sale',
  extras: {'notificationType': 'promo'},
);
```

The untyped `Pug.track(PugEventNames.*)` path continues to work but emits a
debug-level hint recommending the typed alternative:

```dart
// Still works — emits a debug-level hint via PugLogger.debug.
// The default DebugPrintPugLogger drops it in release builds.
Pug.track(
  PugEventNames.purchase,
  props: {
    'productId': 'sku-123',
    'amount': 49.0,
    'currency': 'USD',
  },
);
```

Property values supported by the SDK:

- `String`
- `bool`
- finite `int` and `double`
- `DateTime`
- maps and lists that can be JSON encoded

Unsupported or non-finite values are dropped.

## Identify Users

```dart
await Pug.identify(
  'user-123',
  traits: {
    'email': 'user@example.com',
    'plan': 'pro',
  },
);
```

The first identify call includes the anonymous ID so the backend can merge anonymous activity into the identified profile. Later identify calls update traits without resending the anonymous ID.

## Reset And Sessions

The SDK stores a project-scoped device ID separately from session state. That
device ID is reused for session records, identify calls, and push registration.

Rotate only the session and keep the same device ID:

```dart
Pug.rotate();
```

Clear profile identity and create a new device ID:

```dart
Pug.reset();
```

Release lifecycle observers and timers:

```dart
Pug.destroy();
```

Flush explicitly when the app has a known shutdown point:

```dart
await Pug.flush();
```

## Push Registration

Push support is provider-neutral. Any provider can implement `PushProvider`.

```dart
class CustomPushProvider implements PushProvider {
  @override
  String get provider => 'custom';

  @override
  String get platform => 'android';

  @override
  Future<String> getToken() async => 'device-token';

  @override
  Future<void> deleteToken() async {}

  @override
  Map<Object?, Object?> notificationData(Object source) {
    return source is Map<Object?, Object?> ? source : const {};
  }
}

await PugPush.subscribe(
  CustomPushProvider(),
  options: const PushSubscribeOptions(
    properties: {'channel': 'stable'},
  ),
);
```

## Firebase Cloud Messaging

Use `FcmPushProvider` for Firebase Cloud Messaging:

```dart
import 'package:pug_flutter_fcm/pug_flutter_fcm.dart';

final fcm = FcmPushProvider();

await fcm.requestPermission();
await PugPush.subscribe(fcm);
```

Unsubscribe deletes the local FCM token:

```dart
await PugPush.unsubscribe(fcm);
```

Track notification lifecycle events from Firebase callbacks:

```dart
FirebaseMessaging.onMessage.listen((message) {
  final fcm = FcmPushProvider();
  PugPush.trackNotificationReceived(fcm.notificationData(message));
});

FirebaseMessaging.onMessageOpenedApp.listen((message) {
  final fcm = FcmPushProvider();
  PugPush.trackNotificationOpened(fcm.notificationData(message));
});
```

For background handlers, initialize Firebase and Pug before tracking:

```dart
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await Pug.init(
    'project-id',
    const PugOptions(apiKey: 'pug_api_key'),
  );

  final fcm = FcmPushProvider();
  PugPush.trackNotificationReceived(fcm.notificationData(message));
}
```

`notification_clicked` events require a `campaignId`. If no `campaignId` is present, the SDK sends `(unknown)`.

## Custom Transport Or Storage

Use a custom transport in tests or when embedding the SDK in a constrained runtime:

```dart
class TestTransport implements PugTransport {
  final events = <Event>[];

  @override
  Future<void> send(Event event) async {
    events.add(event);
  }

  @override
  Future<void> sendBatch(List<Event> batch) async {
    events.addAll(batch);
  }

  @override
  Future<void> identify(IdentifyRequest request) async {}

  @override
  Future<void> subscribeDevice(PushSubscription subscription) async {}
}

await Pug.init(
  'project-id',
  PugOptions(
    apiKey: 'test-key',
    transport: TestTransport(),
    storage: MemoryPugStorage(),
  ),
);
```

## Development

Install the Dart protobuf plugin:

```sh
dart pub global activate protoc_plugin
```

Generate protobuf classes:

```sh
make protos
```

Run checks:

```sh
make check
```

Individual commands:

```sh
make format
make analyze
make test
```

The SDK keeps source protos in `proto/` and generated Dart protobuf message classes in `lib/src/gen/`.
