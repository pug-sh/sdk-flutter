import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'clock_ids.dart';
import 'configuration.dart';
import 'contracts.dart';
import 'errors.dart';
import 'event_queue_storage.dart';
import 'events.dart';
import 'http_transport.dart';
import 'profile_manager.dart';
import 'push_models.dart';
import 'session_manager.dart';
import 'version.dart';

class PugClient with WidgetsBindingObserver {
  PugClient({
    required this.projectId,
    required PugOptions options,
    PugClock? clock,
    PugIdGenerator? idGenerator,
    WidgetsBinding? lifecycleBinding,
  }) : _options = _normalizeOptions(options),
       _clock = clock ?? SystemPugClock(),
       _ids = idGenerator ?? UuidV7Generator(),
       _lifecycleBinding = lifecycleBinding,
       _storage = SafePugStorage(
         primary: options.storage,
         fallback: MemoryPugStorage(),
         logger: options.logger,
       ) {
    _transport =
        _options.transport ??
        HttpPugTransport(endpoint: _options.endpoint, apiKey: _options.apiKey);
    _queue = PugEventQueue(
      key: _queueKey,
      storage: _storage,
      logger: _options.logger,
      maxQueueSize: _options.batch.maxQueueSize,
    );
  }

  final String projectId;
  final PugOptions _options;
  final PugClock _clock;
  final PugIdGenerator _ids;
  final WidgetsBinding? _lifecycleBinding;
  final SafePugStorage _storage;
  late final PugTransport _transport;
  late final PugEventQueue _queue;
  Timer? _flushTimer;
  bool _isFlushing = false;
  bool _disposed = false;
  bool _isForeground = false;
  final Random _sampling = Random();

  @visibleForTesting
  PugEventQueue get queue => _queue;

  String get _sessionKey => '__pug_${projectId}_session__';
  String get _profileKey => '__pug_${projectId}_profile__';
  String get _externalIdKey => '__pug_${projectId}_external_id__';
  String get _queueKey => '__pug_${projectId}_queue__';

  void start() {
    if (projectId.trim().isEmpty) {
      throw const PugException('projectId is required.');
    }
    if (_options.apiKey.trim().isEmpty) {
      throw const PugException('apiKey is required.');
    }
    _lifecycleBinding?.addObserver(this);
    _scheduleFlush();
  }

  void track(
    String kind, {
    Map<String, Object?> props = const {},
    TrackOptions options = const TrackOptions(),
  }) {
    try {
      if (_disposed || kind.trim().isEmpty || !_sampledIn()) {
        return;
      }
      final event = _createEvent(kind, props, options.timestampMillis);
      if (_options.dryRun) {
        _options.logger.debug('Pug dry run: event ${event.kind} accepted.');
        return;
      }
      if (options.immediate) {
        unawaited(_sendImmediateOrQueue(event));
      } else {
        _queue.push(event);
        if (_queue.size >= _options.batch.maxSize) {
          unawaited(flush());
        } else {
          _scheduleFlush();
        }
      }
    } catch (error, stackTrace) {
      _options.logger.error('Pug track failed.', error, stackTrace);
    }
  }

  Future<void> identify(
    String externalId, {
    Map<String, Object?> traits = const {},
  }) async {
    if (_disposed) {
      throw const PugException('Pug has been destroyed.');
    }
    if (externalId.trim().isEmpty) {
      throw const PugException('externalId is required.');
    }
    final profile = _resolveProfile();
    final sanitizedTraits = PropertyMapper(
      logger: _options.logger,
    ).mapProperties(traits);
    await _transport.identify(
      IdentifyRequest(
        projectId: projectId,
        externalId: externalId,
        anonymousId: profile.externalId == null ? profile.anonymousId : null,
        deviceId: _resolveSession().deviceId,
        traits: sanitizedTraits,
      ),
    );
    _storeProfile(profile.copyWith(externalId: externalId));
    _storage.setString(_externalIdKey, externalId);
  }

  void reset() {
    final now = _clock.nowMillis();
    final profile = ProfileState(anonymousId: 'anon-${_ids.nextId()}');
    final session = SessionState(
      sessionId: _ids.nextId(),
      startTime: now,
      lastActivityTime: now,
      deviceId: _ids.nextId(),
    );
    _storeProfile(profile);
    _storeSession(session);
    _storage.remove(_externalIdKey);
  }

