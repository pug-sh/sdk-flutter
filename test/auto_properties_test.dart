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
      // $deviceName is deliberately never sent (user-assigned names are PII).
      expect(props.containsKey(r'$deviceName'), isFalse);
    },
  );
}
