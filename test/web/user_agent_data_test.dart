// Runs only in a browser: `flutter test --platform chrome test/web`.
@TestOn('browser')
library;

import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter/pug_flutter.dart';
import 'package:pug_flutter/src/user_agent_data_web.dart';

/// Read straight from the browser, independently of the code under test.
@JS('navigator.userAgentData.platform')
external String? get _browserPlatform;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('reads the OS and its version from user-agent client hints', () async {
    final data = _fakeUserAgentData(
      highEntropy: (hints) async {
        // As in the real API, a high-entropy value comes back only if asked for.
        final values = {
          if (hints.contains('platformVersion')) 'platformVersion': '15.1.0',
        };
        return values.jsify()!;
      },
    );

    expect(await userAgentDataPropertiesFrom(data), {
      r'$os': 'macOS',
      r'$osVersion': '15.1.0',
    });
  });

  test('reports nothing where the browser has no client hints', () async {
    expect(await userAgentDataPropertiesFrom(null), isEmpty);
  });

  test('keeps the OS when the high-entropy request fails', () async {
    final data = _fakeUserAgentData(
      highEntropy: (_) => Future.error(StateError('NotAllowedError')),
    );

    expect(await userAgentDataPropertiesFrom(data), {r'$os': 'macOS'});
  });

  test('keeps the OS when the high-entropy request never settles', () async {
    final data = _fakeUserAgentData(
      highEntropy: (_) => Completer<JSAny>().future,
    );

    expect(
      await userAgentDataPropertiesFrom(
        data,
        timeout: const Duration(milliseconds: 50),
      ),
      {r'$os': 'macOS'},
    );
  });

  test('create() attaches the browser OS to every event', () async {
    final browserPlatform = _browserPlatform;
    expect(browserPlatform, isNotNull, reason: 'needs a Chromium browser');

    // Only the browser's hints are under test. The plugin-backed sources are
    // stubbed: a browser test registers no plugins, and an unanswered
    // platform-channel call on web never completes.
    final provider = await SystemPugAutoPropertyProvider.create(
      packageInfo: () => Future.error(UnsupportedError('not under test')),
      localTimezone: () async => 'UTC',
      connectivity: _OfflineConnectivity(),
    );

    expect(provider.properties()[r'$os'], browserPlatform);
  });
}

/// A stand-in for `navigator.userAgentData` whose `getHighEntropyValues`
/// answers the requested hints through [highEntropy].
NavigatorUAData _fakeUserAgentData({
  required Future<JSAny> Function(List<String> hints) highEntropy,
}) {
  final object = {'platform': 'macOS'}.jsify()! as JSObject;
  object.setProperty(
    'getHighEntropyValues'.toJS,
    ((JSArray<JSString> hints) =>
            highEntropy([for (final hint in hints.toDart) hint.toDart]).toJS)
        .toJS,
  );
  return object as NavigatorUAData;
}

class _OfflineConnectivity implements Connectivity {
  @override
  Future<List<ConnectivityResult>> checkConnectivity() async => const [
    ConnectivityResult.none,
  ];

  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      const Stream.empty();
}
