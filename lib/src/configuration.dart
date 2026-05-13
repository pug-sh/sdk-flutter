import 'contracts.dart';

class PugOptions {
  const PugOptions({
    required this.apiKey,
    this.endpoint = 'http://localhost:8080',
    this.samplingRate = 1.0,
    this.batch = const BatchConfig(),
    this.session = const SessionConfig(),
    this.autoTrack = true,
    this.dryRun = false,
    this.logger = const NoopPugLogger(),
    this.storage,
    this.transport,
  });

  final String apiKey;
  final String endpoint;
  final double samplingRate;
  final BatchConfig batch;
  final SessionConfig session;
  final bool autoTrack;
  final bool dryRun;
  final PugLogger logger;
  final PugStorage? storage;
  final PugTransport? transport;
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
