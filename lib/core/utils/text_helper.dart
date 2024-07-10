import 'package:flutter/material.dart';

class TextHelper {
  static bool isTextContrastDark(Color color) {
    double brightness = color.computeLuminance();

    return brightness < 0.5;
  }

  static Color getTextColorBasedOnBackground(Color backgroundColor) {
    double backgroundBrightness = backgroundColor.computeLuminance();

    double threshold = 0.5;

    return backgroundBrightness < threshold ? Colors.white : Colors.black;
  }
}
