import 'package:flutter/material.dart';
import 'package:quick_note/preferences/theme/app_dark_theme.dart';
import 'package:quick_note/preferences/theme/app_light_theme.dart';

enum AppTheme {
  dark,
  light,
}

extension AppThemex on AppTheme {
  ThemeData get themeData {
    switch (this) {
      case AppTheme.dark:
        return darkTheme;
      case AppTheme.light:
        return lightTheme;
      default:
        return darkTheme;
    }
  }
}
