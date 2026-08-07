import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
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

  test('native platform is the operating system, lowercased', () {
    const expected = {
      'android': 'android',
      'fuchsia': 'fuchsia',
      'ios': 'ios',
      'linux': 'linux',
      'macos': 'macos',
      'windows': 'windows',
      'iOS': 'ios',
      'macOS': 'macos',
    };
    for (final MapEntry(key: os, value: name) in expected.entries) {
      expect(
        SystemPugAutoPropertyProvider.platformName(
          isWeb: false,
          operatingSystem: os,
        ),
        name,
      );
    }
  });

  test('web wins over the reported operating system', () {
    for (final os in const ['macos', 'windows', 'linux', 'android', 'ios']) {
      expect(
        SystemPugAutoPropertyProvider.platformName(
          isWeb: true,
          operatingSystem: os,
        ),
        'web',
      );
    }
  });

  test('platform agrees with os and is not a function of the theming enum', () {
    addTearDown(() => debugDefaultTargetPlatformOverride = null);
    final provider = SystemPugAutoPropertyProvider();

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
    final props = provider.properties();
    expect(props[r'$platform'], Platform.operatingSystem);
    expect(props[r'$platform'], props[r'$os']);
  });

  test('each os reaches its own device-info channel', () async {
    expect(await _channelFor('ios'), 'ios');
    expect(await _channelFor('android'), 'android');
    expect(await _channelFor('macos'), 'macos');
    expect(await _channelFor('fuchsia'), isNull);
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

  test('apple auto-properties prefer the marketing name', () {
    final props = SystemPugAutoPropertyProvider.appleProperties(const {
      'systemVersion': '18.5',
      'modelName': 'iPhone 15 Pro',
      'model': 'iPhone',
      'name': "Praveen's iPhone",
    });

    expect(props[r'$osVersion'], '18.5');
    expect(props[r'$deviceManufacturer'], 'Apple');
    expect(props[r'$deviceModel'], 'iPhone 15 Pro');
    expect(props.containsKey(r'$deviceName'), isFalse);
  });

  test('an unresolved apple model falls back to the coarse identifier', () {
    for (final placeholder in const ['Unknown device', 'Unknown Model', '']) {
      final props = SystemPugAutoPropertyProvider.appleProperties({
        'systemVersion': '18.5',
        'modelName': placeholder,
        'model': 'iPhone',
      });

      expect(props[r'$deviceModel'], 'iPhone');
      expect(props[r'$osVersion'], '18.5');
    }
  });

  test('device type is the form factor behind the platform', () {
    const expected = {
      'ios': 'mobile',
      'android': 'mobile',
      'macos': 'desktop',
      'windows': 'desktop',
      'linux': 'desktop',
      'fuchsia': null,
    };
    for (final MapEntry(key: os, value: type) in expected.entries) {
      expect(
        SystemPugAutoPropertyProvider.deviceType(
          isWeb: false,
          operatingSystem: os,
        ),
        type,
      );
    }
    expect(
      SystemPugAutoPropertyProvider.deviceType(
        isWeb: true,
        operatingSystem: 'linux',
      ),
      isNull,
    );
  });

  test('android tv is a tv, and a plain android device is not', () {
    for (final feature in const [
      'android.software.leanback',
      'android.hardware.type.television',
    ]) {
      final props = SystemPugAutoPropertyProvider.androidProperties({
        'model': 'Chromecast',
        'systemFeatures': ['android.hardware.wifi', feature],
      });
      expect(props[r'$deviceType'], 'tv');
    }

    final phone = SystemPugAutoPropertyProvider.androidProperties(const {
      'model': 'Pixel 8',
      'systemFeatures': ['android.hardware.wifi', 'android.hardware.camera'],
    });
    // Left absent so properties()' `mobile` default survives the spread.
    expect(phone.containsKey(r'$deviceType'), isFalse);
  });

  test('a preloaded device type overrides the one derived from the os', () {
    final provider = SystemPugAutoPropertyProvider(
      staticProperties: const {r'$deviceType': 'tv'},
    );

    expect(provider.properties()[r'$deviceType'], 'tv');
  });

  test('an unresolved macos model falls back to the identifier', () {
    final props = SystemPugAutoPropertyProvider.macosProperties(const {
      'modelName': 'Unknown Model',
      'model': 'MacBookPro18,3',
    });

    expect(props[r'$deviceModel'], 'MacBookPro18,3');
    expect(props[r'$deviceManufacturer'], 'Apple');
  });

  test('a missing os version is omitted, not sent empty', () {
    expect(
      SystemPugAutoPropertyProvider.appleProperties(const {'model': 'iPhone'}),
      isNot(contains(r'$osVersion')),
    );
    expect(
      SystemPugAutoPropertyProvider.androidProperties(const {'model': 'Pixel'}),
      isNot(contains(r'$osVersion')),
    );
  });
}

/// Throws rather than returning a payload: the plugin's info types require ~14
/// typed fields, none of which this assertion needs.
Future<String?> _channelFor(String operatingSystem) async {
  try {
    await SystemPugAutoPropertyProvider.deviceProperties(
      _ChannelSpy(),
      isWeb: false,
      operatingSystem: operatingSystem,
    );
    return null;
  } on _Reached catch (reached) {
    return reached.channel;
  }
}

class _Reached implements Exception {
  const _Reached(this.channel);
  final String channel;
}

class _ChannelSpy extends DeviceInfoPlugin {
  @override
  Future<IosDeviceInfo> get iosInfo async => throw const _Reached('ios');

  @override
  Future<AndroidDeviceInfo> get androidInfo async =>
      throw const _Reached('android');

  @override
  Future<MacOsDeviceInfo> get macOsInfo async => throw const _Reached('macos');
}
