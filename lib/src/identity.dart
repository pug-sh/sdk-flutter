import 'dart:convert';

import 'clock_ids.dart';
import 'configuration.dart';
import 'contracts.dart';
import 'state_storage.dart';

/// The server mints cookieless identities with this prefix and rejects any
/// client-sent `distinct_id` or `external_id` that carries it.
const String reservedDistinctIdPrefix = 'cookieless-';

class SessionState {
  const SessionState({
    required this.sessionId,
    required this.startTime,
    required this.lastActivityTime,
    required this.deviceId,
  });

  final String sessionId;
  final int startTime;
  final int lastActivityTime;
  final String deviceId;

  SessionState copyWith({int? lastActivityTime}) {
    return SessionState(
      sessionId: sessionId,
      startTime: startTime,
      lastActivityTime: lastActivityTime ?? this.lastActivityTime,
      deviceId: deviceId,
    );
  }

  Map<String, Object?> toJson() => {
    'sessionId': sessionId,
    'startTime': startTime,
    'lastActivityTime': lastActivityTime,
    'deviceId': deviceId,
  };

  static SessionState? fromJson(Map<String, Object?> json) {
    return SessionState(
      sessionId: json['sessionId']! as String,
      startTime: json['startTime']! as int,
      lastActivityTime: json['lastActivityTime']! as int,
      deviceId: json['deviceId']! as String,
    );
  }
}

class ProfileState {
  const ProfileState({required this.anonymousId, this.externalId});

  final String anonymousId;
  final String? externalId;

  ProfileState copyWith({String? externalId}) {
    return ProfileState(
      anonymousId: anonymousId,
      externalId: externalId ?? this.externalId,
    );
  }

  Map<String, Object?> toJson() => {
    'anonymousId': anonymousId,
    if (externalId != null) 'externalId': externalId,
  };

  static ProfileState? fromJson(Map<String, Object?> json) {
    return ProfileState(
      anonymousId: json['anonymousId']! as String,
      externalId: json['externalId'] as String?,
    );
  }
}

/// Owns the device, session, and profile state that answers "who is this".
///
/// Device identity is stored separately from session state so [rotateSession]
/// can preserve it while [reset] rotates both.
class PugIdentity {
  PugIdentity({
    required PugStorageKeys keys,
    required PugStorage storage,
    required PugLogger logger,
    required PugClock clock,
    required PugIdGenerator ids,
    required SessionConfig config,
  }) : _keys = keys,
       _storage = storage,
       _logger = logger,
       _clock = clock,
       _ids = ids,
       _config = config;

  final PugStorageKeys _keys;
  final PugStorage _storage;
  final PugLogger _logger;
  final PugClock _clock;
  final PugIdGenerator _ids;
  final SessionConfig _config;

  String resolveDeviceId() {
    final stored = _storage.getString(_keys.deviceId);
    if (stored != null && stored.isNotEmpty) {
      return stored;
    }
    final created = _ids.nextId();
    _storage.setString(_keys.deviceId, created);
    return created;
  }

  SessionState resolveSession() {
    final now = _clock.nowMillis();
    final deviceId = resolveDeviceId();
    final stored = _storage.getString(_keys.session);
    final decoded =
        stored == null ? null : decodeStoredJsonMap(stored, _logger);
    final current = decoded == null ? null : _trySessionFromJson(decoded);
    if (current == null) {
      final created = SessionState(
        sessionId: _ids.nextId(),
        startTime: now,
        lastActivityTime: now,
        deviceId: deviceId,
      );
      _storeSession(created);
      return created;
    }
    final idleMs = now - current.lastActivityTime;
    final durationMs = now - current.startTime;
    final shouldRotate =
        idleMs > _config.idleTimeout.inMilliseconds ||
        durationMs > _config.maxDuration.inMilliseconds;
    if (!shouldRotate) {
      return current;
    }
    final rotated = SessionState(
      sessionId: _ids.nextId(),
      startTime: now,
      lastActivityTime: now,
      deviceId: deviceId,
    );
    _storeSession(rotated);
    return rotated;
  }