  void rotate() {
    final current = _resolveSession();
    final now = _clock.nowMillis();
    _storeSession(
      SessionState(
        sessionId: _ids.nextId(),
        startTime: now,
        lastActivityTime: now,
        deviceId: current.deviceId,
      ),
    );
  }

  Future<void> flush() async {
    if (_isFlushing || _disposed || _options.dryRun || _queue.size == 0) {
      return;
    }
    _isFlushing = true;
    try {
      final events = _queue.lock(_options.batch.maxSize);
      if (events.isEmpty) {
        return;
      }
      await _transport.sendBatch(events);
      _queue.commit();
    } on PugTransportException catch (error, stackTrace) {
      if (error.isPermanent) {
        _options.logger.error(
          'Pug dropped a permanently rejected batch.',
          error,
        );
        _queue.commit();
      } else {
        _options.logger.warn('Pug batch send failed; it will be retried.');
        _queue.rollback();
        _scheduleFlush(withBackoff: true);
      }
      if (error.stackTrace != null) {
        _options.logger.debug(error.stackTrace.toString());
      }
      _options.logger.debug(stackTrace.toString());
    } catch (error, stackTrace) {
      _options.logger.warn('Pug batch send failed; it will be retried.');
      _options.logger.debug(stackTrace.toString());
      _queue.rollback();
      _scheduleFlush(withBackoff: true);
    } finally {
      _isFlushing = false;
    }
  }

  Future<void> subscribePush(
    PushProvider provider, {
    PushSubscribeOptions options = const PushSubscribeOptions(),
  }) async {
    final session = _resolveSession();
    final profile = _resolveProfile();
    final token = await provider.getToken();
    final properties = <String, Object?>{
      ...options.properties,
      'pushProvider': provider.provider,
    };
    await _transport.subscribeDevice(
      PushSubscription(
        provider: provider.provider,
        platform: provider.platform,
        token: token,
        deviceId: session.deviceId,
        profileExternalId: options.profileExternalId ?? profile.externalId,
        profileId: options.profileId,
        properties: properties,
      ),
    );
  }

  Future<void> unsubscribePush(PushProvider provider) => provider.deleteToken();

  void trackNotificationOpened(Map<Object?, Object?> data) {
    final props = sanitizeNotificationData(data);
    props.putIfAbsent('campaignId', () => '(unknown)');
    track(
      'notification_clicked',
      props: props,
      options: const TrackOptions(immediate: true),
    );
  }

  void trackNotificationReceived(Map<Object?, Object?> data) {
    track('notification_received', props: sanitizeNotificationData(data));
  }

