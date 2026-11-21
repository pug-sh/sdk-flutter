/// Stands in for `dart:io`'s `Platform` in web builds, through the conditional
/// import in `auto_properties.dart`: pub.dev lists a package for the web only
/// when no `dart:io` import reaches it there. Every read is behind a `kIsWeb`
/// check, and these throw as `dart:io`'s do on the web.
abstract final class Platform {
  static String get operatingSystem =>
      throw UnsupportedError('Platform.operatingSystem');

  static String get operatingSystemVersion =>
      throw UnsupportedError('Platform.operatingSystemVersion');
}
