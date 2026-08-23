import 'auto_properties.dart';
import 'contracts.dart';
import 'tracking_consent.dart';

class PugOptions {
  const PugOptions({
    required this.apiKey,
    this.endpoint = 'https://api.pugs.dev',
    this.batch = const BatchConfig(),
    this.session = const SessionConfig(),
    this.autoTrack = true,
    this.autoPageViews = true,
    this.autoInstallEvents = true,
    this.dryRun = false,
    this.trackingConsent = const TrackingConsentConfig(),
    this.logger = const NoopPugLogger(),
    this.storage,
    this.transport,
    this.autoPropertyProvider,
  });

  final String apiKey;
  final String endpoint;
  final BatchConfig batch;
  final SessionConfig session;
  final bool autoTrack;
  final bool autoPageViews;

  /// Emits `app_install` on the first launch the SDK sees on a device and
  /// `app_update` on the first launch after the app version changes.
  ///
  /// Independent of [autoTrack], like [autoPageViews]: it is a one-shot check
  /// at start, not a lifecycle subscription.
  final bool autoInstallEvents;
  final bool dryRun;
  final TrackingConsentConfig trackingConsent;
  final PugLogger logger;
  final PugStorage? storage;
  final PugTransport? transport;
  final PugAutoPropertyProvider? autoPropertyProvider;

  PugOptions copyWith({
    String? apiKey,
    String? endpoint,
    BatchConfig? batch,
    SessionConfig? session,
    bool? autoTrack,
    bool? autoPageViews,
    bool? autoInstallEvents,
    bool? dryRun,
    TrackingConsentConfig? trackingConsent,
    PugLogger? logger,
    PugStorage? storage,
    PugTransport? transport,
    PugAutoPropertyProvider? autoPropertyProvider,
  }) {
    return PugOptions(
      apiKey: apiKey ?? this.apiKey,
      endpoint: endpoint ?? this.endpoint,
      batch: batch ?? this.batch,
      session: session ?? this.session,
      autoTrack: autoTrack ?? this.autoTrack,
      autoPageViews: autoPageViews ?? this.autoPageViews,
      autoInstallEvents: autoInstallEvents ?? this.autoInstallEvents,
      dryRun: dryRun ?? this.dryRun,
      trackingConsent: trackingConsent ?? this.trackingConsent,
      logger: logger ?? this.logger,
      storage: storage ?? this.storage,
      transport: transport ?? this.transport,
      autoPropertyProvider: autoPropertyProvider ?? this.autoPropertyProvider,
    );
  }
}

class BatchConfig {
  const BatchConfig({
    this.maxSize = 10,
    this.maxWaitMs = 5000,
    this.maxQueueSize = 1000,
  });

  final int maxSize;
  final int maxWaitMs;
  final int maxQueueSize;
}

class SessionConfig {
  const SessionConfig({
    this.idleTimeout = const Duration(minutes: 30),
    this.maxDuration = const Duration(minutes: 1440),
  });

  final Duration idleTimeout;
  final Duration maxDuration;
}

class TrackOptions {
  const TrackOptions({this.immediate = false, this.timestampMillis});

  final bool immediate;
  final int? timestampMillis;
}
