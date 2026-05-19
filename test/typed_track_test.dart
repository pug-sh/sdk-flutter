import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter_sdk/pug_flutter_sdk.dart';

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
  });
}
