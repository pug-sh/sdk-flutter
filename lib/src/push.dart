import 'contracts.dart';
import 'pug.dart';
import 'push_models.dart';

export 'push_models.dart';

class PugPush {
  PugPush._();

  static const PugLogger _fallbackLogger = SafePugLogger(
    DebugPrintPugLogger(),
  );

  static Future<void> subscribe(
    PushProvider provider, {
    PushSubscribeOptions options = const PushSubscribeOptions(),
  }) async {
    try {
      await Pug.shared.clientOrNull?.subscribePush(provider, options: options);
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug push subscribe failed.', error, stackTrace);
    }
  }

  static Future<void> unsubscribe(PushProvider provider) async {
    try {
      await Pug.shared.clientOrNull?.unsubscribePush(provider);
    } catch (error, stackTrace) {
      _fallbackLogger.error('Pug push unsubscribe failed.', error, stackTrace);
    }
  }

  static void trackNotificationOpened(Map<Object?, Object?> data) {
    Pug.shared.clientOrNull?.trackNotificationOpened(data);
  }

  static void trackNotificationReceived(Map<Object?, Object?> data) {
    Pug.shared.clientOrNull?.trackNotificationReceived(data);
  }

  static void trackNotificationDismissed(Map<Object?, Object?> data) {
    Pug.shared.clientOrNull?.trackNotificationDismissed(data);
  }
}
