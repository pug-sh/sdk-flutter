import 'dart:convert';

import 'contracts.dart';

/// Project-namespaced keys for every piece of state the SDK persists.
///
/// The formats are a cross-SDK contract shared with `../sdk-web`, so they live
/// in one place rather than being rebuilt at each call site.
class PugStorageKeys {
  const PugStorageKeys(this.projectId);

  final String projectId;

  String get session => '__pug_${projectId}_session__';
  String get profile => '__pug_${projectId}_profile__';
  String get deviceId => '__pug_${projectId}_device_id__';
  String get externalId => '__pug_${projectId}_external_id__';
  String get queue => '__pug_${projectId}_queue__';
  String get campaign => '__pug_${projectId}_campaign__';
  String get consent => '__pug_${projectId}_consent__';
  String get lastVersion => '__pug_${projectId}_last_version__';

  /// Every project-scoped key the SDK owns, in the order they are documented.
  ///
  /// A key added here but not to the purge in `PugClient.destroy()` (or the
  /// other way round) changes install detection, via [priorActivity].
  List<String> get all => [
    session,
    profile,
    deviceId,
    externalId,
    queue,
    campaign,
    consent,
    lastVersion,
  ];

  /// The keys whose presence proves the SDK has tracked on this device before.
  ///
  /// `InstallTracker` probes these to tell a fresh install from an app that
  /// already had Pug on it. Derived from [all] so a new key counts as evidence
  /// by default, minus two that are not:
  ///
  /// - `consent` is a user preference, not tracking activity, and is the one
  ///   key `destroy()` deliberately keeps. Counting it would suppress the
  ///   `app_install` of an install whose consent was denied at first launch and
  ///   granted later — exactly the case the deferral exists for.
  /// - `lastVersion` is what the probe is deciding.
  List<String> get priorActivity =>
      all.where((key) => key != consent && key != lastVersion).toList();
}

Map<String, Object?>? decodeStoredJsonMap(String raw, PugLogger logger) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<Object?, Object?>) {
      return null;
    }
    final typed = <String, Object?>{};
    for (final entry in decoded.entries) {
      final key = entry.key;
      if (key is String) {
        typed[key] = entry.value;
      }
    }
    return typed;
  } catch (error, stackTrace) {
    logger.warn('Pug stored JSON could not be decoded.');
    logger.debug(error.toString());
    logger.debug(stackTrace.toString());
    return null;
  }
}
