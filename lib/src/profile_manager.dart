class ProfileState {
  const ProfileState({required this.anonymousId, this.externalId});

  final String anonymousId;
  final String? externalId;

  ProfileState copyWith({String? externalId}) {
    return ProfileState(
      anonymousId: anonymousId,
      externalId: externalId ?? this.externalId,
    );
  }

  Map<String, Object?> toJson() => {
    'anonymousId': anonymousId,
    if (externalId != null) 'externalId': externalId,
  };

  static ProfileState? fromJson(Map<String, Object?> json) {
    return ProfileState(
      anonymousId: json['anonymousId']! as String,
      externalId: json['externalId'] as String?,
    );
  }
}
