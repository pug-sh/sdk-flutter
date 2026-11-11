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

  test('an event with an invalid kind is dropped and logged; the batch is '
      'sent', () async {
    final logger = CapturingLogger();
    final transport = FakeTransport();
    final client = testClient(transport: transport, logger: logger);

    client.track('signup');
    client.track('Order Completed');
    client.track('signup:started');
    client.track('purchase.v2-final_1');
    await client.flush();

    expect(transport.batches.single.map((event) => event.kind), [
      'signup',
      'purchase.v2-final_1',
    ]);
    expect(logger.warnings, [
      'Pug dropped event "Order Completed": a kind may only contain letters, '
          'digits, "_", "." and "-".',
      'Pug dropped event "signup:started": a kind may only contain letters, '
          'digits, "_", "." and "-".',
    ]);
  });

  test('a blank kind is dropped and logged', () {
    final logger = CapturingLogger();
    final client = testClient(logger: logger);

    client.track('');
    client.track('  ');

    expect(client.queue.peekUnlocked(), isEmpty);
    expect(logger.warnings, [
      'Pug dropped an event with a blank kind.',
      'Pug dropped an event with a blank kind.',
    ]);
  });

  test(r'a $-prefixed property is dropped and logged; its event is kept', () {
    final logger = CapturingLogger();
    final client = testClient(logger: logger);

    client.track(
      'purchase',
      props: {r'$plan': 'pro', 'plan': 'pro', r'$unset': null},
    );

    final event = client.queue.peekUnlocked().single;
    expect(event.customProperties.keys, ['plan']);
    expect(logger.warnings, [
      r'Pug dropped property "$plan" on event "purchase": keys starting with '
          r'"$" are reserved for auto-properties.',
    ]);
  });

  test(r'an auto-property without the $ prefix is dropped and logged', () {
    final logger = CapturingLogger();
    final client = testClient(
      logger: logger,
      autoPropertyProvider: const PugStaticAutoPropertyProvider({
        r'$appVersion': '1.2.3',
        'appVersion': '1.2.3',
      }),
    );

    client.track('signup');

    final auto = client.queue.peekUnlocked().single.autoProperties;
    expect(auto[r'$appVersion']?.value, '1.2.3');
    expect(auto.containsKey('appVersion'), isFalse);
    expect(logger.warnings, [
      r'Pug dropped auto-property "appVersion": auto-property keys must start '
          r'with "$".',
    ]);
  });

  test('durations are sent as seconds, rounded to the millisecond', () {
    final mapped = const PropertyMapper().mapProperties({
      'zero': Duration.zero,
      'whole': const Duration(hours: 1),
      'half': const Duration(seconds: 90, milliseconds: 500),
      'millis': const Duration(milliseconds: 1234),
      'leadingZeros': const Duration(milliseconds: 5),
      'roundsUp': const Duration(microseconds: 1500),
      'roundsDown': const Duration(microseconds: 1499),
      'negative': const Duration(milliseconds: -1500),
      'negativeToZero': const Duration(microseconds: -400),
    });

    expect(mapped.map((key, value) => MapEntry(key, value.toJson())), {
      'zero': {'stringValue': '0s'},
      'whole': {'stringValue': '3600s'},
      'half': {'stringValue': '90.5s'},
      'millis': {'stringValue': '1.234s'},
      'leadingZeros': {'stringValue': '0.005s'},
      'roundsUp': {'stringValue': '0.002s'},
      'roundsDown': {'stringValue': '0.001s'},
      'negative': {'stringValue': '-1.5s'},
      'negativeToZero': {'stringValue': '0s'},
    });
  });
}
