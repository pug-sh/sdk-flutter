import 'package:flutter/widgets.dart';

import 'configuration.dart';
import 'errors.dart';
import 'runtime.dart';

class Pug {
  Pug._();

  static final Pug _shared = Pug._();

  static Pug get shared => _shared;

  PugClient? _client;

  PugClient? get clientOrNull => _client;

  static void init(String projectId, PugOptions options) {
    _shared.initialize(projectId, options);
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

  void destroyClient() {
    _client?.destroy();
    _client = null;
  }
}
