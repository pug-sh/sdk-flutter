import 'package:connectrpc/connect.dart' as connect;
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';
import 'package:pug_sdk/src/connect_transport.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'transient transport errors rollback and permanent errors drop',
    () async {
      final transient =
          FakeTransport()
            ..batchError = const PugTransportException(
              'retry',
              permanent: false,
            );
      final transientClient = testClient(transport: transient);
      transientClient.track('one');
      await transientClient.flush();
      expect(transientClient.queue.peekUnlocked().single.kind, 'one');

      final permanent =
          FakeTransport()
            ..batchError = const PugTransportException('drop', permanent: true);
      final permanentClient = testClient(transport: permanent);
      permanentClient.track('one');
      await permanentClient.flush();
      expect(permanentClient.queue.peekUnlocked(), isEmpty);
    },
  );

  test(
    'unexpected transport errors drop queued and immediate events without retry',
    () async {
      final queuedTransport =
          FakeTransport()..batchFailure = StateError('poison batch');
      final queuedClient = testClient(transport: queuedTransport);
      queuedClient.track('one');
      await queuedClient.flush();
      expect(queuedClient.queue.peekUnlocked(), isEmpty);

      final immediateTransport =
          FakeTransport()..sendFailure = StateError('poison immediate');
      final immediateClient = testClient(transport: immediateTransport);
      immediateClient.track(
        'one',
        options: const TrackOptions(immediate: true),
      );
      await Future<void>.delayed(Duration.zero);
      expect(immediateClient.queue.peekUnlocked(), isEmpty);
    },
  );

  test(
    'connect transport injects api key and maps permanent connect errors',
    () async {
      final baseTransport =
          FakeConnectTransport()
            ..unaryError = connect.ConnectException(
              connect.Code.invalidArgument,
              'bad request payload',
            );
      final transport = ConnectPugTransport(
        endpoint: 'http://example.com',
        apiKey: 'key',
        transport: baseTransport,
      );

      await expectLater(
        transport.send(fakeEvent('one')),
        throwsA(
          isA<PugTransportException>()
              .having((error) => error.code, 'code', 'invalid_argument')
              .having((error) => error.isPermanent, 'isPermanent', isTrue),
        ),
      );
      expect(baseTransport.lastHeaders?['x-api-key'], 'key');
      expect(
        baseTransport.lastProcedure,
        '/sdk.events.v1.EventsService/BatchCreate',
      );
    },
  );

  test('connect transport maps transient connect errors', () async {
    await expectLater(
      Future<void>.sync(
        () =>
            throw mapConnectError(
              connect.ConnectException(connect.Code.unavailable, 'retry later'),
              StackTrace.empty,
            ),
      ),
      throwsA(
        isA<PugTransportException>()
            .having((error) => error.code, 'code', 'unavailable')
            .having((error) => error.isPermanent, 'isPermanent', isFalse),
      ),
    );
  });
}
