import 'dart:async';
import 'dart:convert';

import 'campaign.dart';
import 'contracts.dart';
import 'state_storage.dart';

/// Captures campaign parameters from the launch link and later app/deep links,
/// and replays the latest capture as auto-properties on subsequent events.
///
/// Built but not started: `PugClient.start()` never calls [start], so nothing
/// is captured and [properties] has no caller today. See
/// `### Not On The Public Surface` in CLAUDE.md.
///
/// Capture is deliberately not gated by tracking consent: parameters are only
/// written to project-scoped storage here, and nothing is transmitted until an
/// event is created (which is gated).
class CampaignTracker {
  CampaignTracker({
    required PugStorageKeys keys,
    required PugStorage storage,
    required PugLogger logger,
    PugLinkProvider? provider,
  }) : _keys = keys,
       _storage = storage,
       _logger = logger,
       _provider = provider;

  final PugStorageKeys _keys;
  final PugStorage _storage;
  final PugLogger _logger;
  final PugLinkProvider? _provider;
  StreamSubscription<Uri>? _subscription;

  Future<void> start() async {
    final provider = _provider;
    if (provider == null) {
      _logger.warn(
        'Pug campaign capture skipped: no PugLinkProvider was supplied.',
      );
      return;
    }

    try {
      final initial = await provider.initialUri();
      if (initial != null) {
        _capture(initial);
      }
    } catch (error, stackTrace) {
      _logger.warn('Pug could not read initial campaign link.');
      _logger.debug(error.toString());
      _logger.debug(stackTrace.toString());
    }

    try {
      _subscription = provider.uriStream.listen(
        _capture,
        onError: (Object error, StackTrace? stackTrace) {
          _logger.warn('Pug campaign link stream failed.');
          _logger.debug(error.toString());
          if (stackTrace != null) {
            _logger.debug(stackTrace.toString());
          }
        },
      );
    } catch (error, stackTrace) {
      _logger.warn('Pug could not listen for campaign links.');
      _logger.debug(error.toString());
      _logger.debug(stackTrace.toString());
    }
  }

  Map<String, Object?> properties() {
    final raw = _storage.getString(_keys.campaign);
    final decoded = raw == null ? null : decodeStoredJsonMap(raw, _logger);
    if (decoded == null) {
      return const {};
    }
    final properties = <String, Object?>{};
    for (final entry in decoded.entries) {
      if (entry.key.startsWith(r'$')) {
        properties[entry.key] = entry.value;
      }
    }
    return properties;
  }

  void clear() {
    _storage.remove(_keys.campaign);
  }

  void dispose() {
    unawaited(_subscription?.cancel());
    _provider?.dispose();
  }

  void _capture(Uri uri) {
    final properties = campaignPropertiesFromUri(uri);
    if (properties.isEmpty) {
      return;
    }
    _storage.setString(_keys.campaign, jsonEncode(properties));
  }
}
