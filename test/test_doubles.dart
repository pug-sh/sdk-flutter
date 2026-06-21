import 'package:pug_sdk/pug_sdk.dart';

class CapturingLogger implements PugLogger {
  final List<String> warnings = <String>[];
  final List<String> errors = <String>[];
  final List<String> debugs = <String>[];

  @override
  void debug(String message) {
    debugs.add(message);
  }

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
