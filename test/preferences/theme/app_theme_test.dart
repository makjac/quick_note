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
  });
}
