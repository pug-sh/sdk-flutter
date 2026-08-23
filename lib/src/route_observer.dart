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
  /// that can empty it report the null route themselves. Whether it emptied is
  /// tracked by counting: a null `previousRoute` only means the *bottom-most*
  /// route went, which routinely happens with routes still on screen — popping
  /// the last of them, or `pushAndRemoveUntil`, which clears the stack from the
  /// bottom up under a route it has already pushed.
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _onRouteRemoved(route);

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      _onRouteRemoved(route);

  void _onRouteRemoved(Route<dynamic> route) {
    // Already zero means this observer was attached to a Navigator that had
    // routes before it could count them; reporting an empty stack from that is
    // a guess, so stay quiet until a push gives a real baseline.
    if (_depth == 0) {
      return;
    }
    _depth -= 1;
    if (_depth == 0) {
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
