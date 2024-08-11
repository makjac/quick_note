import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/preferences/theme/app_light_theme.dart';

void main() {
  group('lightTheme', () {
    test('should use Material3', () {
      expect(lightTheme.useMaterial3, isTrue);
    });

    test('should have light brightness', () {
      expect(lightTheme.brightness, Brightness.light);
    });

    test('should have correct AppBar theme', () {
      expect(lightTheme.appBarTheme.iconTheme!.color, Colors.black);
    });

    test('should have correct scaffold background color', () {
      expect(lightTheme.scaffoldBackgroundColor, Colors.grey[200]);
    });

    test('should have correct input decoration theme', () {
      expect(lightTheme.inputDecorationTheme.hintStyle!.color, Colors.black54);
      expect(lightTheme.inputDecorationTheme.hintStyle!.fontSize, 16);
      expect(lightTheme.inputDecorationTheme.hintStyle!.fontWeight,
          FontWeight.w400);
      expect(lightTheme.inputDecorationTheme.hintStyle!.letterSpacing, 0.6);
    });

    test('should have correct icon theme', () {
      expect(lightTheme.iconTheme.color, Colors.black);
    });
