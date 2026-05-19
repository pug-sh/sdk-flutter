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

class CapturingLogger implements PugLogger {
  final List<String> warnings = <String>[];
  final List<String> errors = <String>[];

  @override
  void debug(String message) {}

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    errors.add(message);
  }

  @override
  void warn(String message) {
    warnings.add(message);
  }
}

class FakeTransport implements PugTransport {
  final List<Event> sent = <Event>[];
  final List<List<Event>> batches = <List<Event>>[];
  final List<IdentifyRequest> identifies = <IdentifyRequest>[];
  final List<PushSubscription> subscriptions = <PushSubscription>[];
  Object? sendFailure;
  Object? batchFailure;
  PugTransportException? batchError;
  PugTransportException? identifyError;

  @override
  Future<void> send(Event event) async {
    if (sendFailure != null) {
      throw sendFailure!;
    }
    sent.add(event);
  }

  @override
  Future<void> sendBatch(List<Event> events) async {
    if (batchFailure != null) {
      throw batchFailure!;
    }
    if (batchError != null) {
      throw batchError!;
    }
    batches.add(events);
  }

  @override
  Future<void> identify(IdentifyRequest request) async {
    if (identifyError != null) {
      throw identifyError!;
    }
    identifies.add(request);
  }

  @override
  Future<void> subscribeDevice(PushSubscription subscription) async {
    subscriptions.add(subscription);
  }
}
