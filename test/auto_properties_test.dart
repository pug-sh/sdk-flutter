import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('auto property provider contributes mobile metadata', () {
    final client = testClient(
      autoPropertyProvider: const PugStaticAutoPropertyProvider({
        r'$appVersion': '1.2.3',
        r'$appBuild': '45',
        r'$deviceManufacturer': 'Acme',
        r'$deviceModel': 'Phone',
        r'$screenWidth': 390,
        r'$screenHeight': 844,
        r'$networkType': 'wifi',
      }),
    );
    client.track('signup');

    final autoProperties = client.queue.peekUnlocked().single.autoProperties;
    expect(autoProperties[r'$projectId']?.value, 'project');
    expect(autoProperties[r'$appVersion']?.value, '1.2.3');
    expect(autoProperties[r'$appBuild']?.value, '45');
    expect(autoProperties[r'$deviceManufacturer']?.value, 'Acme');
    expect(autoProperties[r'$deviceModel']?.value, 'Phone');
    expect(autoProperties[r'$screenWidth']?.value, 390);
    expect(autoProperties[r'$screenHeight']?.value, 844);
    expect(autoProperties[r'$networkType']?.value, 'wifi');
  });

  test(
    'system osVersion prefers preloaded device info over Platform string',
    () {
      final provider = SystemPugAutoPropertyProvider(
        staticProperties: const {r'$osVersion': '17.2'},
      );
      expect(provider.properties()[r'$osVersion'], '17.2');
    },
  );

  test('system osVersion falls back to Platform when not preloaded', () {
    final provider = SystemPugAutoPropertyProvider();
    final osVersion = provider.properties()[r'$osVersion'];
    expect(osVersion, isA<String>());
    expect(osVersion as String, isNotEmpty);
  });
}
