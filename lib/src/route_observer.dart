import 'package:flutter/widgets.dart';

class PugRouteObserver extends NavigatorObserver {
  static void Function(String?, String?)? onRouteChanged;

  int _depth = 0;

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

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _depth += 1;
  }

  /// `didChangeTop` is not called when the stack empties, so the two callbacks
  /// that can empty it report the null route themselves.
  ///
  /// For `didPop` a null `previousRoute` is exact: `pop` takes the topmost
  /// route, so nothing below it means nothing is left.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _depth -= 1;
    if (previousRoute == null) {
      _onRouteChanged(null, _routeName(route));
    }
  }

  /// For `didRemove` a null `previousRoute` is not enough: `Navigator` passes
  /// null whenever the *bottom-most* route goes, which leaves the routes above
  /// it on screen — `pushAndRemoveUntil` clears the stack from the bottom up
  /// under a route it has already pushed. So it is confirmed against the route
  /// count, which goes negative rather than reaching zero when this observer
  /// was attached to a Navigator that already had routes. An unknown baseline
  /// therefore stays quiet instead of reporting an empty stack that isn't.
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _depth -= 1;
    if (previousRoute == null && _depth == 0) {
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
