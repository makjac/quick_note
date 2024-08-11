import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/utils/text_helper.dart';

void main() {
  group('TextHelper', () {
    test('isTextContrastDark returns true for dark colors', () {
      const darkColor = Colors.black;
      final result = TextHelper.isTextContrastDark(darkColor);

      expect(result, isTrue);
    });

    test('isTextContrastDark returns false for light colors', () {
      const lightColor = Colors.white;
      final result = TextHelper.isTextContrastDark(lightColor);

      expect(result, isFalse);
    });

    test('getTextColorBasedOnBackground returns white for dark background', () {
      const darkBackgroundColor = Colors.black;
      final result =
          TextHelper.getTextColorBasedOnBackground(darkBackgroundColor);

      expect(result, Colors.white);
    });

    test('getTextColorBasedOnBackground returns black for light background',
        () {
      const lightBackgroundColor = Colors.white;
      final result =
          TextHelper.getTextColorBasedOnBackground(lightBackgroundColor);

      expect(result, Colors.black);
    });
  });
}
