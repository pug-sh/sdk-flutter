import 'dart:js_interop';

import 'package:flutter/foundation.dart';

import 'contracts.dart';

/// `navigator.userAgentData`, the User-Agent Client Hints API. Only Chromium
/// browsers have it; on Safari and Firefox it is undefined, so null here.
@JS('navigator.userAgentData')
external NavigatorUAData? get _navigatorUserAgentData;

Future<Map<String, Object?>> userAgentDataProperties({PugLogger? logger}) =>
    userAgentDataPropertiesFrom(_navigatorUserAgentData, logger: logger);

/// Mirrors sdk-browser's `parseUserAgentData` (`src/parsers.ts`): `$os` is the
/// low-entropy `platform`, and `$osVersion` the high-entropy `platformVersion`.
/// The version is best-effort. A rejected request leaves it out, and so does
/// one that outlasts [timeout], which keeps a promise that never settles from
/// holding up `Pug.init`.
@visibleForTesting
Future<Map<String, Object?>> userAgentDataPropertiesFrom(
  NavigatorUAData? data, {
  Duration timeout = const Duration(seconds: 1),
  PugLogger? logger,
}) async {
  if (data == null) {
    return const {};
  }
  final properties = <String, Object?>{};
  final platform = data.platform;
  if (platform != null && platform.isNotEmpty) {
    properties[r'$os'] = platform;
  }
  try {
    final values = await data
        .getHighEntropyValues(['platformVersion'.toJS].toJS)
        .toDart
        .timeout(timeout);
    final version = values.platformVersion;
    if (version != null && version.isNotEmpty) {
      properties[r'$osVersion'] = version;
    }
  } catch (error) {
    logger?.warn(
      'Pug could not read the browser OS version for auto properties: $error',
    );
  }
  return properties;
}

extension type NavigatorUAData._(JSObject _) implements JSObject {
  external String? get platform;
  external JSPromise<UADataValues> getHighEntropyValues(
    JSArray<JSString> hints,
  );
}

extension type UADataValues._(JSObject _) implements JSObject {
  external String? get platformVersion;
}
