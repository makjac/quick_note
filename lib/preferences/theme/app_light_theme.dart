import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
  ),
  scaffoldBackgroundColor: Colors.grey[200],
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.black54,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: .6,
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
      color: Colors.black38,
      width: 2,
    ),
    checkColor: WidgetStatePropertyAll<Color>(Colors.black),
  ),
  dialogBackgroundColor: Colors.grey[400],
  dialogTheme: const DialogTheme(
    titleTextStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: Colors.black87,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(Insets.xs),
      ),
    ),
  ),
  dividerColor: Colors.black54,
  popupMenuTheme: PopupMenuThemeData(
    color: Colors.grey[400],
    iconColor: Colors.black54,
    surfaceTintColor: Colors.black54,
    textStyle: const TextStyle(color: Colors.black54),
    labelTextStyle: const WidgetStatePropertyAll<TextStyle>(
      TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.black54,
    linearTrackColor: Colors.black12,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey[400],
    elevation: 3,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.grey[400],
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black38,
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.black54,
  ),
  outlinedButtonTheme: const OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll<Color>(Colors.black),
    ),
  ),
);
