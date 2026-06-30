import 'contracts.dart';

/// Whether the SDK is permitted to capture and transmit events.
enum TrackingConsent { granted, denied }

/// Configures the initial tracking-consent state and whether opt in/out is
/// persisted across app launches.
///
/// Mirrors the web SDK's `trackingConsent` option. When consent is
/// [TrackingConsent.denied], `track()`, the typed `Pug.track.*` methods,
/// `identify()`, and all automatic capture (lifecycle, page views,
/// notifications) are dropped until [Pug.optInTracking] is called.
class TrackingConsentConfig {
  const TrackingConsentConfig({
    this.defaultConsent = TrackingConsent.granted,
    this.persist = false,
  });

  /// First-run seed used when nothing is persisted yet. Defaults to
  /// [TrackingConsent.granted].
  final TrackingConsent defaultConsent;

  /// Persist opt in/out to the configured [PugStorage] and restore any
  /// persisted value on the next `Pug.init(...)`. Defaults to `false`.
  ///
  /// A stored value is only read back while this is `true`, so switching from
  /// `true` to `false` does not honor a previously persisted opt-out — it
  /// reverts to [defaultConsent] on the next launch.
  final bool persist;
}

/// Holds the live consent state and, when [TrackingConsentConfig.persist] is
/// set, mirrors it to project-scoped storage under
/// `__pug_<projectId>_consent__`.
class TrackingConsentController {
  TrackingConsentController({
    required String projectId,
    required PugStorage storage,
    required PugLogger logger,
    TrackingConsentConfig config = const TrackingConsentConfig(),
  }) : _storage = storage,
       _logger = logger,
       _persist = config.persist,
       _key = '__pug_${projectId}_consent__',
       _status = config.defaultConsent {
    if (_persist) {
      _restore();
    }
  }

  final PugStorage _storage;
  final PugLogger _logger;
  final bool _persist;
  final String _key;
  TrackingConsent _status;

  TrackingConsent get status => _status;

  bool get isGranted => _status == TrackingConsent.granted;

  void optIn() => _set(TrackingConsent.granted);

  void optOut() => _set(TrackingConsent.denied);

  void _set(TrackingConsent value) {
    _status = value;
    if (_persist) {
      // `name` is the wire format ('granted'/'denied'); see _restore.
      _storage.setString(_key, value.name);
    }
  }

  void _restore() {
    final stored = _storage.getString(_key);
    if (stored == null) {
      return;
    }
    try {
      _status = TrackingConsent.values.byName(stored);
    } on ArgumentError {
      _logger.warn('Stored tracking consent "$stored" is invalid; ignoring.');
    }
  }
}
