import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: Colors.grey[850],
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    displaySmall: TextStyle(color: Colors.white),
    displayMedium: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    titleSmall: TextStyle(
      color: Colors.white,
      fontSize: 15,
      letterSpacing: .6,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.white,
    textColor: Colors.white,
  ),
  checkboxTheme: const CheckboxThemeData(
    side: BorderSide(
      color: Colors.white38,
      width: 2,
    ),
    checkColor: WidgetStatePropertyAll<Color>(Colors.black),
  ),
  dialogBackgroundColor: Colors.grey[800],
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Insets.xs),
      ),
    ),
  ),
  dividerColor: Colors.white70,
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.grey[800],
    iconColor: Colors.white70,
    surfaceTintColor: Colors.white70,
    textStyle: const TextStyle(color: Colors.white70),
    labelTextStyle: const WidgetStatePropertyAll<TextStyle>(
      TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
    ),
  ),
);
