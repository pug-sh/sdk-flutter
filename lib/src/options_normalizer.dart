import 'dart:math';

import 'configuration.dart';
import 'contracts.dart';

/// Clamps caller-supplied options to values the runtime can work with and wraps
/// the logger so a throwing host logger cannot break the SDK.
PugOptions normalizePugOptions(PugOptions options) {
  return PugOptions(
    apiKey: options.apiKey,
    endpoint: options.endpoint,
    batch: BatchConfig(
      maxSize: max(options.batch.maxSize, 1),
      maxWaitMs: max(options.batch.maxWaitMs, 0),
      maxQueueSize: max(options.batch.maxQueueSize, 1),
    ),
    session: options.session,
    autoTrack: options.autoTrack,
    autoPageViews: options.autoPageViews,
    autoInstallEvents: options.autoInstallEvents,
    dryRun: options.dryRun,
    trackingConsent: options.trackingConsent,
    logger: SafePugLogger(options.logger),
    storage: options.storage,
    transport: options.transport,
    httpClient: options.httpClient,
    autoPropertyProvider: options.autoPropertyProvider,
  );
}
