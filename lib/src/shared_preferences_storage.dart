import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'contracts.dart';

class SharedPreferencesPugStorage implements PugStorage {
  SharedPreferencesPugStorage(
    this.preferences, {
    this.logger,
    // Seams for testing the async-failure handling; default to the real plugin.
    Future<bool> Function(String key, String value)? writeString,
    Future<bool> Function(String key)? removeKey,
  }) : _writeString = writeString ?? preferences.setString,
       _removeKey = removeKey ?? preferences.remove;

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
  void remove(String key) {
    // Writes are async; attach a handler so a rejected future is observed and
    // logged instead of becoming an unhandled error or a silent no-op.
    unawaited(
      _removeKey(key).catchError((Object error) {
        logger?.warn('Pug could not remove "$key" from persistent storage.');
        return false;
      }),
    );
  }

  @override
  void setString(String key, String value) {
    unawaited(
      _writeString(key, value).catchError((Object error) {
        logger?.warn('Pug could not persist "$key" to persistent storage.');
        return false;
      }),
    );
  }
}
