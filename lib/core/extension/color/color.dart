import 'package:flutter/material.dart';

extension ColorExtension on Color {
  Color changeBrightness(double amount) {
    assert(amount >= -1 && amount <= 1,
        'Brightness amount must be between -1 and 1');

    final hsl = HSLColor.fromColor(this);

    final modifiedHSL =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return modifiedHSL.toColor();
  }
}
