import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';

import 'test_doubles.dart';

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
