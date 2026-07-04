import 'auto_properties.dart';
import 'campaign.dart';
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
    this.dryRun = false,
    this.autoCaptureCampaigns = true,
    this.trackingConsent = const TrackingConsentConfig(),
    this.logger = const NoopPugLogger(),
    this.storage,
    this.transport,
    this.autoPropertyProvider,
    this.linkProvider,
  });

  final String apiKey;
  final String endpoint;
  final BatchConfig batch;
  final SessionConfig session;
  final bool autoTrack;
  final bool autoPageViews;
  final bool dryRun;
  final bool autoCaptureCampaigns;
  final TrackingConsentConfig trackingConsent;
  final PugLogger logger;
  final PugStorage? storage;
  final PugTransport? transport;
  final PugAutoPropertyProvider? autoPropertyProvider;
  final PugLinkProvider? linkProvider;

  PugOptions copyWith({
    String? apiKey,
    String? endpoint,
    BatchConfig? batch,
    SessionConfig? session,
    bool? autoTrack,
    bool? autoPageViews,
    bool? dryRun,
    bool? autoCaptureCampaigns,
    TrackingConsentConfig? trackingConsent,
    PugLogger? logger,
    PugStorage? storage,
    PugTransport? transport,
    PugAutoPropertyProvider? autoPropertyProvider,
    PugLinkProvider? linkProvider,
  }) {
    return PugOptions(
      apiKey: apiKey ?? this.apiKey,
      endpoint: endpoint ?? this.endpoint,
      batch: batch ?? this.batch,
      session: session ?? this.session,
      autoTrack: autoTrack ?? this.autoTrack,
      autoPageViews: autoPageViews ?? this.autoPageViews,
      dryRun: dryRun ?? this.dryRun,
      autoCaptureCampaigns: autoCaptureCampaigns ?? this.autoCaptureCampaigns,
      trackingConsent: trackingConsent ?? this.trackingConsent,
      logger: logger ?? this.logger,
      storage: storage ?? this.storage,
      transport: transport ?? this.transport,
      autoPropertyProvider: autoPropertyProvider ?? this.autoPropertyProvider,
      linkProvider: linkProvider ?? this.linkProvider,
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
