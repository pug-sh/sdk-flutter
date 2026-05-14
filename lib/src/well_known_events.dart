import 'events.dart';

class PugEventNames {
  const PugEventNames._();

  static const addToCart = 'add_to_cart';
  static const appClose = 'app_close';
  static const appOpen = 'app_open';
  static const checkoutCompleted = 'checkout_completed';
  static const checkoutStarted = 'checkout_started';
  static const click = 'click';
  static const deadClick = 'dead_click';
  static const errorOccurred = 'error_occurred';
  static const formStart = 'form_start';
  static const formSubmit = 'form_submit';
  static const login = 'login';
  static const logout = 'logout';
  static const notificationClicked = 'notification_clicked';
  static const notificationDismissed = 'notification_dismissed';
  static const notificationReceived = 'notification_received';
  static const pageView = 'page_view';
  static const purchase = 'purchase';
  static const rageClick = 'rage_click';
  static const scroll = 'scroll';
  static const search = 'search';
  static const share = 'share';
  static const signup = 'signup';
  static const videoPause = 'video_pause';
  static const videoPlay = 'video_play';

  static const all = <String>[
    addToCart,
    appClose,
    appOpen,
    checkoutCompleted,
    checkoutStarted,
    click,
    deadClick,
    errorOccurred,
    formStart,
    formSubmit,
    login,
    logout,
    notificationClicked,
    notificationDismissed,
    notificationReceived,
    pageView,
    purchase,
    rageClick,
    scroll,
    search,
    share,
    signup,
    videoPause,
    videoPlay,
  ];

  static bool isWellKnown(String kind) =>
      wellKnownEventSchemas.containsKey(kind);
}

typedef PugProperties = Map<String, Object?>;
