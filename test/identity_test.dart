import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'identify before init warns, while invalid input and transport failures still throw',
    () async {
      await expectLater(Pug.identify('user-before-init'), completes);

      final failedTransport =
          FakeTransport()
            ..identifyError = const PugTransportException('identify failed');
      final client = testClient(transport: failedTransport);

      await expectLater(client.identify(''), throwsA(isA<ArgumentError>()));

      await expectLater(
        client.identify('user-1'),
        throwsA(isA<PugTransportException>()),
      );
    },
  );

  test('device id is stable across session rotation and changes on reset', () {
    final clock = FakeClock(1000);
    final ids = SequenceIds();
    final storage = MemoryPugStorage();
    final client = testClient(clock: clock, ids: ids, storage: storage);

    client.track('first');
    final first = client.queue.peekUnlocked().last;
    final firstDevice = readDeviceId(storage);
    expect(readSession(storage)['deviceId'], firstDevice);

    clock.value = const Duration(minutes: 31).inMilliseconds + 1000;
    client.track('second');
    final second = client.queue.peekUnlocked().last;
    expect(second.sessionId, isNot(first.sessionId));
    expect(readDeviceId(storage), firstDevice);
    expect(readSession(storage)['deviceId'], firstDevice);

    client.rotate();
    final afterRotate = readSession(storage);
    expect(afterRotate['deviceId'], firstDevice);
    expect(readDeviceId(storage), firstDevice);

    client.identify('user-1');
    client.reset();
    final afterReset = readSession(storage);
    final resetDevice = readDeviceId(storage);
    expect(resetDevice, isNot(firstDevice));
    expect(afterReset['deviceId'], resetDevice);
    expect(storage.getString('__pug_project_external_id__'), isNull);
  });

  test(
    'identify first call includes anonymous id and device id and later calls omit both',
    () async {
      final transport = FakeTransport();
      final client = testClient(transport: transport);

      await client.identify('user-1', traits: {'plan': 'pro'});
      await client.identify('user-2');

      expect(transport.identifies.first.anonymousId, startsWith('anon-'));
      expect(transport.identifies.first.deviceId, isNotNull);
      expect(transport.identifies.first.deviceId, isNotEmpty);
      expect(transport.identifies.first.traits['plan']?.value, 'pro');
      expect(transport.identifies.last.anonymousId, isNull);
      expect(transport.identifies.last.deviceId, isNull);
    },
  );
}
