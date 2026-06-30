import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'contracts.dart';

class SharedPreferencesPugStorage implements PugStorage {
  const SharedPreferencesPugStorage(
    this.preferences, {
    PugLogger logger = const NoopPugLogger(),
  }) : _logger = logger;

  static Future<SharedPreferencesPugStorage> create({
    PugLogger logger = const NoopPugLogger(),
  }) async {
    final preferences = await SharedPreferences.getInstance();
    return SharedPreferencesPugStorage(preferences, logger: logger);
  }

  final SharedPreferences preferences;
  final PugLogger _logger;

  @override
  String? getString(String key) => preferences.getString(key);

  @override
  void remove(String key) {
    // The write is fire-and-forget to keep the interface synchronous, but its
    // failure must be observable — silently losing a removal (e.g. of consent)
    // would otherwise go unnoticed until the next launch.
    unawaited(
      preferences.remove(key).catchError((Object error, StackTrace stack) {
        _logger.error('Pug storage failed to remove "$key".', error, stack);
        return false;
      }),
    );
  }

  @override
  void setString(String key, String value) {
    // See remove(): surface async write failures so a value that fails to
    // persist (e.g. a tracking-consent opt-out) is logged rather than lost
    // silently when it does not survive a restart.
    unawaited(
      preferences.setString(key, value).catchError((
        Object error,
        StackTrace stack,
      ) {
        _logger.error(
          'Pug storage failed to persist "$key"; it may not survive a restart.',
          error,
          stack,
        );
        return false;
      }),
    );
  }
}
