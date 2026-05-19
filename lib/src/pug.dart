import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'auto_properties.dart';
import 'configuration.dart';
import 'contracts.dart';
import 'runtime.dart';
import 'shared_preferences_storage.dart';

class Pug {
  Pug._();

  static final Pug _shared = Pug._();
  static const PugLogger _fallbackLogger = SafePugLogger(DebugPrintPugLogger());

  static Pug get shared => _shared;

  PugClient? _client;

  PugClient? get clientOrNull => _client;

  @internal
  PugLogger get logger => _client?.logger ?? _fallbackLogger;

  static Future<void> init(String projectId, PugOptions options) =>
      _shared.initialize(projectId, options);

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

  Future<void> initialize(String projectId, PugOptions options) async {
    final logger = SafePugLogger(options.logger);
    if (projectId.trim().isEmpty) {
      throw ArgumentError('projectId is required');
    }
    if (options.apiKey.trim().isEmpty) {
      throw ArgumentError('apiKey is required');
    }
    if (_client != null) {
      logger.warn('Pug.init() called after initialization; ignoring.');
      return;
    }
    try {
      final resolvedOptions = options.copyWith(
        logger: logger,
        storage: options.storage ?? await SharedPreferencesPugStorage.create(),
        autoPropertyProvider:
            options.autoPropertyProvider ??
            await SystemPugAutoPropertyProvider.create(logger: logger),
      );
      final client = PugClient(
        projectId: projectId,
        options: resolvedOptions,
        lifecycleBinding: WidgetsBinding.instance,
      );
      PugClient.onRouteChanged = client.notifyRouteChanged;
      await client.start();
      if (client.isStarted) {
        _client = client;
      }
    } catch (error, stackTrace) {
      logger.error('Pug init failed.', error, stackTrace);
      rethrow;
    }
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
    if (externalId.trim().isEmpty) {
      throw ArgumentError('externalId is required');
    }
    final client = _client;
    if (client == null) {
      _fallbackLogger.warn('Pug.identify() called before init(); ignoring.');
      return;
    }
    try {
      await client.identify(externalId, traits: traits);
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug identify failed.', error, stackTrace);
      rethrow;
    }
  }

  void resetClient() {
    try {
      _client?.reset();
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug reset failed.', error, stackTrace);
    }
  }

  void rotateClient() {
    try {
      _client?.rotate();
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug rotate failed.', error, stackTrace);
    }
  }

  Future<void> flushClient() async {
    try {
      await _client?.flushAll();
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug flush failed.', error, stackTrace);
    }
  }

  void destroyClient() {
    try {
      _client?.destroy();
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug destroy failed.', error, stackTrace);
    } finally {
      _client = null;
    }
  }
}
