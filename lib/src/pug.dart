import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'auto_properties.dart';
import 'configuration.dart';
import 'contracts.dart';
import 'runtime.dart';
import 'shared_preferences_storage.dart';
import 'track_namespace.dart';
import 'tracking_consent.dart';

class Pug implements TrackContext {
  Pug._();

  static final Pug _shared = Pug._();
  static const PugLogger _fallbackLogger = SafePugLogger(DebugPrintPugLogger());

  static Pug get shared => _shared;

  PugClient? _client;

  PugClient? get clientOrNull => _client;

  /// Exposed for `TrackContext`; not part of the public API.
  /// Returns the configured `PugLogger` once init completes, falling back to a
  /// safe wrapper around `DebugPrintPugLogger` before then so callers (notably
  /// `TrackNamespace`) never see null pre-init.
  @internal
  @override
  PugLogger get logger => _client?.logger ?? _fallbackLogger;

  static Future<void> init(String projectId, PugOptions options) =>
      _shared.initialize(projectId, options);

  /// Entry point for tracking analytics events.
  ///
  /// Two call shapes are supported:
  ///
  /// * **Typed**: `Pug.track.<event>(...)` for well-known events. Required
  ///   fields are compile-time enforced and value types are checked. Each
  ///   typed method accepts an optional `extras: Map<String, Object?>` for
  ///   ad-hoc properties. If an `extras` key collides with a named arg, the
  ///   named arg wins and the override is logged at WARN.
  /// * **Untyped (escape hatch)**: `Pug.track('kind', props: {...})` for
  ///   custom or dynamic event names. Calling this with a well-known event
  ///   kind still works but emits a debug-level hint (once per kind, per
  ///   process) recommending the typed alternative. The hint is sent through
  ///   the configured [PugLogger.debug] channel, so the default
  ///   `DebugPrintPugLogger` drops it in release builds; custom loggers may
  ///   see it in any build mode.
  ///
  /// Both shapes are best-effort: failures are caught and logged via the
  /// configured [PugLogger] and never propagate to the host app.
  static final TrackNamespace track = TrackNamespace(_shared);

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

  /// Grants tracking consent. When consent is denied, `track()`, the typed
  /// `Pug.track.*` methods, `identify()`, and all automatic capture are
  /// dropped; opting in re-enables them for subsequent calls. No-ops with a
  /// warning if called before [init]. See [TrackingConsentConfig].
  static void optInTracking() => _shared._optInTracking();

  /// Denies tracking consent. Subsequent events and identifies are dropped
  /// until [optInTracking] is called. No-ops with a warning if called before
  /// [init].
  static void optOutTracking() => _shared._optOutTracking();

  /// Returns the current tracking-consent state, or [TrackingConsent.denied]
  /// if called before [init].
  static TrackingConsent getTrackingConsent() => _shared._getTrackingConsent();

  /// Whether tracking is currently permitted. Reflects consent only — it is
  /// independent of `dryRun`, which suppresses delivery without changing
  /// consent. Returns `false` if called before [init].
  static bool isTrackingEnabled() => _shared._isTrackingEnabled();

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
        storage:
            options.storage ??
            await SharedPreferencesPugStorage.create(logger: logger),
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

  @internal
  @override
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

  void _optInTracking() {
    final client = _client;
    if (client == null) {
      _fallbackLogger.warn(
        'Pug.optInTracking() called before init(); ignoring.',
      );
      return;
    }
    try {
      client.optInTracking();
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug optInTracking failed.', error, stackTrace);
    }
  }

  void _optOutTracking() {
    final client = _client;
    if (client == null) {
      _fallbackLogger.warn(
        'Pug.optOutTracking() called before init(); ignoring.',
      );
      return;
    }
    try {
      client.optOutTracking();
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug optOutTracking failed.', error, stackTrace);
    }
  }

  TrackingConsent _getTrackingConsent() {
    final client = _client;
    if (client == null) {
      _fallbackLogger.warn(
        'Pug.getTrackingConsent() called before init(); returning denied.',
      );
      return TrackingConsent.denied;
    }
    return client.trackingConsent;
  }

  bool _isTrackingEnabled() {
    final client = _client;
    if (client == null) {
      _fallbackLogger.warn(
        'Pug.isTrackingEnabled() called before init(); returning false.',
      );
      return false;
    }
    return client.isTrackingEnabled;
  }
}
