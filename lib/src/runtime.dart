import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';

import 'auto_properties.dart';
import 'campaign.dart';
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

class PugRouteObserver extends NavigatorObserver {
  static void Function(String?, String?)? onRouteChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _onRouteChanged(_routeName(route), _routeName(previousRoute));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _onRouteChanged(_routeName(previousRoute), _routeName(route));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _onRouteChanged(_routeName(newRoute), _routeName(oldRoute));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _onRouteChanged(_routeName(previousRoute), null);
  }

  void _onRouteChanged(String? url, String? referrer) {
    onRouteChanged?.call(url, referrer);
  }

  String? _routeName(Route<dynamic>? route) {
    if (route == null) {
      return null;
    }
    final settings = route.settings;
    final name = settings.name;
    if (name != null && name.isNotEmpty) {
      return name;
    }
    return route.runtimeType.toString();
  }
}

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
       _autoPropertyProvider =
           options.autoPropertyProvider ?? SystemPugAutoPropertyProvider(),
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

  static void Function(String?, String?)? onRouteChanged;

  void notifyRouteChanged(String? url, String? referrer) {
    if (!_options.autoPageViews || _disposed) {
      return;
    }
    if (url == _currentRoute) {
      return;
    }
    _previousRoute = _currentRoute;
    _currentRoute = url;
    track(
      'page_view',
      props: {
        if (url != null) 'url': url,
        if (_previousRoute != null) 'referrer': _previousRoute,
      },
    );
  }

  final String projectId;
  final PugOptions _options;
  final PugClock _clock;
  final PugIdGenerator _ids;
  final WidgetsBinding? _lifecycleBinding;
  final PugAutoPropertyProvider _autoPropertyProvider;
  final SafePugStorage _storage;
  late final PugTransport _transport;
  late final PugEventQueue _queue;
  Timer? _flushTimer;
  StreamSubscription<Uri>? _linkSubscription;
  PugLinkProvider? _linkProvider;
  bool _isFlushing = false;
  bool _disposed = false;
  bool _isForeground = false;
  bool _started = false;
  final Random _sampling = Random();
  String? _currentRoute;
  String? _previousRoute;

  @visibleForTesting
  PugEventQueue get queue => _queue;

  bool get isStarted => _started;

  String get _sessionKey => '__pug_${projectId}_session__';
  String get _profileKey => '__pug_${projectId}_profile__';
  String get _deviceKey => '__pug_${projectId}_device_id__';
  String get _externalIdKey => '__pug_${projectId}_external_id__';
  String get _queueKey => '__pug_${projectId}_queue__';
  String get _campaignKey => '__pug_${projectId}_campaign__';

  Future<void> start() async {
    try {
      if (projectId.trim().isEmpty) {
        _options.logger.error('Pug start skipped: projectId is required.');
        return;
      }
      if (_options.apiKey.trim().isEmpty) {
        _options.logger.error('Pug start skipped: apiKey is required.');
        return;
      }
      _lifecycleBinding?.addObserver(this);
      _started = true;
      if (_options.autoCaptureCampaigns) {
        await _startCampaignCapture();
      }
      if (_options.autoTrack &&
          _lifecycleBinding?.lifecycleState == AppLifecycleState.resumed) {
        _isForeground = true;
        track('app_open');
      }
      _scheduleFlush();
    } catch (error, stackTrace) {
      _options.logger.error('Pug start failed.', error, stackTrace);
    }
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
      if (event == null) {
        return;
      }
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
      throw StateError('Pug client is destroyed');
    }
    if (externalId.trim().isEmpty) {
      throw ArgumentError('externalId is required');
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
        deviceId: _resolveDeviceId(),
        traits: sanitizedTraits,
      ),
    );
    _storeProfile(profile.copyWith(externalId: externalId));
    _storage.setString(_externalIdKey, externalId);
  }

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
    _storage.remove(_externalIdKey);
  }

  void rotate() {
    final now = _clock.nowMillis();
    final deviceId = _resolveDeviceId();
    _storeSession(
      SessionState(
        sessionId: _ids.nextId(),
        startTime: now,
        lastActivityTime: now,
        deviceId: deviceId,
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

  Future<void> flushAll() async {
    while (!_disposed && !_options.dryRun && _queue.size > 0) {
      final before = _queue.size;
      await flush();
      if (_queue.size >= before) {
        break;
      }
    }
  }

  Future<void> subscribePush(
    PushProvider provider, {
    PushSubscribeOptions options = const PushSubscribeOptions(),
  }) async {
    try {
      if (_disposed) {
        _options.logger.warn(
          'Pug push subscribe skipped: client is destroyed.',
        );
        return;
      }
      final deviceId = _resolveDeviceId();
      final profile = _resolveProfile();
      final token = await provider.getToken();
      if (token.trim().isEmpty) {
        _options.logger.warn('Pug push subscribe skipped: token unavailable.');
        return;
      }
      final properties = <String, Object?>{
        ...options.properties,
        'pushProvider': provider.provider,
      };
      await _transport.subscribeDevice(
        PushSubscription(
          provider: provider.provider,
          platform: provider.platform,
          token: token,
          deviceId: deviceId,
          profileExternalId: options.profileExternalId ?? profile.externalId,
          profileId: options.profileId,
          properties: properties,
        ),
      );
    } catch (error, stackTrace) {
      _options.logger.error('Pug push subscribe failed.', error, stackTrace);
    }
  }

  Future<void> unsubscribePush(PushProvider provider) async {
    try {
      await provider.deleteToken();
    } catch (error, stackTrace) {
      _options.logger.error('Pug push unsubscribe failed.', error, stackTrace);
    }
  }

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
    switch (state) {
      case AppLifecycleState.resumed:
        if (_options.autoTrack && !_isForeground) {
          _isForeground = true;
          track('app_open');
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_options.autoTrack && _isForeground) {
          _isForeground = false;
          track('app_close', options: const TrackOptions(immediate: true));
        }
        unawaited(flush());
    }
  }

  void destroy() {
    _flushTimer?.cancel();
    unawaited(flushAll());
    _queue.dispose();
    unawaited(_linkSubscription?.cancel());
    _linkProvider?.dispose();
    _lifecycleBinding?.removeObserver(this);
    _currentRoute = null;
    _previousRoute = null;
    _disposed = true;
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
    } catch (error, stackTrace) {
      _options.logger.warn(
        'Pug immediate event send failed; event will be retried.',
      );
      _options.logger.debug(error.toString());
      _options.logger.debug(stackTrace.toString());
      _queue.push(event);
      _scheduleFlush(withBackoff: true);
    }
  }

  Event? _createEvent(
    String kind,
    Map<String, Object?> props,
    int? timestampMillis,
  ) {
    final session = _resolveSession();
    final profile = _resolveProfile();
    final mapper = PropertyMapper(logger: _options.logger);
    final customProperties = mapper.mapEventProperties(kind, props);
    if (customProperties == null) {
      return null;
    }
    final autoProperties = mapper.mapProperties({
      r'$projectId': projectId,
      r'$sdkVersion': pugSdkVersion,
      ..._autoPropertyProvider.properties(),
      ..._storedCampaignProperties(),
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
    final deviceId = _resolveDeviceId();
    final stored = _storage.getString(_sessionKey);
    final decoded = stored == null ? null : _tryDecode(stored, _options.logger);
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
        idleMs > _options.session.idleTimeout.inMilliseconds ||
        durationMs > _options.session.maxDuration.inMilliseconds;
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

  String _resolveDeviceId() {
    final stored = _storage.getString(_deviceKey);
    if (stored != null && stored.isNotEmpty) {
      return stored;
    }
    final created = _ids.nextId();
    _storage.setString(_deviceKey, created);
    return created;
  }

  String _rotateDeviceId() {
    final deviceId = _ids.nextId();
    _storage.setString(_deviceKey, deviceId);
    return deviceId;
  }

  ProfileState _resolveProfile() {
    final stored = _storage.getString(_profileKey);
    final decoded = stored == null ? null : _tryDecode(stored, _options.logger);
    final current = decoded == null ? null : _tryProfileFromJson(decoded);
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

  SessionState? _trySessionFromJson(Map<String, Object?> json) {
    try {
      return SessionState.fromJson(json);
    } catch (error, stackTrace) {
      _options.logger.warn('Pug stored session state could not be decoded.');
      _options.logger.debug(error.toString());
      _options.logger.debug(stackTrace.toString());
      return null;
    }
  }

  ProfileState? _tryProfileFromJson(Map<String, Object?> json) {
    try {
      return ProfileState.fromJson(json);
    } catch (error, stackTrace) {
      _options.logger.warn('Pug stored profile state could not be decoded.');
      _options.logger.debug(error.toString());
      _options.logger.debug(stackTrace.toString());
      return null;
    }
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

  Future<void> _startCampaignCapture() async {
    if (!_options.autoCaptureCampaigns) {
      return;
    }
    final provider = _options.linkProvider ?? AppLinksPugLinkProvider();
    _linkProvider = provider;

    try {
      final initial = await provider.initialUri();
      if (initial != null) {
        _captureCampaign(initial);
      }
    } catch (error, stackTrace) {
      _options.logger.warn('Pug could not read initial campaign link.');
      _options.logger.debug(error.toString());
      _options.logger.debug(stackTrace.toString());
    }

    try {
      _linkSubscription = provider.uriStream.listen(
        _captureCampaign,
        onError: (Object error, StackTrace? stackTrace) {
          _options.logger.warn('Pug campaign link stream failed.');
          _options.logger.debug(error.toString());
          if (stackTrace != null) {
            _options.logger.debug(stackTrace.toString());
          }
        },
      );
    } catch (error, stackTrace) {
      _options.logger.warn('Pug could not listen for campaign links.');
      _options.logger.debug(error.toString());
      _options.logger.debug(stackTrace.toString());
    }
  }

  void _captureCampaign(Uri uri) {
    final properties = campaignPropertiesFromUri(uri);
    if (properties.isEmpty) {
      return;
    }
    _storage.setString(_campaignKey, jsonEncode(properties));
  }

  Map<String, Object?> _storedCampaignProperties() {
    final raw = _storage.getString(_campaignKey);
    final decoded = raw == null ? null : _tryDecode(raw, _options.logger);
    if (decoded == null) {
      return const {};
    }
    final properties = <String, Object?>{};
    for (final entry in decoded.entries) {
      if (entry.key.startsWith(r'$')) {
        properties[entry.key] = entry.value;
      }
    }
    return properties;
  }

  void _scheduleFlush({bool withBackoff = false}) {
    if (_disposed) {
      return;
    }
    _flushTimer?.cancel();
    final wait =
        withBackoff
            ? Duration(milliseconds: max(_options.batch.maxWaitMs, 1000) * 2)
            : Duration(milliseconds: _options.batch.maxWaitMs);
    _flushTimer = Timer(wait, () => unawaited(flush()));
  }
}

PugOptions _normalizeOptions(PugOptions options) {
  final logger = SafePugLogger(options.logger);
  final samplingRate = options.samplingRate.clamp(0.0, 1.0);
  if (samplingRate != options.samplingRate) {
    logger.warn('samplingRate must be between 0 and 1; clamping.');
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
    autoPageViews: options.autoPageViews,
    dryRun: options.dryRun,
    autoCaptureCampaigns: options.autoCaptureCampaigns,
    logger: logger,
    storage: options.storage,
    transport: options.transport,
    autoPropertyProvider: options.autoPropertyProvider,
    linkProvider: options.linkProvider,
  );
}

Map<String, Object?>? _tryDecode(String raw, PugLogger logger) {
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
