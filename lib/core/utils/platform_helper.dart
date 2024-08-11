import 'package:flutter/foundation.dart';

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