  void trackNotificationDismissed(Map<Object?, Object?> data) {
    track('notification_dismissed', props: sanitizeNotificationData(data));
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_options.autoTrack) {
      return;
    }
    switch (state) {
      case AppLifecycleState.resumed:
        if (!_isForeground) {
          _isForeground = true;
          track('app_open');
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_isForeground) {
          _isForeground = false;
          track('app_close', options: const TrackOptions(immediate: true));
          unawaited(flush());
        }
    }
  }

  void destroy() {
    _disposed = true;
    _flushTimer?.cancel();
    _queue.dispose();
    _lifecycleBinding?.removeObserver(this);
  }

  Future<void> _sendImmediateOrQueue(Event event) async {
    try {
      await _transport.send(event);
    } on PugTransportException catch (error) {
      if (error.isPermanent) {
        _options.logger.error(
          'Pug dropped a permanently rejected event.',
          error,
        );
      } else {
        _queue.push(event);
        _scheduleFlush(withBackoff: true);
      }
    } catch (_) {
      _queue.push(event);
      _scheduleFlush(withBackoff: true);
    }
  }

  Event _createEvent(
    String kind,
    Map<String, Object?> props,
    int? timestampMillis,
  ) {
    final session = _resolveSession();
    final profile = _resolveProfile();
    final mapper = PropertyMapper(logger: _options.logger);
    final customProperties = mapper.mapProperties(props);
    final autoProperties = mapper.mapProperties({
      r'$projectId': projectId,
      r'$sdkVersion': pugSdkVersion,
      r'$platform': defaultTargetPlatform.name,
      r'$os': Platform.operatingSystem,
      r'$osVersion': Platform.operatingSystemVersion,
      r'$locale': PlatformDispatcher.instance.locale.toLanguageTag(),
      r'$timezone': DateTime.now().timeZoneName,
    });
    final now = _clock.nowMillis();
    final updatedSession = session.copyWith(lastActivityTime: now);
    _storeSession(updatedSession);
    return Event(
      eventId: _ids.nextId(),
      projectId: projectId,
      kind: kind,
      sessionId: updatedSession.sessionId,
      distinctId: profile.externalId ?? profile.anonymousId,
      occurTime: timestampMillis ?? now,
      customProperties: customProperties,
      autoProperties: autoProperties,
    );
  }

  SessionState _resolveSession() {
    final now = _clock.nowMillis();
    final stored = _storage.getString(_sessionKey);
    final decoded = stored == null ? null : _tryDecode(stored);
    final current = decoded == null ? null : SessionState.fromJson(decoded);
    if (current == null) {
      final created = SessionState(
        sessionId: _ids.nextId(),
        startTime: now,
        lastActivityTime: now,
        deviceId: _ids.nextId(),
      );
      _storeSession(created);
      return created;
    }
    final idleMs = now - current.lastActivityTime;
    final durationMs = now - current.startTime;
    final shouldRotate =
        idleMs > _options.session.idleTimeout.inMilliseconds ||
        durationMs > _options.session.maxDuration.inMilliseconds;
    if (!shouldRotate) {
      return current;
    }
    final rotated = SessionState(
      sessionId: _ids.nextId(),
      startTime: now,
      lastActivityTime: now,
      deviceId: current.deviceId,
    );
    _storeSession(rotated);
    return rotated;
  }

  ProfileState _resolveProfile() {
    final stored = _storage.getString(_profileKey);
    final decoded = stored == null ? null : _tryDecode(stored);
    final current = decoded == null ? null : ProfileState.fromJson(decoded);
    if (current != null) {
      return current;
    }
    final created = ProfileState(
      anonymousId: 'anon-${_ids.nextId()}',
      externalId: _storage.getString(_externalIdKey),
    );
    _storeProfile(created);
    return created;
  }

  void _storeSession(SessionState session) {
    _storage.setString(_sessionKey, jsonEncode(session.toJson()));
  }

  void _storeProfile(ProfileState profile) {
    _storage.setString(_profileKey, jsonEncode(profile.toJson()));
  }

  bool _sampledIn() {
    if (_options.samplingRate >= 1) {
      return true;
    }
    if (_options.samplingRate <= 0) {
      return false;
    }
    return _sampling.nextDouble() <= _options.samplingRate;
  }

  void _scheduleFlush({bool withBackoff = false}) {
    _flushTimer?.cancel();
    final wait = withBackoff
        ? Duration(milliseconds: max(_options.batch.maxWaitMs, 1000) * 2)
        : Duration(milliseconds: _options.batch.maxWaitMs);
    _flushTimer = Timer(wait, () => unawaited(flush()));
  }
}

PugOptions _normalizeOptions(PugOptions options) {
  final samplingRate = options.samplingRate.clamp(0.0, 1.0);
  if (samplingRate != options.samplingRate) {
    options.logger.warn('samplingRate must be between 0 and 1; clamping.');
  }
  return PugOptions(
    apiKey: options.apiKey,
    endpoint: options.endpoint,
    samplingRate: samplingRate,
    batch: BatchConfig(
      maxSize: max(options.batch.maxSize, 1),
      maxWaitMs: max(options.batch.maxWaitMs, 0),
      maxQueueSize: max(options.batch.maxQueueSize, 1),
    ),
    session: options.session,
    autoTrack: options.autoTrack,
    dryRun: options.dryRun,
    logger: options.logger,
    storage: options.storage,
    transport: options.transport,
  );
}

Map<String, Object?>? _tryDecode(String raw) {
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
  } catch (_) {
    return null;
  }
}
