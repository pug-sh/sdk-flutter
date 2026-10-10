import 'dart:convert';
import 'dart:math';

import 'contracts.dart';
import 'events.dart';
import 'identity.dart';

class PugEventQueue {
  PugEventQueue({
    required this.key,
    required PugStorage storage,
    required PugLogger logger,
    required this.maxQueueSize,
  }) : _storage = storage,
       _logger = logger {
    _unlocked.addAll(_readPersisted());
  }

  final String key;
  final PugStorage _storage;
  final PugLogger _logger;
  final int maxQueueSize;
  final List<Event> _unlocked = <Event>[];
  List<Event> _locked = <Event>[];
  bool _detached = false;

  int get size => _unlocked.length;

  int get totalSize => _unlocked.length + _locked.length;

  void push(Event event) {
    if (_unlocked.length + _locked.length >= maxQueueSize) {
      if (_unlocked.isEmpty) {
        _logger.warn('Pug queue is full during flush; dropped new event.');
        return;
      }
      _unlocked.removeAt(0);
      _logger.warn('Pug queue is full; dropped oldest event.');
    }
    _unlocked.add(event);
    _persist();
  }

  List<Event> lock(int limit) {
    if (_locked.isNotEmpty) {
      return const [];
    }
    final count = min(limit, _unlocked.length);
    _locked = _unlocked.take(count).toList();
    _unlocked.removeRange(0, count);
    _persist();
    return List<Event>.unmodifiable(_locked);
  }

  void commit() {
    _locked = <Event>[];
    _persist();
  }

  void rollback() {
    if (_locked.isNotEmpty) {
      _unlocked.insertAll(0, _locked);
      _locked = <Event>[];
      _persist();
    }
  }

  List<Event> peekUnlocked() => List<Event>.unmodifiable(_unlocked);

  void dispose() {
    _persist();
  }

  /// Stops writing to storage: another owner holds this key now, and every
  /// [_persist] from here on would overwrite what it has written.
  void detachStorage() {
    _detached = true;
  }

  List<Event> _readPersisted() {
    final raw = _storage.getString(key);
    if (raw == null) {
      return const [];
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return const [];
      }
      final events = <Event>[];
      for (final item in decoded) {
        if (item is Map<Object?, Object?>) {
          events.add(Event.fromJson(_stringObjectMap(item)));
        }
      }
      // Queued before PugIdentity discarded a reserved external ID. The server
      // rejects any batch holding one, healthy events included.
      final restored = events.length;
      events.removeWhere(
        (event) => event.distinctId.startsWith(reservedDistinctIdPrefix),
      );
      if (events.length < restored) {
        _logger.warn(
          'Pug discarded ${restored - events.length} queued events whose '
          'distinct ID uses the reserved "$reservedDistinctIdPrefix" prefix.',
        );
      }
      return events;
    } catch (_) {
      _logger.warn('Pug queue storage could not be decoded; starting empty.');
      return const [];
    }
  }

  void _persist() {
    if (_detached) {
      return;
    }
    final all = <Event>[..._locked, ..._unlocked];
    _storage.setString(
      key,
      jsonEncode(all.map((event) => event.toJson()).toList()),
    );
  }
}

Map<String, Object?> _stringObjectMap(Map<Object?, Object?> value) {
  final typed = <String, Object?>{};
  for (final entry in value.entries) {
    final key = entry.key;
    if (key is String) {
      typed[key] = entry.value;
    }
  }
  return typed;
}
