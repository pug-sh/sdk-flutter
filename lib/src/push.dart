import 'errors.dart';
import 'pug.dart';
import 'push_models.dart';

export 'push_models.dart';

class PugPush {
  PugPush._();

  static Future<void> subscribe(
    PushProvider provider, {
    PushSubscribeOptions options = const PushSubscribeOptions(),
  }) async {
    final client = Pug.shared.clientOrNull;
    if (client == null) {
      throw const PugException('Pug has not been initialized.');
    }
    await client.subscribePush(provider, options: options);
  }

  static Future<void> unsubscribe(PushProvider provider) async {
    final client = Pug.shared.clientOrNull;
    if (client == null) {
      throw const PugException('Pug has not been initialized.');
    }
    await client.unsubscribePush(provider);
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
