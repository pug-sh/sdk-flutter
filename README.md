# Pug Flutter SDK

Flutter SDK for Pug analytics, profile identity, session tracking, batching, and push device registration.

The SDK sends binary protobuf payloads to the Pug backend and keeps transport, storage, and push providers injectable for tests and custom integrations.

## Features

- Event tracking with typed property mapping.
- Persistent anonymous identity, profile identity, and session state.
- Local event queue with lock, commit, and rollback semantics.
- Batched protobuf transport with `x-api-key` authentication.
- `identify()` profile merge semantics with first-call anonymous ID linking.
- Provider-neutral push registration.
- Built-in Firebase Cloud Messaging provider.
- Notification received, opened, and dismissed event helpers.
- Injectable storage, transport, clock, ID generator, logger, and push provider for tests.
- Well-known event constants and schema-aware validation for known event fields.
- Shared-preferences-backed initialization with richer mobile auto-properties.

## Install

Add the package to your app:

```yaml
dependencies:
  pug_flutter_sdk:
    git:
      url: git@github.com:fivebitsio/pug-flutter-sdk.git
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
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';

Future<void> configurePug() async {
  await Pug.initPersistent(
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
Pug.init(
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

Use `Pug.init(...)` when you want to provide custom synchronous storage yourself. Use `Pug.initPersistent(...)` for default shared-preferences-backed storage and fuller auto-properties such as app version/build, device model, screen size, and network type.

Repeated init calls are ignored with a warning. `track()` is best-effort and does not throw.

## Track Events

```dart
Pug.track(
  PugEventNames.addToCart,
  props: {
    'productId': 'shirt-001',
    'amount': 29.99,
    'currency': 'USD',
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

Rotate only the session and keep the device identity:

```dart
Pug.rotate();
```

Clear profile identity and rotate both session and device identity:

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
import 'package:pug_flutter_sdk/pug_flutter_fcm.dart';

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
  Pug.init(
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

Pug.init(
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
