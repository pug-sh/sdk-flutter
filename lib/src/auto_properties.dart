import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
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

class SystemPugAutoPropertyProvider implements PugAutoPropertyProvider {
  SystemPugAutoPropertyProvider({
    Map<String, Object?> staticProperties = const {},
  }) : _staticProperties = Map<String, Object?>.unmodifiable(staticProperties);

  static Future<SystemPugAutoPropertyProvider> create({
    DeviceInfoPlugin? deviceInfo,
    Connectivity? connectivity,
    Future<PackageInfo> Function()? packageInfo,
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
      logger?.warn('Pug could not read package info for auto properties.');
    }

    try {
      properties.addAll(
        await _deviceProperties(deviceInfo ?? DeviceInfoPlugin()),
      );
    } catch (error) {
      logger?.warn('Pug could not read device info for auto properties.');
    }

    try {
      final results = await (connectivity ?? Connectivity())
          .checkConnectivity();
      properties[r'$networkType'] = _networkType(results);
    } catch (error) {
      logger?.warn('Pug could not read connectivity info for auto properties.');
    }

    return SystemPugAutoPropertyProvider(staticProperties: properties);
  }

  final Map<String, Object?> _staticProperties;

  @override
  Map<String, Object?> properties() {
    return {
      r'$platform': defaultTargetPlatform.name,
      r'$os': Platform.operatingSystem,
      r'$osVersion': Platform.operatingSystemVersion,
      r'$locale': PlatformDispatcher.instance.locale.toLanguageTag(),
      r'$timezone': DateTime.now().timeZoneName,
      ..._screenProperties(),
      ..._staticProperties,
    };
  }

  static Future<Map<String, Object?>> _deviceProperties(
    DeviceInfoPlugin plugin,
  ) async {
    if (kIsWeb) {
      return const {};
    }
    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      return {
        r'$deviceManufacturer': info.manufacturer,
        r'$deviceModel': info.model,
        r'$deviceName': info.name,
      };
    }
    if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      return {
        r'$deviceManufacturer': 'Apple',
        r'$deviceModel': info.modelName.isNotEmpty
            ? info.modelName
            : info.model,
      };
    }
    if (Platform.isMacOS) {
      final info = await plugin.macOsInfo;
      return {
        r'$deviceManufacturer': 'Apple',
        r'$deviceModel': info.modelName.isNotEmpty
            ? info.modelName
            : info.model,
      };
    }
    if (Platform.isLinux) {
      final info = await plugin.linuxInfo;
      return {
        r'$deviceManufacturer': info.prettyName,
        r'$deviceModel': info.name,
      };
    }
    if (Platform.isWindows) {
      final info = await plugin.windowsInfo;
      return {
        r'$deviceManufacturer': info.computerName,
        r'$deviceModel': info.productName,
      };
    }
    return const {};
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

  static String _networkType(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      return 'none';
    }
    if (results.contains(ConnectivityResult.wifi)) {
      return 'wifi';
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return 'mobile';
    }
    if (results.contains(ConnectivityResult.ethernet)) {
      return 'ethernet';
    }
    if (results.contains(ConnectivityResult.vpn)) {
      return 'vpn';
    }
    if (results.contains(ConnectivityResult.bluetooth)) {
      return 'bluetooth';
    }
    if (results.contains(ConnectivityResult.other)) {
      return 'other';
    }
    return 'unknown';
  }
}
