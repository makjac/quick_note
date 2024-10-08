import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/preferences/theme/app_dark_theme.dart';

void main() {
  group('darkTheme', () {
    test('should use Material3', () {
      expect(darkTheme.useMaterial3, isTrue);
    });

    test('should have dark brightness', () {
      expect(darkTheme.brightness, Brightness.dark);
    });

    test('should have correct AppBar theme', () {
      expect(darkTheme.appBarTheme.iconTheme!.color, Colors.white);
    });

    test('should have correct scaffold background color', () {
      expect(darkTheme.scaffoldBackgroundColor, Colors.grey[850]);
    });

    test('should have correct input decoration theme', () {
      expect(darkTheme.inputDecorationTheme.hintStyle!.color, Colors.white60);
      expect(darkTheme.inputDecorationTheme.hintStyle!.fontSize, 16);
      expect(darkTheme.inputDecorationTheme.hintStyle!.fontWeight,
          FontWeight.w400);
      expect(darkTheme.inputDecorationTheme.hintStyle!.letterSpacing, 0.6);
    });

    test('should have correct icon theme', () {
      expect(darkTheme.iconTheme.color, Colors.white);
    });

    test('should have correct text theme', () {
      final textTheme = darkTheme.textTheme;
      expect(textTheme.bodySmall!.color, Colors.white);
      expect(textTheme.titleLarge!.fontSize, 26);
      expect(textTheme.titleLarge!.fontWeight, FontWeight.w600);
      expect(textTheme.titleSmall!.letterSpacing, 0.6);
    });

    test('should have correct list tile theme', () {
      expect(darkTheme.listTileTheme.iconColor, Colors.white);
      expect(darkTheme.listTileTheme.textColor, Colors.white);
    });

    test('should have correct checkbox theme', () {
      expect(darkTheme.checkboxTheme.side!.color, Colors.white38);
      expect(darkTheme.checkboxTheme.checkColor!.resolve({}), Colors.black);
    });

    test('should have correct dialog theme', () {
      expect(darkTheme.dialogTheme.titleTextStyle!.color, Colors.white);
      expect(
          darkTheme.dialogTheme.shape,
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Insets.xs)),
          ));
    });

    test('should have correct divider color', () {
      expect(darkTheme.dividerColor, Colors.white70);
    });

    test('should have correct popup menu theme', () {
      expect(darkTheme.popupMenuTheme.color, Colors.grey[800]);
      expect(darkTheme.popupMenuTheme.iconColor, Colors.white70);
      expect(darkTheme.popupMenuTheme.textStyle!.color, Colors.white70);
    });

    test('should have correct progress indicator theme', () {
      expect(darkTheme.progressIndicatorTheme.color, Colors.white);
      expect(darkTheme.progressIndicatorTheme.linearTrackColor, Colors.white12);
    });

    test('should have correct drawer theme', () {
      expect(darkTheme.drawerTheme.backgroundColor, Colors.grey[850]);
      expect(darkTheme.drawerTheme.elevation, 3);
    });

    test('should have correct bottom sheet theme', () {
      expect(darkTheme.bottomSheetTheme.backgroundColor, Colors.grey[800]);
    });

    test('should have correct text selection theme', () {
      expect(darkTheme.textSelectionTheme.cursorColor, Colors.white38);
    });

    test('should have correct text button theme', () {
      expect(darkTheme.textButtonTheme.style!.foregroundColor!.resolve({}),
          Colors.white);
    });

    test('should have correct outlined button theme', () {
      expect(darkTheme.outlinedButtonTheme.style!.foregroundColor!.resolve({}),
          Colors.white);
    });
  });
}
