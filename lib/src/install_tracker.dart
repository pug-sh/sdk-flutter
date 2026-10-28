import 'contracts.dart';
import 'state_storage.dart';

/// Emits `app_install` or `app_update` once per app version.
///
/// The version comes from the `$appVersion` auto-property, so a provider that
/// could not read package info silently disables detection rather than
/// guessing at a version.
///
/// The install branch additionally requires that no *other* Pug key exists.
/// Without that, shipping this SDK into an app that already used Pug would
/// report every existing user as a new install. Corollary: `destroy()` purges
/// those keys, so a destroy/re-init cycle does look like a fresh install —
/// defensible, in that no prior state is left, but it is a reason not to call
/// `destroy()` routinely.
///
/// The stored version only advances when [capture] reports the event was
/// really captured, matching `AppLifecycleTracker`: a consent-denied install
/// is retried on the next launch instead of being lost for good.
class InstallTracker {
  InstallTracker({
    required bool enabled,
    required PugStorageKeys keys,
    required PugStorage storage,
    required PugLogger logger,
    required Map<String, Object?> Function() autoProperties,
    required String? installSource,
    required bool Function(String kind, Map<String, Object?> props) capture,
  }) : _enabled = enabled,
       _keys = keys,
       _storage = storage,
       _logger = logger,
       _autoProperties = autoProperties,
       _installSource = installSource,
       _capture = capture;

  final bool _enabled;
  final PugStorageKeys _keys;
  final PugStorage _storage;
  final PugLogger _logger;
  final Map<String, Object?> Function() _autoProperties;
  final String? _installSource;
  final bool Function(String kind, Map<String, Object?> props) _capture;

  /// Must run before anything else in `start()` writes a project-scoped key,
  /// or the install branch's prior-state probe sees this launch's own state.
  void check() {
    if (!_enabled) {
      return;
    }
    try {
      final version = _autoProperties()[r'$appVersion'];
      if (version is! String || version.isEmpty) {
        _logger.debug(
          r'Pug install/update detection skipped: no $appVersion auto-property.',
        );
        return;
      }
      final lastVersion = _storage.getString(_keys.lastVersion);
      if (lastVersion == version) {
        return;
      }
      if (lastVersion == null || lastVersion.isEmpty) {
        if (_hasPriorState()) {
          _storage.setString(_keys.lastVersion, version);
          return;
        }
        if (_capture('app_install', {
          'appVersion': version,
          if (_installSource != null && _installSource.isNotEmpty)
            'installSource': _installSource,
        })) {
          _storage.setString(_keys.lastVersion, version);
        }
        return;
      }
      if (_capture('app_update', {
        'appVersion': version,
        'previousVersion': lastVersion,
      })) {
        _storage.setString(_keys.lastVersion, version);
      }
    } catch (error, stackTrace) {
      _logger.error('Pug install/update detection failed.', error, stackTrace);
    }
  }

  bool _hasPriorState() =>
      _keys.priorActivity.any((key) => _storage.getString(key) != null);
}
