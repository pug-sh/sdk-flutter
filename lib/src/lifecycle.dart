import 'package:flutter/widgets.dart' show AppLifecycleState;

/// The foreground/background state machine behind `app_open` and `app_close`.
///
/// The backgrounding flush is deliberately not gated by `autoTrack`: queued
/// events must get a send attempt before the OS suspends the process, whether
/// or not lifecycle events themselves are being captured.
class AppLifecycleTracker {
  AppLifecycleTracker({
    required bool autoTrack,
    required void Function(String kind, {required bool immediate}) capture,
    required void Function() onBackground,
  }) : _autoTrack = autoTrack,
       _capture = capture,
       _onBackground = onBackground;

  final bool _autoTrack;
  final void Function(String kind, {required bool immediate}) _capture;
  final void Function() _onBackground;
  bool _isForeground = false;

  /// Emits the launch `app_open` when the app is already resumed at start.
  ///
  /// Campaign capture does not run today, but if it is re-enabled it has to go
  /// before this call, or the launch `app_open` misses the launch link's
  /// campaign auto-properties.
  void syncInitialState(AppLifecycleState? state) {
    if (_autoTrack && state == AppLifecycleState.resumed) {
      _isForeground = true;
      _capture('app_open', immediate: false);
    }
  }

  void handleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (_autoTrack && !_isForeground) {
          _isForeground = true;
          _capture('app_open', immediate: false);
        }
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_autoTrack && _isForeground) {
          _isForeground = false;
          _capture('app_close', immediate: true);
        }
        _onBackground();
    }
  }
}
