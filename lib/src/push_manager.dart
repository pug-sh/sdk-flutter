import 'contracts.dart';
import 'identity.dart';
import 'push_models.dart';

/// Registers and deregisters push tokens for the current device/profile.
class PushManager {
  PushManager({
    required PugIdentity identity,
    required PugTransport transport,
    required PugLogger logger,
  }) : _identity = identity,
       _device =
           transport is PugDeviceTransport
               ? transport as PugDeviceTransport
               : null,
       _logger = logger;

  final PugIdentity _identity;
  final PugDeviceTransport? _device;
  final PugLogger _logger;

  Future<void> subscribe(
    PushProvider provider, {
    PushSubscribeOptions options = const PushSubscribeOptions(),
  }) async {
    final device = _device;
    if (device == null) {
      _logger.warn(
        'Pug push subscribe skipped: this transport does not implement device '
        'registration.',
      );
      return;
    }
    try {
      final deviceId = _identity.resolveDeviceId();
      final profile = _identity.resolveProfile();
      final token = await provider.getToken();
      if (token.trim().isEmpty) {
        _logger.warn('Pug push subscribe skipped: token unavailable.');
        return;
      }
      await device.subscribeDevice(
        PushSubscription(
          provider: provider.provider,
          platform: provider.platform,
          token: token,
          deviceId: deviceId,
          profileExternalId: options.profileExternalId ?? profile.externalId,
          profileId: options.profileId,
          properties: <String, Object?>{
            ...options.properties,
            'pushProvider': provider.provider,
          },
        ),
      );
    } catch (error, stackTrace) {
      _logger.error('Pug push subscribe failed.', error, stackTrace);
    }
  }

  Future<void> unsubscribe(PushProvider provider) async {
    try {
      await provider.deleteToken();
    } catch (error, stackTrace) {
      _logger.error('Pug push unsubscribe failed.', error, stackTrace);
    }
  }
}

/// Sanitizes a notification payload and guarantees a usable `campaignId`.
///
/// The notification_* schemas mark `campaign_id` as required (buf.validate
/// `required`), so an event that omits it is expected to be rejected
/// server-side — and a permanent rejection drops the event (see the transport
/// notes on permanent failures). To stay safe we always send a value: like
/// the web SDK, a missing, empty, or non-string `campaignId` becomes
/// "(unknown)".
Map<String, Object?> notificationEventProperties(Map<Object?, Object?> data) {
  final props = sanitizeNotificationData(data);
  final campaignId = props['campaignId'];
  if (campaignId is! String || campaignId.isEmpty) {
    props['campaignId'] = '(unknown)';
  }
  return props;
}
