import 'package:flutter/material.dart';

/// A helper class for working with text.
class TextHelper {
  /// Determines whether the given [color] has a dark contrast for text.
  ///
  /// The contrast is determined by computing the luminance of the color.
  /// If the luminance is less than 0.5, the contrast is considered dark.
  ///
  /// Returns `true` if the contrast is dark, `false` otherwise.
  static bool isTextContrastDark(Color color) {
    double brightness = color.computeLuminance();

    return brightness < 0.5;
  }

  /// Determines the appropriate text color based on the background color.
  ///
  /// The [backgroundColor] parameter represents the color of the background.
  /// It calculates the brightness of the background color using the `computeLuminance()` method.
  /// If the background brightness is less than the threshold value of 0.5, it returns `Colors.white`,
  /// otherwise it returns `Colors.black`.
  ///
  /// Returns the appropriate text color based on the background color.
  static Color getTextColorBasedOnBackground(Color backgroundColor) {
    double backgroundBrightness = backgroundColor.computeLuminance();

    double threshold = 0.5;

    return backgroundBrightness < threshold ? Colors.white : Colors.black;
  }
}
