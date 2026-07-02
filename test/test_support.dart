import 'dart:async';
import 'dart:convert';

import 'package:connectrpc/connect.dart' as connect;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter/pug_flutter.dart';

import 'test_doubles.dart';

export 'test_doubles.dart';

class NamedRoute extends Route<void> {
  NamedRoute(String name) : super(settings: RouteSettings(name: name));
}

PugClient testClient({
  FakeTransport? transport,
  FakeClock? clock,
  SequenceIds? ids,
  MemoryPugStorage? storage,
  PugLogger? logger,
  PugAutoPropertyProvider? autoPropertyProvider,
  PugLinkProvider? linkProvider,
  bool autoTrack = false,
  bool autoPageViews = false,
  bool autoCaptureCampaigns = false,
  WidgetsBinding? lifecycleBinding,
}) {
  final client = PugClient(
    projectId: 'project',
    options: PugOptions(
      apiKey: 'key',
      transport: transport ?? FakeTransport(),
      storage: storage ?? MemoryPugStorage(),
      logger: logger ?? const NoopPugLogger(),
      autoPropertyProvider:
          autoPropertyProvider ?? const PugStaticAutoPropertyProvider({}),
      linkProvider: linkProvider,
      autoTrack: autoTrack,
      autoPageViews: autoPageViews,
      autoCaptureCampaigns: autoCaptureCampaigns,
      batch: const BatchConfig(maxWaitMs: 60000),
    ),
    clock: clock ?? FakeClock(1000),
    idGenerator: ids ?? SequenceIds(),
    lifecycleBinding: lifecycleBinding,
  );
  unawaited(client.start());
  addTearDown(client.destroy);
  return client;
}

Map<String, Object?> readSession(MemoryPugStorage storage) {
  final raw = storage.getString('__pug_project_session__')!;
  final decoded = jsonDecode(raw);
  if (decoded is! Map<Object?, Object?>) {
    return const {};
  }
  final typed = <String, Object?>{};
  for (final entry in decoded.entries) {
    final key = entry.key;
    if (key is String) {
      typed[key] = entry.value;
    }
  }
  return typed;
}

String? readDeviceId(MemoryPugStorage storage) =>
    storage.getString('__pug_project_device_id__');

Event fakeEvent(String kind) {
  return Event(
    eventId: 'event-$kind',
    projectId: 'project',
    kind: kind,
    sessionId: 'session',
    distinctId: 'anon',
    occurTime: 1,
    customProperties: const {},
    autoProperties: const {},
  );
}

class FakeConnectTransport implements connect.Transport {
  Object? unaryError;
  connect.Headers? lastHeaders;
  String? lastProcedure;

  @override
  Future<connect.UnaryResponse<I, O>> unary<I extends Object, O extends Object>(
    connect.Spec<I, O> spec,
    I input, [
    connect.CallOptions? options,
  ]) async {
    lastProcedure = spec.procedure;
    lastHeaders = options?.headers;
    if (unaryError != null) {
      throw unaryError!;
    }
    return connect.UnaryResponse(
      spec,
      connect.Headers(),
      spec.outputFactory(),
      connect.Headers(),
    );
  }

  @override
  Future<connect.StreamResponse<I, O>> stream<
    I extends Object,
    O extends Object
  >(connect.Spec<I, O> spec, Stream<I> input, [connect.CallOptions? options]) {
    throw UnimplementedError();
  }
}

class FakeClock implements PugClock {
  FakeClock(this.value);

  int value;

  @override
  int nowMillis() => value;
}

class SequenceIds implements PugIdGenerator {
  int value = 0;

  @override
  String nextId() {
    value += 1;
    return 'id-$value';
  }
}

class ThrowingLogger implements PugLogger {
  const ThrowingLogger();

  @override
  void debug(String message) {
    throw StateError('debug failed');
  }

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    throw StateError('error failed');
  }

  @override
  void warn(String message) {
    throw StateError('warn failed');
  }
}

class FakeLinkProvider implements PugLinkProvider {
  FakeLinkProvider({this.initial});

  final Uri? initial;
  final StreamController<Uri> _controller = StreamController<Uri>.broadcast();

  void add(Uri uri) {
    _controller.add(uri);
  }

  @override
  Future<Uri?> initialUri() async => initial;

  @override
  Stream<Uri> get uriStream => _controller.stream;

  @override
  void dispose() {
    unawaited(_controller.close());
  }
}

class FakePushProvider implements PushProvider {
  FakePushProvider({this.token = 'token-1', this.deleteError});

  final String token;
  final Object? deleteError;

  @override
  String get platform => 'android';

  @override
  String get provider => 'fake';

  @override
  Future<void> deleteToken() async {
    final error = deleteError;
    if (error != null) {
      throw error;
    }
  }

  @override
  Future<String> getToken() async => token;

  @override
  Map<Object?, Object?> notificationData(Object source) => const {};
}
