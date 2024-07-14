import 'dart:io';

import 'package:flutter/foundation.dart';

class PlatformHelper {
  static bool isMobile() {
    if (kIsWeb) {
      return false;
    }

    try {
      return Platform.isAndroid || Platform.isIOS;
    } catch (_) {
      return false;
    }
  }

  static bool isWeb() {
    return kIsWeb;
  }
}
