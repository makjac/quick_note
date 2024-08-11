import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

void main() {
  group('AppColors extension', () {
    test('sideMenuBackgroundColor should return correct color for dark theme',
        () {
      final darkTheme = ThemeData(brightness: Brightness.dark);
      expect(darkTheme.sideMenuBackgroundColor, Colors.grey[900]);
    });

    test('sideMenuBackgroundColor should return correct color for light theme',
        () {
      final lightTheme = ThemeData(brightness: Brightness.light);
      expect(lightTheme.sideMenuBackgroundColor, Colors.grey);
    });

    test('searchBarBackgroundColor should return correct color for dark theme',
        () {
      final darkTheme = ThemeData(brightness: Brightness.dark);
      expect(darkTheme.searchBarBackgroundColor, Colors.grey[900]);
    });

    test('searchBarBackgroundColor should return correct color for light theme',
        () {
      final lightTheme = ThemeData(brightness: Brightness.light);
      expect(lightTheme.searchBarBackgroundColor, Colors.grey);
    });

    test('searchBarForegroundColor should return correct color for dark theme',
        () {
      final darkTheme = ThemeData(brightness: Brightness.dark);
      expect(darkTheme.searchBarForegroundColor, Colors.white70);
    });

    test('searchBarForegroundColor should return correct color for light theme',
        () {
      final lightTheme = ThemeData(brightness: Brightness.light);
      expect(lightTheme.searchBarForegroundColor, Colors.black87);
    });

    test(
        'todoTaskActiveCheckboxColor should return correct color for dark theme',
        () {
      final darkTheme = ThemeData(brightness: Brightness.dark);
      expect(darkTheme.todoTaskActiveCheckboxColor, Colors.white70);
    });

    test(
        'todoTaskActiveCheckboxColor should return correct color for light theme',
        () {
      final lightTheme = ThemeData(brightness: Brightness.light);
      expect(lightTheme.todoTaskActiveCheckboxColor, Colors.black87);
    });
  });
}
