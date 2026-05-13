class PushSubscription {
  const PushSubscription({
    required this.provider,
    required this.platform,
    required this.token,
    required this.deviceId,
    this.profileId,
    this.profileExternalId,
    this.properties = const {},
  });

  final String provider;
  final String platform;
  final String token;
  final String deviceId;
  final String? profileId;
  final String? profileExternalId;
  final Map<String, Object?> properties;
}

abstract interface class PushProvider {
  String get provider;
  String get platform;
  Future<String> getToken();
  Future<void> deleteToken();
  Map<Object?, Object?> notificationData(Object source);
}

class PushSubscribeOptions {
  const PushSubscribeOptions({
    this.profileId,
    this.profileExternalId,
    this.properties = const {},
  });

  final String? profileId;
  final String? profileExternalId;
  final Map<String, Object?> properties;
}

Map<String, Object?> sanitizeNotificationData(Map<Object?, Object?> data) {
  final sanitized = <String, Object?>{};
  for (final entry in data.entries) {
    final key = entry.key?.toString();
    final value = entry.value;
    if (key == null || value == null) {
      continue;
    }
    if (value is String || value is bool || value is int) {
      sanitized[key] = value;
    } else if (value is double && value.isFinite) {
      sanitized[key] = value;
    } else if (value is DateTime) {
      sanitized[key] = value.toUtc().millisecondsSinceEpoch;
    }
  }
  return sanitized;
}
