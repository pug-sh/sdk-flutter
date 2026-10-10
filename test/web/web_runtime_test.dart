// Runs only in a browser: `flutter test --platform chrome test/web`. The VM run
// skips it, and these bugs cannot be reproduced there anyway. `kIsWeb` is a
// compile-time constant, and the VM's 64-bit ints shift correctly.
@TestOn('browser')
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter/pug_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('default auto-properties report web without reading dart:io', () {
    final properties = SystemPugAutoPropertyProvider().properties();

    expect(properties[r'$platform'], 'web');
    expect(properties, isNot(contains(r'$os')));
    expect(properties, isNot(contains(r'$osVersion')));
  });

  test('a client on its default providers delivers events on web', () async {
    final transport = _RecordingTransport();
    final client = PugClient(
      projectId: 'project',
      options: PugOptions(
        apiKey: 'key',
        transport: transport,
        storage: MemoryPugStorage(),
        autoTrack: false,
        autoInstallEvents: false,
      ),
    );
    await client.start();
    client.track('one');
    await client.flush();
    await client.destroy();

    expect(transport.kinds, ['one']);
  });

  test('UUIDv7 ids encode the current time on web', () {
    final before = DateTime.now().millisecondsSinceEpoch;
    final id = UuidV7Generator().nextId();
    final after = DateTime.now().millisecondsSinceEpoch;

    final encoded = int.parse(
      id.replaceAll('-', '').substring(0, 12),
      radix: 16,
    );
    expect(encoded, inInclusiveRange(before, after));
  });
}

class _RecordingTransport implements PugTransport {
  final List<String> kinds = <String>[];

  @override
  Future<void> send(Event event) async => kinds.add(event.kind);

  @override
  Future<void> sendBatch(List<Event> events) async =>
      kinds.addAll(events.map((event) => event.kind));

  @override
  Future<void> identify(IdentifyRequest request) async {}
}
