import 'package:flutter/widgets.dart' show AppLifecycleState;

/// The foreground/background state machine behind `app_open` and `app_close`.
///
/// The backgrounding flush is deliberately not gated by `autoTrack`: queued
/// events must get a send attempt before the OS suspends the process, whether
/// or not lifecycle events themselves are being captured.
class AppLifecycleTracker {
  AppLifecycleTracker({
    required bool autoTrack,
    required bool Function(String kind, {required bool immediate}) capture,
    required void Function() onBackground,
  }) : _autoTrack = autoTrack,
       _capture = capture,
       _onBackground = onBackground;

  final bool _autoTrack;

  /// Returns whether the event was actually captured. The foreground flag is
  /// only flipped when it was, so a consent gate that drops an `app_open`
  /// cannot leave an unpaired `app_close` behind.
  final bool Function(String kind, {required bool immediate}) _capture;
  final void Function() _onBackground;
  bool _isForeground = false;

  /// Emits the launch `app_open` when the app is already resumed at start.
  ///
  /// Campaign capture does not run today, but if it is re-enabled it has to go
  /// before this call, or the launch `app_open` misses the launch link's
  /// campaign auto-properties.
  void syncInitialState(AppLifecycleState? state) {
    if (_autoTrack &&
        state == AppLifecycleState.resumed &&
        _capture('app_open', immediate: false)) {
      _isForeground = true;
    }
  }

  void handleStateChange(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      if (_autoTrack &&
          !_isForeground &&
          _capture('app_open', immediate: false)) {
        _isForeground = true;
      }
      return;
    }
    // Deliberately not a switch over AppLifecycleState: an exhaustive one
    // becomes a compile error the next time Flutter adds a member, inside a
    // package host apps cannot patch.
    final backgrounded =
        state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached;
    if (backgrounded &&
        _autoTrack &&
        _isForeground &&
        _capture('app_close', immediate: true)) {
      _isForeground = false;
    }
    // Everything that is not `resumed` flushes, `inactive` included. It emits
    // no `app_close` — it is a transient loss of input focus with the app still
    // visible (an incoming call, the app switcher, a control-centre swipe) —
    // but the desktop embedders send only resumed/inactive/hidden, never
    // paused or detached, so an app quit from an unfocused but visible window
    // would otherwise get no send attempt at all.
    _onBackground();
  }
}
