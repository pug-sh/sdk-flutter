import 'package:flutter/widgets.dart';

class PugRouteObserver extends NavigatorObserver {
  static void Function(String?, String?)? onRouteChanged;

  /// The single source of top-route transitions. `Navigator` calls this after
  /// any push/pop/replace/remove that actually changes the topmost route, so
  /// per-operation callbacks would double-report and — for `didRemove` — report
  /// a route that is not on top: removing `/b` from `/a → /b → /c` hands
  /// `didRemove` the route *below* the removed one (`/a`) while `/c` is still
  /// visible.
  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    _onRouteChanged(_routeName(topRoute), _routeName(previousTopRoute));
  }

  /// `didChangeTop` is not called when the stack empties, so the two callbacks
  /// that can empty it report the null route themselves.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute == null) {
      _onRouteChanged(null, _routeName(route));
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute == null) {
      _onRouteChanged(null, _routeName(route));
    }
  }

  void _onRouteChanged(String? url, String? referrer) {
    onRouteChanged?.call(url, referrer);
  }

  String? _routeName(Route<dynamic>? route) {
    if (route == null) {
      return null;
    }
    final settings = route.settings;
    final name = settings.name;
    if (name != null && name.isNotEmpty) {
      return name;
    }
    return route.runtimeType.toString();
  }
}
