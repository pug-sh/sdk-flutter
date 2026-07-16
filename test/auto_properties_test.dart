import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pug_flutter/pug_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('create preloads the IANA timezone identifier', () async {
    final provider = await SystemPugAutoPropertyProvider.create(
      packageInfo:
          () async => PackageInfo(
            appName: 'app',
            packageName: 'dev.pugs.app',
            version: '1.2.3',
            buildNumber: '42',
          ),
      localTimezone: () async => 'Asia/Kolkata',
    );

    final props = provider.properties();
    expect(props[r'$timezone'], 'Asia/Kolkata');
    expect(props[r'$appVersion'], '1.2.3');
  });

  test(
    'timezone preload failure falls back to the platform abbreviation',
    () async {
      final provider = await SystemPugAutoPropertyProvider.create(
        packageInfo: () async => throw StateError('no package info'),
        localTimezone: () async => throw StateError('no timezone'),
      );

      final props = provider.properties();
      expect(props[r'$timezone'], DateTime.now().timeZoneName);
    },
  );

  test('every native target maps to the cross-SDK lowercase platform', () {
    const expected = <TargetPlatform, String>{
      TargetPlatform.android: 'android',
      TargetPlatform.fuchsia: 'fuchsia',
      TargetPlatform.iOS: 'ios',
      TargetPlatform.linux: 'linux',
      TargetPlatform.macOS: 'macos',
      TargetPlatform.windows: 'windows',
    };
    // A TargetPlatform added upstream lands here rather than reaching the
    // promoted `platform` column unmapped.
    expect(expected.keys, containsAll(TargetPlatform.values));

    for (final MapEntry(key: platform, value: name) in expected.entries) {
      expect(
        SystemPugAutoPropertyProvider.platformName(
          isWeb: false,
          platform: platform,
        ),
        name,
      );
    }
  });

  test('web reports web whatever host OS the browser resolves to', () {
    // defaultTargetPlatform reports the browser's host OS on web, so every
    // value is reachable there; `web` has to win to match @pug-sh/browser and
    // to keep Flutter web out of the native ios/android buckets.
    for (final platform in TargetPlatform.values) {
      expect(
        SystemPugAutoPropertyProvider.platformName(
          isWeb: true,
          platform: platform,
        ),
        'web',
      );
    }
  });

  test('properties reports the lowercase platform, not the enum name', () {
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    final provider = SystemPugAutoPropertyProvider();

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    expect(provider.properties()[r'$platform'], 'ios');

    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;
    expect(provider.properties()[r'$platform'], 'macos');
  });

  test(
    'android auto-properties expose device fields but never the PII name',
    () {
      // Drives the Android mapping directly: the host runs on Linux, so the
      // provider's device branch never populates on this platform. The raw
      // payload includes a `name`, proving the mapping drops it rather than the
      // assertion passing vacuously.
      final props = SystemPugAutoPropertyProvider.androidProperties(const {
        'version': {'release': '14'},
        'manufacturer': 'Google',
        'model': 'Pixel 8',
        'name': "Praveen's Pixel",
      });

      expect(props[r'$osVersion'], '14');
      expect(props[r'$deviceManufacturer'], 'Google');
      expect(props[r'$deviceModel'], 'Pixel 8');
      // $deviceName is deliberately never sent (user-assigned names are PII).
      expect(props.containsKey(r'$deviceName'), isFalse);
    },
  );
}
