import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/preferences/theme/app_dark_theme.dart';
import 'package:quick_note/preferences/theme/app_light_theme.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';

void main() {
  group('AppThemex', () {
    test('should return darkTheme when AppTheme is dark', () {
      const appTheme = AppTheme.dark;

      final themeData = appTheme.themeData;

      expect(themeData, darkTheme);
    });

    test('should return lightTheme when AppTheme is light', () {
      const appTheme = AppTheme.light;

      final themeData = appTheme.themeData;

      expect(themeData, lightTheme);
    });

    test('should return darkTheme by default if enum value is unrecognized',
        () {
      final appTheme = AppTheme.values.firstWhere(
        (e) => e.toString() == 'AppTheme.unknown',
        orElse: () => AppTheme.dark,
      );

      final themeData = appTheme.themeData;

      expect(themeData, darkTheme);
    });
  });
}
