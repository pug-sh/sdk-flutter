import 'package:flutter/foundation.dart';

import 'events.dart';
import 'push_models.dart';

abstract interface class PugLogger {
  void debug(String message);
  void warn(String message);
  void error(String message, [Object? error, StackTrace? stackTrace]);
}

class NoopPugLogger implements PugLogger {
  const NoopPugLogger();

  @override
  void debug(String message) {}

  @override
  void warn(String message) {}

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {}
}

class DebugPrintPugLogger implements PugLogger {
  const DebugPrintPugLogger();

  @override
  void debug(String message) => debugPrint('[Pug] $message');

  @override
  void warn(String message) => debugPrint('[Pug][warn] $message');

  @override
  void error(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[Pug][error] $message${error == null ? '' : ' $error'}');
  }
}

abstract interface class PugStorage {
  String? getString(String key);
  void setString(String key, String value);
  void remove(String key);
}

class MemoryPugStorage implements PugStorage {
  final Map<String, String> _values = <String, String>{};

  @override
  String? getString(String key) => _values[key];

  @override
  void setString(String key, String value) {
    _values[key] = value;
  }

  @override
  void remove(String key) {
    _values.remove(key);
  }
}

class SafePugStorage implements PugStorage {
  SafePugStorage({
    required PugStorage? primary,
    required PugStorage fallback,
    required PugLogger logger,
  }) : _primary = primary,
       _fallback = fallback,
       _logger = logger;

  final PugStorage? _primary;
  final PugStorage _fallback;
  final PugLogger _logger;
  bool _useFallback = false;

  @override
  String? getString(String key) =>
      _guard(() => _active.getString(key), () => _fallback.getString(key));

  @override
  void setString(String key, String value) => _guard(
    () => _active.setString(key, value),
    () => _fallback.setString(key, value),
  );

  @override
  void remove(String key) =>
      _guard(() => _active.remove(key), () => _fallback.remove(key));

  PugStorage get _active => _useFallback ? _fallback : (_primary ?? _fallback);

  T _guard<T>(T Function() action, T Function() fallback) {
    try {
      return action();
    } catch (_) {
      _logger.warn('Pug persistent storage failed; using memory fallback.');
      _useFallback = true;
      return fallback();
    }
  }
}

abstract interface class PugTransport {
  Future<void> send(Event event);
  Future<void> sendBatch(List<Event> events);
  Future<void> identify(IdentifyRequest request);
  Future<void> subscribeDevice(PushSubscription subscription);
}
