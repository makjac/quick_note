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
