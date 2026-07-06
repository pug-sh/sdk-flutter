# pug_flutter example

A minimal Flutter app showing how to wire up the [`pug_flutter`](https://pub.dev/packages/pug_flutter) SDK.

It demonstrates:

- Initializing the SDK in `main()` with `Pug.init(...)`.
- Registering a `PugRouteObserver` on the app's `Navigator` so navigation is
  captured automatically (`$url`/`$referrer` on every event, plus `screen_view`
  events on iOS/Android).
- Tracking a custom event with `Pug.track(...)`.
- Identifying a user with `Pug.identify(...)`.
- Forcing delivery with `Pug.flush()`.

## Run it

Replace the placeholder `projectId` and `apiKey` in `lib/main.dart` with your
own values from the Pug dashboard, then:

```bash
flutter run
```
