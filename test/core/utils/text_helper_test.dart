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
  });
}
