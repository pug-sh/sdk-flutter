import 'contracts.dart';

/// The browser's `$os`/`$osVersion`. Off the web there is no browser to ask;
/// `user_agent_data_web.dart` replaces this file there through a conditional
/// import.
Future<Map<String, Object?>> userAgentDataProperties({
  PugLogger? logger,
}) async => const {};
