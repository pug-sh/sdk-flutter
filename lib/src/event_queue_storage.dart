import 'dart:convert';
import 'dart:math';

import 'contracts.dart';
import 'events.dart';

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

  int get size => _unlocked.length;

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
      return events;
    } catch (_) {
      _logger.warn('Pug queue storage could not be decoded; starting empty.');
      return const [];
    }
  }

  void _persist() {
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
