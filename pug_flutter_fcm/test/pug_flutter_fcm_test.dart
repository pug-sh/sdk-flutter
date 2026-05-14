import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pug_flutter_fcm/pug_flutter_fcm.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'FCM provider supplies token and extracts remote message data',
    () async {
      var deleted = false;
      final provider = FcmPushProvider(
        getToken: () async => 'fcm-token',
        deleteToken: () async {
          deleted = true;
        },
        targetPlatform: TargetPlatform.android,
      );

      expect(provider.provider, 'fcm');
      expect(provider.platform, 'android');
      expect(await provider.getToken(), 'fcm-token');

      await provider.deleteToken();
      expect(deleted, isTrue);

      final data = provider.notificationData(
        const RemoteMessage(
          data: <String, String>{'campaignId': 'campaign-1'},
          messageId: 'message-1',
          notification: RemoteNotification(title: 'Title', body: 'Body'),
        ),
      );

      expect(data['campaignId'], 'campaign-1');
      expect(data['messageId'], 'message-1');
      expect(data['title'], 'Title');
      expect(data['body'], 'Body');
    },
  );

  test('FCM provider reports unavailable tokens', () async {
    final provider = FcmPushProvider(getToken: () async => null);

    await expectLater(provider.getToken(), completion(''));
  });
}
