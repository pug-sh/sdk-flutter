import 'package:flutter/material.dart';
import 'package:pug_flutter/pug_flutter.dart';

/// A single [PugRouteObserver] registered on the app's [Navigator]. Route
/// changes it reports let the SDK attach `$url`/`$referrer` to every event and
/// emit automatic `screen_view` events on iOS/Android.
final PugRouteObserver pugRouteObserver = PugRouteObserver();

Future<void> main() async {
  // Required before awaiting plugin work (SharedPreferences, device info, ...).
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the SDK once, before the app starts capturing events. Replace
  // the project id and API key with your own values from the Pug dashboard.
  await Pug.init('your-project-id', const PugOptions(apiKey: 'your-api-key'));

  runApp(const PugExampleApp());
}

class PugExampleApp extends StatelessWidget {
  const PugExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pug Flutter Example',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      // Registering the observer enables automatic navigation capture.
      navigatorObservers: <NavigatorObserver>[pugRouteObserver],
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pug Flutter Example')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: <Widget>[
            // Untyped custom event. For well-known events prefer the typed
            // methods, e.g. Pug.track.signedUp(...).
            ElevatedButton(
              onPressed:
                  () => Pug.track(
                    'demo_button_clicked',
                    props: <String, Object?>{'source': 'home'},
                  ),
              child: const Text('Track a custom event'),
            ),
            ElevatedButton(
              onPressed:
                  () => Pug.identify(
                    'user-123',
                    traits: <String, Object?>{'plan': 'pro'},
                  ),
              child: const Text('Identify the user'),
            ),
            ElevatedButton(
              onPressed: () => _openDetails(context),
              child: const Text('Open details (auto screen_view)'),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        // A named route lets the SDK report a meaningful screen name.
        settings: const RouteSettings(name: 'details'),
        builder: (_) => const DetailsScreen(),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Center(
        child: ElevatedButton(
          // Force any queued events to be delivered immediately.
          onPressed: () => Pug.flush(),
          child: const Text('Flush queued events'),
        ),
      ),
    );
  }
}
