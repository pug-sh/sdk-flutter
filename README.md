# Pug Flutter SDK

Flutter SDK for Pug analytics, profile identity, session tracking, batching, and push device registration.

The SDK sends binary protobuf payloads to the Pug backend and keeps transport, storage, and push providers injectable for tests and custom integrations.

Requires Dart `>=3.7.0 <4.0.0` and Flutter `>=3.29.0`. The generated protobuf code targets the `protobuf` 6.x runtime (`>=6.0.0 <7.0.0`).

## Features

- Event tracking with typed property mapping.
- Persistent anonymous identity, profile identity, and session state.
- Local event queue with lock, commit, and rollback semantics.
- Batched protobuf transport with `x-api-key` authentication.
- `identify()` profile merge semantics with first-call anonymous ID linking.
- Tracking consent gate with opt in/out and optional persistence.
- Provider-neutral push registration.
- Automatic campaign capture from app links and deep links.
- Injectable storage, transport, clock, ID generator, logger, and push provider for tests.
- Well-known event constants for the shared event catalog.
- Shared-preferences-backed initialization with richer mobile auto-properties.

## Install

Add the package to your app:

```bash
flutter pub add pug_flutter
```

Or add it to `pubspec.yaml` directly:

```yaml
dependencies:
  pug_flutter: ^0.0.2
```

## Initialize

```dart
import 'package:pug_flutter/pug_flutter.dart';

Future<void> configurePug() async {
  await Pug.init(
    'project-id',
    const PugOptions(
      apiKey: 'pug_api_key',
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

`endpoint` is optional and defaults to `https://api.pugs.dev`; set it only to point at a different backend.

`Pug.init(...)` uses shared-preferences-backed storage and fuller auto-properties such as app version/build, device model, screen size, and network type by default. To opt out of persistence, provide `storage: MemoryPugStorage()` or another custom `PugStorage`.

Public SDK calls are best-effort and do not throw. `Pug.track()`, `Pug.identify()`, `Pug.reset()`, `Pug.rotate()`, `Pug.flush()`, `Pug.destroy()`, and `PugPush` helpers catch and log runtime failures. `Pug.init()` is the one exception: it throws synchronously on invalid input (empty `projectId`/`apiKey`) so a misconfiguration surfaces at the call site, but setup failures during startup are logged and swallowed. `Pug.identify()` never throws — invalid input and transport failures are logged and the future completes normally. Repeated init calls and `identify()` calls before init are ignored with a warning.

When `autoTrack` is enabled, the SDK tracks `app_open` when the app is already
resumed at init or later enters foreground. It tracks `app_close` when the app
leaves foreground.

When `autoPageViews` is enabled (default), the SDK tracks a navigation event when
the user navigates between routes: `screen_view` (with a `screenName` property) on
iOS/Android, and `page_view` on web. Desktop (macOS/Windows/Linux) emits no
navigation event, since the schema limits `screen_view` to iOS/Android and
`page_view` to web; the route still updates the `$url`/`$referrer` auto-properties
carried by other events. To enable this feature, host apps must register the route
observer with their Navigator:

```dart
// In your MaterialApp/Navigator setup
MaterialApp(
  navigatorObservers: [
    PugRouteObserver(),
  ],
  // ...
)
```

After a route change, every event carries `$url` (the current route) and `$referrer` (the previous route) as auto-properties — matching the web SDK — so route context is not limited to navigation events. Route state updates whenever the observer reports a change, even if `autoPageViews` is disabled.

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

## Tracking Consent

Tracking consent gates event capture: `Pug.track(...)`, the typed
`Pug.track.*` methods, `Pug.identify(...)`, and automatic
lifecycle/page-view events are dropped while consent is denied,
and resume once it is granted. Automatic campaign/deep-link capture is *not*
gated — while denied it still records attribution locally, but transmits
nothing until consent is granted.

Consent is **granted** by default. To start denied (for example, until the user
accepts a consent prompt) and persist their choice across launches:

```dart
await Pug.init(
  'project-id',
  const PugOptions(
    apiKey: 'pug_api_key',
    trackingConsent: TrackingConsentConfig(
      defaultConsent: TrackingConsent.denied,
      persist: true,
    ),
  ),
);
```

Flip consent at runtime:

```dart
Pug.optInTracking(); // grant — events flow
Pug.optOutTracking(); // deny — events are dropped

Pug.isTrackingEnabled(); // → bool (consent only; independent of dryRun)
Pug.getTrackingConsent(); // → TrackingConsent.granted | TrackingConsent.denied
```

With `persist: true`, opt in/out is written to `__pug_<projectId>_consent__` and
restored on the next `Pug.init(...)`. With `persist: false` (the default), the
choice lasts only for the current process and resets to `defaultConsent` on
restart. Consent is independent of `dryRun`, which suppresses delivery without
changing consent. Consent activity (denied drops and persistence failures) is
logged only through the configured `PugLogger`; the default `NoopPugLogger` is
silent.

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
}

await PugPush.subscribe(
  CustomPushProvider(),
  options: const PushSubscribeOptions(
    properties: {'channel': 'stable'},
  ),
);
```

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

## License

Licensed under the MIT License. See [LICENSE](LICENSE).