  SessionState touchSession(SessionState session, int now) {
    final updated = session.copyWith(lastActivityTime: now);
    _storeSession(updated);
    return updated;
  }

  ProfileState resolveProfile() {
    final stored = _storage.getString(_keys.profile);
    final decoded =
        stored == null ? null : decodeStoredJsonMap(stored, _logger);
    final current = decoded == null ? null : _tryProfileFromJson(decoded);
    final profile =
        current ??
        ProfileState(
          anonymousId: 'anon-${_ids.nextId()}',
          externalId: _storage.getString(_keys.externalId),
        );
    if (profile.externalId?.startsWith(reservedDistinctIdPrefix) ?? false) {
      return _discardReservedExternalId(profile);
    }
    if (current == null) {
      _storeProfile(profile);
    }
    return profile;
  }

  void linkExternalId(ProfileState profile, String externalId) {
    _storeProfile(profile.copyWith(externalId: externalId));
    _storage.setString(_keys.externalId, externalId);
  }

  /// Starts a new session, preserving device identity.
  void rotateSession() {
    final now = _clock.nowMillis();
    final deviceId = resolveDeviceId();
    _storeSession(
      SessionState(
        sessionId: _ids.nextId(),
        startTime: now,
        lastActivityTime: now,
        deviceId: deviceId,
      ),
    );
  }

  /// Rotates session and device identity and clears profile identity.
  void reset() {
    final now = _clock.nowMillis();
    final deviceId = _rotateDeviceId();
    final profile = ProfileState(anonymousId: 'anon-${_ids.nextId()}');
    final session = SessionState(
      sessionId: _ids.nextId(),
      startTime: now,
      lastActivityTime: now,
      deviceId: deviceId,
    );
    _storeProfile(profile);
    _storeSession(session);
    _storage.remove(_keys.externalId);
  }

  void clear() {
    _storage.remove(_keys.session);
    _storage.remove(_keys.profile);
    _storage.remove(_keys.deviceId);
    _storage.remove(_keys.externalId);
  }

  // A device can carry the prefix from an identify the server accepted before
  // reserving it. As the distinct_id, it gets every batch rejected as
  // invalid_argument, which the dispatcher drops as permanent.
  ProfileState _discardReservedExternalId(ProfileState profile) {
    _logger.warn(
      'Pug stored external ID uses the reserved "$reservedDistinctIdPrefix" '
      'prefix, discarding it. The user is treated as anonymous until '
      'identify() is called again.',
    );
    final healed = ProfileState(anonymousId: profile.anonymousId);
    _storeProfile(healed);
    _storage.remove(_keys.externalId);
    return healed;
  }

  String _rotateDeviceId() {
    final deviceId = _ids.nextId();
    _storage.setString(_keys.deviceId, deviceId);
    return deviceId;
  }

  void _storeSession(SessionState session) {
    _storage.setString(_keys.session, jsonEncode(session.toJson()));
  }

  void _storeProfile(ProfileState profile) {
    _storage.setString(_keys.profile, jsonEncode(profile.toJson()));
  }

  SessionState? _trySessionFromJson(Map<String, Object?> json) {
    try {
      return SessionState.fromJson(json);
    } catch (error, stackTrace) {
      _logger.warn('Pug stored session state could not be decoded.');
      _logger.debug(error.toString());
      _logger.debug(stackTrace.toString());
      return null;
    }
  }

  ProfileState? _tryProfileFromJson(Map<String, Object?> json) {
    try {
      return ProfileState.fromJson(json);
    } catch (error, stackTrace) {
      _logger.warn('Pug stored profile state could not be decoded.');
      _logger.debug(error.toString());
      _logger.debug(stackTrace.toString());
      return null;
    }
  }
}
