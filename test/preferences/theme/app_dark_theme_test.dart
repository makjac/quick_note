import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/preferences/theme/app_dark_theme.dart';

void main() {
  group('darkTheme', () {
    test('should use Material3', () {
      expect(darkTheme.useMaterial3, isTrue);
    });
  });
}
