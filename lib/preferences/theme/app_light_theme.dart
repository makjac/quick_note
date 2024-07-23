import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.grey[100],
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white54,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
    displaySmall: TextStyle(color: Colors.black),
    displayMedium: TextStyle(color: Colors.black),
    displayLarge: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    labelSmall: TextStyle(color: Colors.black),
    labelMedium: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
    titleSmall: TextStyle(
      color: Colors.black,
      fontSize: 15,
      letterSpacing: .6,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    ),
    titleMedium: TextStyle(
      color: Colors.black,
      fontSize: 22,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    ),
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 26,
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  listTileTheme: const ListTileThemeData(
    iconColor: Colors.black,
    textColor: Colors.black,
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
);
