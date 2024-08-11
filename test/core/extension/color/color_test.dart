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
  });
}
