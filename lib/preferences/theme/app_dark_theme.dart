import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
  ),
  scaffoldBackgroundColor: Colors.grey[850],
  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white60,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: .6,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    bodyLarge: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    displayLarge: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
      overflow: TextOverflow.ellipsis,
    ),
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
      color: Colors.white,
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
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Colors.white,
    linearTrackColor: Colors.white12,
  ),
  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.grey[850],
    elevation: 3,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.grey[800],
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white38,
  ),
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
    ),
  ),
  dividerTheme: const DividerThemeData(
    color: Colors.white60,
  ),
  outlinedButtonTheme: const OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll<Color>(Colors.white),
    ),
  ),
);
