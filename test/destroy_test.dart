import 'package:flutter_test/flutter_test.dart';
import 'package:pug_sdk/pug_sdk.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('destroy starts a best-effort final flush', () async {
    final transport = FakeTransport();
    final client = testClient(transport: transport);

    client.track('one');
    client.destroy();
    await Future<void>.delayed(Duration.zero);

    expect(transport.batches.single.map((event) => event.kind), ['one']);
    expect(client.queue.peekUnlocked(), isEmpty);
  });

  test('destroy removes all storage keys', () async {
    final transport = FakeTransport();
    final storage = MemoryPugStorage();
    final client = testClient(transport: transport, storage: storage);

    // Initialize storage with some data
    client.track('test_event');
    await client.identify('test-user');
    await Future<void>.delayed(Duration.zero);

    // Verify storage keys exist before destroy
    expect(storage.getString('__pug_project_session__'), isNotNull);
    expect(storage.getString('__pug_project_profile__'), isNotNull);
    expect(storage.getString('__pug_project_device_id__'), isNotNull);
    expect(storage.getString('__pug_project_external_id__'), isNotNull);
    expect(storage.getString('__pug_project_queue__'), isNotNull);

    // Destroy the client
    client.destroy();

    // Verify all storage keys are removed
    expect(storage.getString('__pug_project_session__'), isNull);
    expect(storage.getString('__pug_project_profile__'), isNull);
    expect(storage.getString('__pug_project_device_id__'), isNull);
    expect(storage.getString('__pug_project_external_id__'), isNull);
    expect(storage.getString('__pug_project_queue__'), isNull);
  });
}
