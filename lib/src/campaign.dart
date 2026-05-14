import 'dart:async';

import 'package:app_links/app_links.dart';

abstract interface class PugLinkProvider {
  Future<Uri?> initialUri();
  Stream<Uri> get uriStream;
  void dispose();
}

class AppLinksPugLinkProvider implements PugLinkProvider {
  AppLinksPugLinkProvider({AppLinks? appLinks})
    : _appLinks = appLinks ?? AppLinks();

  final AppLinks _appLinks;

  @override
  Future<Uri?> initialUri() => _appLinks.getInitialAppLink();

  @override
  Stream<Uri> get uriStream => _appLinks.uriLinkStream;

  @override
  void dispose() {}
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
