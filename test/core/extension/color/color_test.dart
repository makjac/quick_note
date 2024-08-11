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

    test('should clamp brightness within range [0.0, 1.0]', () {
      const color = Colors.green;
      final darkColor = color.changeBrightness(-1.0);
      final lightColor = color.changeBrightness(1.0);

      expect(darkColor.computeLuminance(), lessThanOrEqualTo(0.0));
      expect(lightColor.computeLuminance(), greaterThanOrEqualTo(1.0));
    });

    test('should throw assertion error for invalid brightness amount', () {
      expect(() => Colors.purple.changeBrightness(-1.1), throwsAssertionError);
      expect(() => Colors.purple.changeBrightness(1.1), throwsAssertionError);
    });
  });
}
