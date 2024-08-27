import 'package:flutter/foundation.dart';

/// A helper class for platform-related operations.
///
/// This class provides static methods to determine the current platform.
class PlatformHelper {
  /// Returns `true` if the current platform is a mobile platform (iOS or Android).
  ///
  /// If the current platform is web, it returns `false`.
  ///
  /// If an error occurs while determining the platform, it returns `false`.
  static bool isMobile() {
    if (kIsWeb) {
      return false;
    }

    try {
      return defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android;
    } catch (_) {
      return false;
    }
  }

  static bool isWeb() {
    return kIsWeb;
  }
}
