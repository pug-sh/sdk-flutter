import 'package:flutter/widgets.dart';

class PugRouteObserver extends NavigatorObserver {
  static void Function(String?, String?)? onRouteChanged;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _onRouteChanged(_routeName(route), _routeName(previousRoute));
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _onRouteChanged(_routeName(previousRoute), _routeName(route));
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _onRouteChanged(_routeName(newRoute), _routeName(oldRoute));
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _onRouteChanged(_routeName(previousRoute), null);
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
