import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/preferences/theme/app_dark_theme.dart';

void main() {
  group('darkTheme', () {
    test('should use Material3', () {
      expect(darkTheme.useMaterial3, isTrue);
    });

    test('should have dark brightness', () {
      expect(darkTheme.brightness, Brightness.dark);
    });

    test('should have correct AppBar theme', () {
      expect(darkTheme.appBarTheme.iconTheme!.color, Colors.white);
    });

    test('should have correct scaffold background color', () {
      expect(darkTheme.scaffoldBackgroundColor, Colors.grey[850]);
    });
  });
}
