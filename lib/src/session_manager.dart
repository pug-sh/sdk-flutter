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
    try {
      return SessionState(
        sessionId: json['sessionId']! as String,
        startTime: json['startTime']! as int,
        lastActivityTime: json['lastActivityTime']! as int,
        deviceId: json['deviceId']! as String,
      );
    } catch (_) {
      return null;
    }
  }
}
