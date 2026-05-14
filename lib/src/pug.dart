import 'package:flutter/widgets.dart';

import 'auto_properties.dart';
import 'configuration.dart';
import 'errors.dart';
import 'runtime.dart';
import 'shared_preferences_storage.dart';

class Pug {
  Pug._();

  static final Pug _shared = Pug._();

  static Pug get shared => _shared;

  PugClient? _client;

  PugClient? get clientOrNull => _client;

  static void init(String projectId, PugOptions options) {
    _shared.initialize(projectId, options);
  }

  static Future<void> initPersistent(
    String projectId,
    PugOptions options,
  ) async {
    await _shared.initializePersistent(projectId, options);
  }

  static void track(
    String kind, {
    Map<String, Object?> props = const {},
    TrackOptions options = const TrackOptions(),
  }) {
    _shared.capture(kind, props: props, options: options);
  }

  static Future<void> identify(
    String externalId, {
    Map<String, Object?> traits = const {},
  }) {
    return _shared.identifyProfile(externalId, traits: traits);
  }

  static void reset() => _shared.resetClient();

  static void rotate() => _shared.rotateClient();

  static Future<void> flush() => _shared.flushClient();

  static void destroy() => _shared.destroyClient();

  void initialize(String projectId, PugOptions options) {
    if (projectId.trim().isEmpty) {
      throw const PugException('projectId is required.');
    }
    if (options.apiKey.trim().isEmpty) {
      throw const PugException('apiKey is required.');
    }
    if (_client != null) {
      options.logger.warn('Pug is already initialized; repeated init ignored.');
      return;
    }
    final client = PugClient(
      projectId: projectId,
      options: options,
      lifecycleBinding: WidgetsBinding.instance,
    );
    client.start();
    _client = client;
  }

  Future<void> initializePersistent(
    String projectId,
    PugOptions options,
  ) async {
    final storage =
        options.storage ?? await SharedPreferencesPugStorage.create();
    final autoPropertyProvider =
        options.autoPropertyProvider ??
        await SystemPugAutoPropertyProvider.create(logger: options.logger);
    initialize(
      projectId,
      options.copyWith(
        storage: storage,
        autoPropertyProvider: autoPropertyProvider,
      ),
    );
  }

  void capture(
    String kind, {
    Map<String, Object?> props = const {},
    TrackOptions options = const TrackOptions(),
  }) {
    _client?.track(kind, props: props, options: options);
  }

  Future<void> identifyProfile(
    String externalId, {
    Map<String, Object?> traits = const {},
  }) async {
    final client = _client;
    if (client == null) {
      throw const PugException('Pug has not been initialized.');
    }
    await client.identify(externalId, traits: traits);
  }

  void resetClient() => _client?.reset();

  void rotateClient() => _client?.rotate();

  Future<void> flushClient() async => _client?.flushAll();

  void destroyClient() {
    _client?.destroy();
    _client = null;
  }
}
