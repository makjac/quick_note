import 'package:flutter/foundation.dart';

/// A helper class for platform-related operations.
///
/// This class provides static methods to determine the current platform.
class PlatformHelper {
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
