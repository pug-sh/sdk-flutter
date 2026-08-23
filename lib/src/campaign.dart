import 'dart:async';

/// No concrete provider ships with the SDK. The `app_links` adapter was dropped
/// along with the dependency while campaign capture is off the public surface —
/// nothing could reach it, and every host app paid for its native plugin
/// registration. Re-enabling capture means supplying one here again.
abstract interface class PugLinkProvider {
  Future<Uri?> initialUri();
  Stream<Uri> get uriStream;
  void dispose();
}

Map<String, Object?> campaignPropertiesFromUri(Uri uri) {
  final params = <String, String>{};
  for (final entry in uri.queryParameters.entries) {
    params[entry.key.toLowerCase()] = entry.value;
  }

  final properties = <String, Object?>{};
  void add(String queryKey, String propertyKey) {
    final value = params[queryKey];
    if (value != null && value.trim().isNotEmpty) {
      properties[propertyKey] = value;
    }
  }

  add('utm_source', r'$utmSource');
  add('utm_medium', r'$utmMedium');
  add('utm_campaign', r'$utmCampaign');
  add('utm_term', r'$utmTerm');
  add('utm_content', r'$utmContent');
  add('gclid', r'$gclid');
  add('fbclid', r'$fbclid');
  add('msclkid', r'$msclkid');
  add('ttclid', r'$ttclid');

  return properties;
}
