import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'auto_properties.dart';
import 'campaign_tracker.dart';
import 'clock_ids.dart';
import 'configuration.dart';
import 'connect_transport.dart';
import 'contracts.dart';
import 'dispatcher.dart';
import 'event_queue_storage.dart';
import 'events.dart';
import 'identity.dart';
import 'install_tracker.dart';
import 'lifecycle.dart';
import 'navigation.dart';
import 'options_normalizer.dart';
import 'push_manager.dart';
import 'push_models.dart';
import 'route_observer.dart';
import 'state_storage.dart';
import 'tracking_consent.dart';
import 'version.dart';

class PugClient with WidgetsBindingObserver {
  PugClient({
    required this.projectId,
    required PugOptions options,
    PugClock? clock,
    PugIdGenerator? idGenerator,
    WidgetsBinding? lifecycleBinding,
  }) : _options = normalizePugOptions(options),
       _clock = clock ?? SystemPugClock(),
       _ids = idGenerator ?? UuidV7Generator(),
       _lifecycleBinding = lifecycleBinding,
       _autoPropertyProvider =
           options.autoPropertyProvider ?? SystemPugAutoPropertyProvider(),
       _keys = PugStorageKeys(projectId),
       _storage = SafePugStorage(
         primary: options.storage,
         fallback: MemoryPugStorage(),
         logger: SafePugLogger(options.logger),
       ) {
    if (_options.transport != null && _options.httpClient != null) {
      _options.logger.warn(
        'Pug ignores PugOptions.httpClient when a custom transport is set.',
      );
    }
    _transport =
        _options.transport ??
        ConnectPugTransport(
          endpoint: _options.endpoint,
          apiKey: _options.apiKey,
          httpClient: _options.httpClient,
        );
    _dispatcher = EventDispatcher(
      queue: PugEventQueue(
        key: _keys.queue,
        storage: _storage,
        logger: _options.logger,
        maxQueueSize: _options.batch.maxQueueSize,
      ),
      transport: _transport,
      logger: _options.logger,
      batch: _options.batch,
      dryRun: _options.dryRun,
      ownsTransport: _options.transport == null,
    );
    _consent = TrackingConsentController(
      keys: _keys,
      storage: _storage,
      logger: _options.logger,
      config: _options.trackingConsent,
    );
    _identity = PugIdentity(
      keys: _keys,
      storage: _storage,
      logger: _options.logger,
      clock: _clock,
      ids: _ids,
      config: _options.session,
    );
    _campaign = CampaignTracker(
      keys: _keys,
      storage: _storage,
      logger: _options.logger,
    );
    _push = PushManager(
      identity: _identity,
      transport: _transport,
      logger: _options.logger,
    );
    _navigation = NavigationTracker(
      autoPageViews: _options.autoPageViews,
      logger: _options.logger,
      capture: (kind, props) => track(kind, props: props),
    );
    _install = InstallTracker(
      enabled: _options.autoInstallEvents,
      keys: _keys,
      storage: _storage,
      logger: _options.logger,
      autoProperties: _autoPropertyProvider.properties,
      capture: (kind, props) {
        if (_disposed || !_consent.isGranted) {
          return false;
        }
        track(kind, props: props);
        return true;
      },
    );
    _lifecycle = AppLifecycleTracker(
      autoTrack: _options.autoTrack,
      capture: (kind, {required immediate}) {
        // Reported back so the tracker's foreground flag only advances when the
        // event was really captured: a consent-denied app_open would otherwise
        // leave an unpaired app_close behind once consent is granted.
        if (_disposed || !_consent.isGranted) {
          return false;
        }
        track(kind, options: TrackOptions(immediate: immediate));
        return true;
      },
      onBackground: () => unawaited(_dispatcher.flush()),
    );
  }

  /// [referrer] is reported by [PugRouteObserver] but not used: the tracker
  /// derives the previous route from its own last-known route, which is what
  /// the `$referrer` auto-property reflects.
  void notifyRouteChanged(String? url, String? referrer) {
    if (_disposed) {
      return;
    }
    _navigation.didChangeRoute(url);
  }

  final String projectId;
  final PugOptions _options;
  final PugClock _clock;
  final PugIdGenerator _ids;
  final WidgetsBinding? _lifecycleBinding;
  final PugAutoPropertyProvider _autoPropertyProvider;
  final PugStorageKeys _keys;
  final SafePugStorage _storage;
  late final PugTransport _transport;
  late final EventDispatcher _dispatcher;
  late final TrackingConsentController _consent;
  late final PugIdentity _identity;
  late final CampaignTracker _campaign;
  late final PushManager _push;
  late final NavigationTracker _navigation;
  late final InstallTracker _install;
  late final AppLifecycleTracker _lifecycle;
  bool _disposed = false;
  bool _started = false;
  bool _ownsStorage = false;

