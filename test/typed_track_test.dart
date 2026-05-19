import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';

import 'test_doubles.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Pug.logger getter', () {
    test('returns a usable logger before init (no-op fallback)', () {
      final logger = Pug.shared.logger;
      // Should not be null and should not throw on common calls.
      logger.debug('test');
      logger.warn('test');
      expect(logger, isNotNull);
    });

    test('returns the configured logger after init', () async {
      final logger = CapturingLogger();
      await Pug.init(
        'project',
        PugOptions(
          apiKey: 'key',
          logger: logger,
          transport: FakeTransport(),
          storage: MemoryPugStorage(),
          autoTrack: false,
        ),
      );
      Pug.shared.logger.warn('hello');
      expect(
        logger.warnings.where((m) => m == 'hello'),
        isNotEmpty,
      );
      Pug.destroy();
    });
  });
}
