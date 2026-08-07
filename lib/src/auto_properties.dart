import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'contracts.dart';

abstract interface class PugAutoPropertyProvider {
  Map<String, Object?> properties();
}

class PugStaticAutoPropertyProvider implements PugAutoPropertyProvider {
  const PugStaticAutoPropertyProvider(this._properties);

  final Map<String, Object?> _properties;

  @override
  Map<String, Object?> properties() => Map<String, Object?>.of(_properties);
}

/// `device_info_plus` marketing-name lookup misses. Non-empty, so an emptiness
/// check alone would ship them as `$deviceModel`. From 13.1.0; recheck on bump.
const _unknownAppleModels = {'Unknown device', 'Unknown Model'};

/// `type.television` is the deprecated predecessor of `leanback`, still present
/// on older Android TVs.
const _televisionFeatures = {
  'android.software.leanback',
  'android.hardware.type.television',
};

class SystemPugAutoPropertyProvider implements PugAutoPropertyProvider {
  SystemPugAutoPropertyProvider({
    Map<String, Object?> staticProperties = const {},
  }) : _staticProperties = Map<String, Object?>.unmodifiable(staticProperties);

  static Future<SystemPugAutoPropertyProvider> create({
    DeviceInfoPlugin? deviceInfo,
    Connectivity? connectivity,
    Future<PackageInfo> Function()? packageInfo,
    Future<String> Function()? localTimezone,
    PugLogger? logger,
  }) async {
    final properties = <String, Object?>{};

    try {
      final info = await (packageInfo ?? PackageInfo.fromPlatform)();
      properties[r'$appName'] = info.appName;
      properties[r'$appPackage'] = info.packageName;
      properties[r'$appVersion'] = info.version;
      properties[r'$appBuild'] = info.buildNumber;
    } catch (error) {
      logger?.warn(
        'Pug could not read package info for auto properties: $error',
      );
    }

    try {
      final timezone = await (localTimezone ?? _systemTimezone)();
      if (timezone.isNotEmpty) {
        properties[r'$timezone'] = timezone;
      }
    } catch (error) {
      logger?.warn(
        'Pug could not read the IANA timezone for auto properties: $error',
      );
    }

    try {
      properties.addAll(
        await deviceProperties(
          deviceInfo ?? DeviceInfoPlugin(),
          isWeb: kIsWeb,
          operatingSystem: kIsWeb ? '' : Platform.operatingSystem,
        ),
      );
    } catch (error) {
      logger?.warn(
        'Pug could not read device info for auto properties: $error',
      );
    }

    try {
      final results =
          await (connectivity ?? Connectivity()).checkConnectivity();
      properties[r'$networkType'] = _networkType(results);
    } catch (error) {
      logger?.warn(
        'Pug could not read connectivity info for auto properties: $error',
      );
    }

    return SystemPugAutoPropertyProvider(staticProperties: properties);
  }

  final Map<String, Object?> _staticProperties;

  @override
  Map<String, Object?> properties() {
    final type = deviceType(
      isWeb: kIsWeb,
      operatingSystem: Platform.operatingSystem,
    );
    return {
      r'$platform': platformName(
        isWeb: kIsWeb,
        operatingSystem: Platform.operatingSystem,
      ),
      r'$os': Platform.operatingSystem,
      // Fallback for desktop/web/failure; overridden below by the preloaded
      // device-info value ($osVersion in _staticProperties) when available.
      r'$osVersion': Platform.operatingSystemVersion,
      r'$locale': PlatformDispatcher.instance.locale.toLanguageTag(),
      // Fallback abbreviation (e.g. "CEST", locale-dependent); overridden by
      // the preloaded IANA identifier ($timezone in _staticProperties) when
      // flutter_timezone resolved it.
      r'$timezone': DateTime.now().timeZoneName,
      // androidProperties overrides this with `tv` via _staticProperties below.
      if (type != null) r'$deviceType': type,
      ..._screenProperties(),
      ..._staticProperties,
    };
  }

  /// The cross-SDK `$platform` value, which the backend promotes into a column
  /// verbatim — so it has to match what the rest of the family sends.
  ///
  /// Deliberately not [defaultTargetPlatform]: that keeps the enum's casing,
  /// reports the browser's host OS on web, and throws outside its six members.
  @visibleForTesting
  static String platformName({
    required bool isWeb,
    required String operatingSystem,
  }) {
    if (isWeb) {
      return 'web';
    }
    return operatingSystem.toLowerCase();
  }

  /// `tv` never comes from here — Android TV reports `android`, so only
  /// [androidProperties] can identify it. Null on web and unknown targets, so
  /// `$deviceType` is omitted rather than guessed into the wrong bucket.
  @visibleForTesting
  static String? deviceType({
    required bool isWeb,
    required String operatingSystem,
  }) {
    if (isWeb) {
      return null;
    }
    return switch (operatingSystem.toLowerCase()) {
      'ios' || 'android' => 'mobile',
      'macos' || 'windows' || 'linux' => 'desktop',
      _ => null,
    };
  }