  /// The client that currently owns each storage namespace.
  ///
  /// `Pug.destroy()` detaches the singleton synchronously but tears down
  /// asynchronously, so a follow-up `init()` can start a replacement client on
  /// the same keys while the outgoing one is still awaiting its final flush.
  /// The purge in [destroy] consults this so it cannot delete the
  /// replacement's identity, consent, or queue state.
  static final Map<(String, Object), PugClient> _storageOwners =
      <(String, Object), PugClient>{};

  /// Keyed by store as well as project: two clients on the same project but
  /// different [PugStorage] instances share no namespace, and a null primary
  /// means this client's own memory fallback, which nothing else holds.
  (String, Object) get _storageOwnerKey => (
    projectId,
    _options.storage ?? _storage,
  );

  /// Exposed so `Pug.logger` can surface the configured logger to callers
  /// (notably `TrackNamespace`) post-init. Safe to call before `start()`.
  PugLogger get logger => _options.logger;

  @visibleForTesting
  PugEventQueue get queue => _dispatcher.queue;

  bool get isStarted => _started;

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
      final key = _storageOwnerKey;
      final previousOwner = _storageOwners[key];
      if (previousOwner != null && !identical(previousOwner, this)) {
        previousOwner._releaseStorage();
      }
      _storageOwners[key] = this;
      _ownsStorage = true;
      _started = true;
      // Campaign capture is built but not started: the backend does not accept
      // campaign data yet, so the tracker only purges stale state on destroy.
      // Re-enabling is `await _campaign.start()` here, the campaign properties
      // in _createEvent, and the barrel export of campaign.dart.
      // Before syncInitialState so a launch app_install/app_update precedes the
      // launch app_open, and before anything else here writes a project key:
      // the install branch's prior-state probe would otherwise see this
      // launch's own state and read a fresh install as an upgrade-in-place.
      _install.check();
      _lifecycle.syncInitialState(_lifecycleBinding?.lifecycleState);
      _dispatcher.scheduleFlush();
    } catch (error, stackTrace) {
      _options.logger.error('Pug start failed.', error, stackTrace);
    }
  }

  /// Called on the outgoing client when a replacement takes over the same
  /// namespace, which `Pug.destroy()`/`init()` can do while this client is
  /// still awaiting its final flush.
  void _releaseStorage() {
    _ownsStorage = false;
    _dispatcher.release();
  }

  void track(
    String kind, {
    Map<String, Object?> props = const {},
    TrackOptions options = const TrackOptions(),
  }) {
    try {
      if (_disposed || kind.trim().isEmpty) {
        return;
      }
      if (!_consent.isGranted) {
        _options.logger.debug(
          'Pug track("$kind") dropped because tracking consent is denied.',
        );
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
      _dispatcher.dispatch(event, immediate: options.immediate);
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
    if (externalId.startsWith(reservedDistinctIdPrefix)) {
      throw ArgumentError(
        'externalId must not start with the reserved '
        '"$reservedDistinctIdPrefix" prefix, which the server uses for '
        'cookieless identities',
      );
    }
    if (!_consent.isGranted) {
      _options.logger.debug(
        'Pug identify() dropped because tracking consent is denied.',
      );
      return;
    }
    final profile = _identity.resolveProfile();
    final firstIdentify = profile.externalId == null;
    final sanitizedTraits = PropertyMapper(
      logger: _options.logger,
    ).mapProperties(traits);
    await _transport.identify(
      IdentifyRequest(
        projectId: projectId,
        externalId: externalId,
        anonymousId: firstIdentify ? profile.anonymousId : null,
        deviceId: firstIdentify ? _identity.resolveDeviceId() : null,
        traits: sanitizedTraits,
      ),
    );
    if (_disposed) {
      return;
    }
    // reset() during the await replaced the profile, and destroy() purged it;
    // writing the captured one back would resurrect the identity the caller
    // just cleared, old anonymous id and all. The reset wins.
    if (_identity.resolveProfile().anonymousId != profile.anonymousId) {
      _options.logger.debug(
        'Pug identify() completed after a reset; identity left cleared.',
      );
      return;
    }
    _identity.linkExternalId(profile, externalId);
  }

  void reset() => _identity.reset();

  void rotate() => _identity.rotateSession();

  TrackingConsent get trackingConsent => _consent.status;

  bool get isTrackingEnabled => _consent.isGranted;

  void optInTracking() => _consent.optIn();

  void optOutTracking() => _consent.optOut();

  Future<void> flush() => _dispatcher.flush();

  Future<void> flushAll() => _dispatcher.flushAll();

  @internal
  Future<void> subscribePush(
    PushProvider provider, {
    PushSubscribeOptions options = const PushSubscribeOptions(),
  }) async {
    if (_disposed) {
      _options.logger.warn('Pug push subscribe skipped: client is destroyed.');
      return;
    }
    await _push.subscribe(provider, options: options);
  }

  @internal
  Future<void> unsubscribePush(PushProvider provider) =>
      _push.unsubscribe(provider);

  @internal
  void trackNotificationOpened(Map<Object?, Object?> data) =>
      _trackNotification('notification_clicked', data);

  @internal
  void trackNotificationReceived(Map<Object?, Object?> data) =>
      _trackNotification('notification_received', data);

  @internal
  void trackNotificationDismissed(Map<Object?, Object?> data) =>
      _trackNotification('notification_dismissed', data);

  void _trackNotification(String kind, Map<Object?, Object?> data) {
    // Notification callbacks often fire while backgrounded; send immediately so
    // the event is not stranded in the queue if the OS suspends the process.
    track(
      kind,
      props: notificationEventProperties(data),
      options: const TrackOptions(immediate: true),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) =>
      _lifecycle.handleStateChange(state);

  Future<void> destroy() async {
    if (_disposed) {
      return;
    }
    _dispatcher.cancelScheduledFlush();
    try {
      // Best-effort final flush so queued events get a real send attempt before
      // the storage purge below, rather than racing it.
      await _dispatcher.flushAll();
    } catch (error, stackTrace) {
      _options.logger.error(
        'Pug final flush during destroy failed.',
        error,
        stackTrace,
      );
    } finally {
      // Teardown must run even if the flush above throws, or the client would
      // leak its lifecycle observer, link subscription, and timers. It is
      // guarded in turn so a throwing host logger or storage cannot leave the
      // client half-destroyed.
      try {
        // Surface undelivered events so the loss is loud, not silent: the final
        // flush above already logged a misleading "will be retried" on a
        // transient failure, but the queue is about to be purged below.
        final ownsStorage = _ownsStorage;
        final undelivered = _dispatcher.pending;
        if (ownsStorage && undelivered > 0) {
          _options.logger.warn(
            'Pug.destroy discarded $undelivered undelivered event(s) that '
            'could not be flushed.',
          );
        }
        // Cancels a timer the final flush may have rescheduled on a transient
        // failure, then closes the queue and transport.
        _dispatcher.dispose(persistQueue: ownsStorage);
        _campaign.dispose();
        _lifecycleBinding?.removeObserver(this);
        // Only clear the shared route hook if it still points at this client; a
        // follow-up init() may have already rebound it to a new client, since
        // destroy() detaches the singleton synchronously and need not be
        // awaited.
        if (PugRouteObserver.onRouteChanged == notifyRouteChanged) {
          PugRouteObserver.onRouteChanged = null;
        }
        if (ownsStorage) {
          _storageOwners.remove(_storageOwnerKey);
          _identity.clear();
          _campaign.clear();
          _storage.remove(_keys.queue);
          _storage.remove(_keys.lastVersion);
        } else {
          _options.logger.debug(
            'Pug.destroy left the stored state for "$projectId" alone: this '
            'client does not own that storage namespace.',
          );
        }
        _navigation.clear();
      } catch (error, stackTrace) {
        _options.logger.error(
          'Pug destroy teardown failed.',
          error,
          stackTrace,
        );
      }
      _disposed = true;
    }
  }

  Event? _createEvent(
    String kind,
    Map<String, Object?> props,
    int? timestampMillis,
  ) {
    final session = _identity.resolveSession();
    final profile = _identity.resolveProfile();
    final mapper = PropertyMapper(logger: _options.logger);
    final customProperties = mapper.mapEventProperties(kind, props);
    if (customProperties == null) {
      return null;
    }
    final currentRoute = _navigation.url;
    final previousRoute = _navigation.referrer;
    final autoProperties = mapper.mapProperties({
      r'$projectId': projectId,
      r'$sdkVersion': pugSdkVersion,
      if (currentRoute != null) r'$url': currentRoute,
      if (previousRoute != null) r'$referrer': previousRoute,
      ..._autoPropertyProvider.properties(),
    });
    final now = _clock.nowMillis();
    final updatedSession = _identity.touchSession(session, now);
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
}
