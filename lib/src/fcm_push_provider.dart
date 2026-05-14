import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import 'contracts.dart';
import 'push_models.dart';

typedef FcmTokenGetter = Future<String?> Function();
typedef FcmTokenDeleter = Future<void> Function();

class FcmPushProvider implements PushProvider {
  FcmPushProvider({
    FirebaseMessaging? messaging,
    FcmTokenGetter? getToken,
    FcmTokenDeleter? deleteToken,
    TargetPlatform? targetPlatform,
    PugLogger logger = const DebugPrintPugLogger(),
  }) : _messaging = messaging,
       _getToken = getToken,
       _deleteToken = deleteToken,
       _logger = SafePugLogger(logger),
       platform = _platformName(targetPlatform ?? defaultTargetPlatform);

  final FirebaseMessaging? _messaging;
  final FcmTokenGetter? _getToken;
  final FcmTokenDeleter? _deleteToken;
  final PugLogger _logger;

  @override
  final String platform;

  @override
  String get provider => 'fcm';

  Future<NotificationSettings> requestPermission({
    bool alert = true,
    bool announcement = false,
    bool badge = true,
    bool carPlay = false,
    bool criticalAlert = false,
    bool provisional = false,
    bool sound = true,
  }) async {
    try {
      return await _firebaseMessaging.requestPermission(
        alert: alert,
        announcement: announcement,
        badge: badge,
        carPlay: carPlay,
        criticalAlert: criticalAlert,
        provisional: provisional,
        sound: sound,
      );
    } catch (error, stackTrace) {
      _logger.error(
        'Pug FCM permission request failed.',
        error,
        stackTrace,
      );
      return _unavailableNotificationSettings;
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final token = await (_getToken?.call() ?? _firebaseMessaging.getToken());
      return token ?? '';
    } catch (error, stackTrace) {
      _logger.error('Pug FCM token lookup failed.', error, stackTrace);
      return '';
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await (_deleteToken?.call() ?? _firebaseMessaging.deleteToken());
    } catch (error, stackTrace) {
      _logger.error('Pug FCM token delete failed.', error, stackTrace);
    }
  }

  @override
  Map<Object?, Object?> notificationData(Object source) {
    if (source is RemoteMessage) {
      return _remoteMessageData(source);
    }
    if (source is Map<Object?, Object?>) {
      return source;
    }
    return const <Object?, Object?>{};
  }

  Map<Object?, Object?> _remoteMessageData(RemoteMessage message) {
    final data = <Object?, Object?>{};
    for (final entry in message.data.entries) {
      data[entry.key] = entry.value;
    }
    data['messageId'] = message.messageId;
    data['collapseKey'] = message.collapseKey;
    data['from'] = message.from;
    data['category'] = message.category;
    data['threadId'] = message.threadId;
    data['sentTime'] = message.sentTime;

    final notification = message.notification;
    if (notification != null) {
      data['title'] = notification.title;
      data['body'] = notification.body;
    }

    final android = notification?.android;
    if (android != null) {
      data['androidChannelId'] = android.channelId;
      data['androidClickAction'] = android.clickAction;
      data['androidTag'] = android.tag;
    }

    final apple = notification?.apple;
    if (apple != null) {
      data['appleSubtitle'] = apple.subtitle;
      data['appleBadge'] = apple.badge;
    }

    data.removeWhere((_, value) => value == null);
    return data;
  }

  static String _platformName(TargetPlatform platform) {
    return switch (platform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      _ => platform.name,
    };
  }

  FirebaseMessaging get _firebaseMessaging =>
      _messaging ?? FirebaseMessaging.instance;

  static const NotificationSettings _unavailableNotificationSettings =
      NotificationSettings(
        alert: AppleNotificationSetting.notSupported,
        announcement: AppleNotificationSetting.notSupported,
        authorizationStatus: AuthorizationStatus.denied,
        badge: AppleNotificationSetting.notSupported,
        carPlay: AppleNotificationSetting.notSupported,
        criticalAlert: AppleNotificationSetting.notSupported,
        lockScreen: AppleNotificationSetting.notSupported,
        notificationCenter: AppleNotificationSetting.notSupported,
        showPreviews: AppleShowPreviewSetting.notSupported,
        timeSensitive: AppleNotificationSetting.notSupported,
        sound: AppleNotificationSetting.notSupported,
      );
}
