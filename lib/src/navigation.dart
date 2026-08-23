import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

import 'contracts.dart';

/// Holds the current/previous route and emits the navigation event kind the
/// proto allows on the running platform.
///
/// Route state feeds the `$url`/`$referrer` auto-properties attached to every
/// event (matching the web SDK), so it is tracked even when [autoPageViews] is
/// disabled. Only the navigation event itself is gated; it carries no explicit
/// url/referrer props and relies on the auto-properties instead.
class NavigationTracker {
  NavigationTracker({
    required bool autoPageViews,
    required PugLogger logger,
    required void Function(String kind, Map<String, Object?> props) capture,
  }) : _autoPageViews = autoPageViews,
       _logger = logger,
       _capture = capture;

  final bool _autoPageViews;
  final PugLogger _logger;
  final void Function(String kind, Map<String, Object?> props) _capture;
  String? _currentRoute;
  String? _previousRoute;
  bool _warnedNoNavPlatform = false;

  String? get url => _currentRoute;

  String? get referrer => _previousRoute;

  void didChangeRoute(String? url) {
    if (url == _currentRoute) {
      return;
    }
    _previousRoute = _currentRoute;
    _currentRoute = url;
    if (!_autoPageViews) {
      return;
    }
    if (kIsWeb) {
      _capture('page_view', const {});
      return;
    }
    // Navigation events are platform-limited in the proto: page_view is
    // web-only and screen_view covers iOS/Android only. Desktop (macOS,
    // Windows, Linux) and other native targets have no matching kind, so they
    // emit no navigation event — the route state updated above still feeds the
    // $url/$referrer auto-properties on later events. screen_view also requires
    // a non-empty screenName, so a null route (e.g. the last route being
    // removed) updates route state without emitting an event.
    final platform = defaultTargetPlatform;
    final emitsScreenView =
        platform == TargetPlatform.iOS || platform == TargetPlatform.android;
    if (!emitsScreenView) {
      _warnUnsupportedNavPlatformOnce(platform, url);
      return;
    }
    if (url != null && url.isNotEmpty) {
      _capture('screen_view', {'screenName': url});
    }
  }

  void clear() {
    _currentRoute = null;
    _previousRoute = null;
  }

  /// Logs once, at debug level, when a real route change lands on a native
  /// platform with no navigation event kind (desktop and other non-iOS/Android
  /// targets), so a developer who wired `PugRouteObserver` isn't left wondering
  /// why no navigation events ever appear. Route context still rides on the
  /// `$url`/`$referrer` auto-properties. Stays silent on null/empty routes,
  /// since nothing was navigated to.
  void _warnUnsupportedNavPlatformOnce(TargetPlatform platform, String? url) {
    if (_warnedNoNavPlatform || url == null || url.isEmpty) {
      return;
    }
    _warnedNoNavPlatform = true;
    _logger.debug(
      'Pug: auto navigation events are emitted only on iOS/Android '
      '(screen_view) and web (page_view); ${platform.name} emits none. Route '
      'context still rides on the \$url/\$referrer auto-properties.',
    );
  }
}
