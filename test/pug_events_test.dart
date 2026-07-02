import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter/pug_flutter.dart';

import 'test_support.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('track never throws and maps properties', () {
    final transport = FakeTransport();
    final client = testClient(transport: transport);

    expect(
      () => client.track('purchase', props: {'bad': double.nan}),
      returnsNormally,
    );
    client.track(
      'purchase',
      props: {
        'string': 'hello',
        'bool': true,
        'int': 7,
        'double': 1.5,
        'date': DateTime.fromMillisecondsSinceEpoch(10, isUtc: true),
        'json': {'a': 1},
        'none': null,
      },
    );

    final event = client.queue.peekUnlocked().last;
    expect(event.customProperties['string']?.kind, 'stringValue');
    expect(event.customProperties['bool']?.kind, 'boolValue');
    expect(event.customProperties['int']?.kind, 'intValue');
    expect(event.customProperties['double']?.kind, 'doubleValue');
    expect(event.customProperties['date']?.kind, 'timestampValue');
    expect(event.customProperties['json']?.kind, 'stringValue');
    expect(event.customProperties.containsKey('none'), isFalse);
  });

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

  test('campaign properties are captured from initial app link', () async {
    final client = testClient(
      linkProvider: FakeLinkProvider(
        initial: Uri.parse(
          'https://example.com/welcome?utm_source=google&utm_medium=cpc'
          '&utm_campaign=spring&gclid=click-1',
        ),
      ),
      autoCaptureCampaigns: true,
    );
    await Future<void>.delayed(Duration.zero);

    client.track('signup');

    final autoProperties = client.queue.peekUnlocked().single.autoProperties;
    expect(autoProperties[r'$utmSource']?.value, 'google');
    expect(autoProperties[r'$utmMedium']?.value, 'cpc');
    expect(autoProperties[r'$utmCampaign']?.value, 'spring');
    expect(autoProperties[r'$gclid']?.value, 'click-1');
  });

  test('campaign properties update from later app links', () async {
    final linkProvider = FakeLinkProvider();
    final client = testClient(
      linkProvider: linkProvider,
      autoCaptureCampaigns: true,
    );
    await Future<void>.delayed(Duration.zero);

    linkProvider.add(
      Uri.parse('pug://open?utm_source=newsletter&utm_content=hero'),
    );
    await Future<void>.delayed(Duration.zero);
    client.track('open');

    final autoProperties = client.queue.peekUnlocked().single.autoProperties;
    expect(autoProperties[r'$utmSource']?.value, 'newsletter');
    expect(autoProperties[r'$utmContent']?.value, 'hero');
  });

  test('well-known events accept any props without validation', () {
    final logger = CapturingLogger();
    final client = testClient(logger: logger);

    client.track(
      'purchase',
      props: {
        'productId': 'sku-1',
        'amount': 3,
        'currency': 'USD',
        'extra': true,
      },
    );
    final purchase = client.queue.peekUnlocked().single;
    expect(purchase.customProperties['productId']?.kind, 'stringValue');
    expect(purchase.customProperties['amount']?.kind, 'intValue');
    expect(purchase.customProperties['amount']?.value, 3);
    expect(purchase.customProperties['extra']?.kind, 'boolValue');

    client.track('purchase', props: {'amount': '3.00'});
    expect(client.queue.peekUnlocked().length, 2);

    client.track('scroll', props: {'percent': 0, 'scrollY': 0});
    final scroll = client.queue.peekUnlocked().last;
    expect(scroll.customProperties['percent']?.value, 0);
    expect(scroll.customProperties['scrollY']?.value, 0);
  });

  test('public well-known event names match runtime schemas', () {
    expect(PugEventNames.all.length, wellKnownEventSchemas.length);
    expect(PugEventNames.all.toSet(), wellKnownEventSchemas.keys.toSet());
    expect(PugEventNames.isWellKnown(PugEventNames.purchase), isTrue);
    expect(PugEventNames.isWellKnown('custom_event'), isFalse);
  });

  test('string properties are truncated to 1024 UTF-8 bytes', () {
    final mapped = const PropertyMapper().mapProperties({'long': 'a' * 2000});
    final value = mapped['long']!.value as String;
    expect(value.length, 1024);
  });
}