  /// Takes [operatingSystem] rather than reading `Platform.isX` so the routing
  /// is testable without platform channels.
  @visibleForTesting
  static Future<Map<String, Object?>> deviceProperties(
    DeviceInfoPlugin plugin, {
    required bool isWeb,
    required String operatingSystem,
  }) async {
    if (isWeb) {
      return const {};
    }
    switch (operatingSystem) {
      case 'android':
        return androidProperties((await plugin.androidInfo).data);
      case 'ios':
        return appleProperties((await plugin.iosInfo).data);
      case 'macos':
        return macosProperties((await plugin.macOsInfo).data);
      case 'linux':
        final linux = await plugin.linuxInfo;
        return {
          r'$deviceManufacturer': _readString(linux, 'prettyName'),
          r'$deviceModel': _readString(linux, 'name'),
        };
      case 'windows':
        return windowsProperties((await plugin.windowsInfo).data);
      default:
        return const {};
    }
  }

  static Map<String, Object?> _screenProperties() {
    final views = PlatformDispatcher.instance.views;
    if (views.isEmpty) {
      return const {};
    }
    final view = views.first;
    final ratio = view.devicePixelRatio;
    if (ratio <= 0) {
      return const {};
    }
    return {
      r'$screenWidth': (view.physicalSize.width / ratio).round(),
      r'$screenHeight': (view.physicalSize.height / ratio).round(),
      r'$screenScale': ratio,
    };
  }

  /// Maps the raw Android device-info payload to auto-properties.
  ///
  /// Keyed on the plugin's `.data` map rather than the typed [AndroidDeviceInfo]
  /// so the mapping is unit-testable without constructing that heavyweight
  /// object. Deliberately omits `$deviceName`: user-assigned device names
  /// ("Praveen's Pixel") are PII.
  @visibleForTesting
  static Map<String, Object?> androidProperties(Map<String, dynamic> data) {
    final version = data['version'];
    final osVersion =
        version is Map ? (version['release']?.toString() ?? '') : '';
    final features = data['systemFeatures'];
    return {
      // Empty would clobber properties()' Platform.operatingSystemVersion.
      if (osVersion.isNotEmpty) r'$osVersion': osVersion,
      r'$deviceManufacturer': data['manufacturer']?.toString() ?? '',
      r'$deviceModel': data['model']?.toString() ?? '',
      if (features is List && features.any(_televisionFeatures.contains))
        r'$deviceType': 'tv',
    };
  }

  /// Omits the payload's `name`: user-assigned device names are PII.
  @visibleForTesting
  static Map<String, Object?> appleProperties(Map<String, dynamic> data) {
    final osVersion = data['systemVersion']?.toString() ?? '';
    return {
      if (osVersion.isNotEmpty) r'$osVersion': osVersion,
      r'$deviceManufacturer': 'Apple',
      r'$deviceModel': _appleModel(data),
    };
  }

  /// Sends no `$deviceManufacturer`: Windows exposes no manufacturer, and its
  /// host-identity fields (computerName, userName, registeredOwner) are all
  /// user-set PII.
  @visibleForTesting
  static Map<String, Object?> windowsProperties(Map<String, dynamic> data) {
    return {r'$deviceModel': data['productName']?.toString() ?? ''};
  }

  @visibleForTesting
  static Map<String, Object?> macosProperties(Map<String, dynamic> data) {
    return {
      r'$deviceManufacturer': 'Apple',
      r'$deviceModel': _appleModel(data),
    };
  }

  /// The marketing name when the plugin resolved one, else the raw identifier —
  /// "iPhone" from `UIDevice.model`, "MacBookPro18,3" from sysctl.
  static String _appleModel(Map<String, dynamic> data) {
    final modelName = data['modelName']?.toString() ?? '';
    if (modelName.isNotEmpty && !_unknownAppleModels.contains(modelName)) {
      return modelName;
    }
    return data['model']?.toString() ?? '';
  }

  static Future<String> _systemTimezone() async =>
      (await FlutterTimezone.getLocalTimezone()).identifier;

  static String _readString(BaseDeviceInfo info, String name) {
    return info.data[name]?.toString() ?? '';
  }

  static String _networkType(Object results) {
    final values =
        results is Iterable<ConnectivityResult>
            ? results
            : results is ConnectivityResult
            ? <ConnectivityResult>[results]
            : const <ConnectivityResult>[];
    final names = values.map((value) => value.name).toSet();
    if (names.contains('none')) {
      return 'none';
    }
    if (names.contains('wifi')) {
      return 'wifi';
    }
    if (names.contains('mobile')) {
      return 'mobile';
    }
    if (names.contains('ethernet')) {
      return 'ethernet';
    }
    if (names.contains('vpn')) {
      return 'vpn';
    }
    if (names.contains('bluetooth')) {
      return 'bluetooth';
    }
    if (names.contains('other')) {
      return 'other';
    }
    return 'unknown';
  }
}
