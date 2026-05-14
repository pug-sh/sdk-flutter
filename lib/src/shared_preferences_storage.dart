import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'contracts.dart';

class SharedPreferencesPugStorage implements PugStorage {
  const SharedPreferencesPugStorage(this.preferences);

  static Future<SharedPreferencesPugStorage> create() async {
    final preferences = await SharedPreferences.getInstance();
    return SharedPreferencesPugStorage(preferences);
  }

  final SharedPreferences preferences;

  @override
  String? getString(String key) => preferences.getString(key);

  @override
  void remove(String key) {
    unawaited(preferences.remove(key));
  }

  @override
  void setString(String key, String value) {
    unawaited(preferences.setString(key, value));
  }
}
