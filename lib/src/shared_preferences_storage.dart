import 'dart:async';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'contracts.dart';

class SharedPreferencesPugStorage implements PugStorage {
  SharedPreferencesPugStorage(this.preferences, {this.logger})
    : _writeString = preferences.setString,
      _removeKey = preferences.remove;

  /// Test seam: inject fake write/remove futures to exercise the async-failure
  /// handling without a real platform channel.
  @visibleForTesting
  SharedPreferencesPugStorage.withSeams(
    this.preferences, {
    this.logger,
    required Future<bool> Function(String key, String value) writeString,
    required Future<bool> Function(String key) removeKey,
  }) : _writeString = writeString,
       _removeKey = removeKey;

  static Future<SharedPreferencesPugStorage> create({PugLogger? logger}) async {
    final preferences = await SharedPreferences.getInstance();
    return SharedPreferencesPugStorage(preferences, logger: logger);
  }

  final SharedPreferences preferences;
  final PugLogger? logger;
  final Future<bool> Function(String key, String value) _writeString;
  final Future<bool> Function(String key) _removeKey;

  @override
  String? getString(String key) => preferences.getString(key);

  @override
  void remove(String key) => _observe(
    _removeKey(key),
    'Pug could not remove "$key" from persistent storage.',
  );

  @override
  void setString(String key, String value) => _observe(
    _writeString(key, value),
    'Pug could not persist "$key" to persistent storage.',
  );

  // The plugin call is async, and a failed write surfaces either as a rejected
  // future or as `false` (Android's `commit()` result). Observe both so neither
  // becomes an unhandled error or a silent no-op. Log only the key plus the
  // error for diagnosis.
  void _observe(Future<bool> write, String failure) {
    unawaited(
      write.then(
        (written) {
          if (!written) {
            logger?.warn(failure);
          }
        },
        onError: (Object error) {
          logger?.warn(failure);
          logger?.debug(error.toString());
        },
      ),
    );
  }
}
