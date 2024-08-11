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

    test('should have correct AppBar theme', () {
      expect(lightTheme.appBarTheme.iconTheme!.color, Colors.black);
    });

    test('should have correct scaffold background color', () {
      expect(lightTheme.scaffoldBackgroundColor, Colors.grey[200]);
    });

    test('should have correct input decoration theme', () {
      expect(lightTheme.inputDecorationTheme.hintStyle!.color, Colors.black54);
      expect(lightTheme.inputDecorationTheme.hintStyle!.fontSize, 16);
      expect(lightTheme.inputDecorationTheme.hintStyle!.fontWeight,
          FontWeight.w400);
      expect(lightTheme.inputDecorationTheme.hintStyle!.letterSpacing, 0.6);
    });

    test('should have correct icon theme', () {
      expect(lightTheme.iconTheme.color, Colors.black);
    });

    test('should have correct text theme', () {
      final textTheme = lightTheme.textTheme;
      expect(textTheme.bodySmall!.color, Colors.black);
      expect(textTheme.titleLarge!.fontSize, 26);
      expect(textTheme.titleLarge!.fontWeight, FontWeight.w600);
      expect(textTheme.titleSmall!.letterSpacing, 0.6);
    });

    test('should have correct list tile theme', () {
      expect(lightTheme.listTileTheme.iconColor, Colors.black);
      expect(lightTheme.listTileTheme.textColor, Colors.black);
    });

    test('should have correct checkbox theme', () {
      expect(lightTheme.checkboxTheme.side!.color, Colors.black38);
      expect(lightTheme.checkboxTheme.checkColor!.resolve({}), Colors.black);
    });

    test('should have correct dialog theme', () {
      expect(lightTheme.dialogTheme.titleTextStyle!.color, Colors.black87);
      expect(
          lightTheme.dialogTheme.shape,
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Insets.xs)),
          ));
    });

    test('should have correct divider color', () {
      expect(lightTheme.dividerColor, Colors.black54);
    });

    test('should have correct popup menu theme', () {
      expect(lightTheme.popupMenuTheme.color, Colors.grey[400]);
      expect(lightTheme.popupMenuTheme.iconColor, Colors.black54);
      expect(lightTheme.popupMenuTheme.textStyle!.color, Colors.black54);
    });

    test('should have correct progress indicator theme', () {
      expect(lightTheme.progressIndicatorTheme.color, Colors.black54);
      expect(
          lightTheme.progressIndicatorTheme.linearTrackColor, Colors.black12);
    });

    test('should have correct drawer theme', () {
      expect(lightTheme.drawerTheme.backgroundColor, Colors.grey[400]);
      expect(lightTheme.drawerTheme.elevation, 3);
    });

    test('should have correct bottom sheet theme', () {
      expect(lightTheme.bottomSheetTheme.backgroundColor, Colors.grey[400]);
    });
