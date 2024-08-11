import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/extension/color/color.dart';

void main() {
  group('ColorExtension', () {
    test('should change brightness of a color', () {
      const color = Colors.blue;
      final lighterColor = color.changeBrightness(0.2);
      final darkerColor = color.changeBrightness(-0.2);

      expect(lighterColor, isNot(equals(color)));
      expect(darkerColor, isNot(equals(color)));
    });

    test('should return the same color when brightness change is 0', () {
      const color = Colors.red;
      final resultColor = color.changeBrightness(0.0);

      expect(resultColor.value, equals(color.value));
    });
  });
}
