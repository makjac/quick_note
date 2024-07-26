import 'package:flutter/material.dart';

extension AppColors on ThemeData {
  // HomePage
  //
  // Side menu
  Color? get sideMenuBackgroundColor =>
      brightness == Brightness.dark ? Colors.grey[900] : Colors.grey;
  //
  // Headers
  // Searchbar header
  Color? get searchBarBackgroundColor =>
      brightness == Brightness.dark ? Colors.grey[900] : Colors.grey;
  Color get searchBarForegroundColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black87;
  Color get mSearchBarUserBackgroundColor => Colors.white70;
  Color? get mSearchBarUserForegroundColor =>
      brightness == Brightness.dark ? Colors.grey[900] : Colors.grey;
  // Edit header
  Color get editHeaderDividerColor =>
      brightness == Brightness.dark ? Colors.white30 : Colors.black26;
  Color? get editHeaderForegroundColor =>
      brightness == Brightness.dark ? Colors.white : Colors.black;
  //
  // Note tile
  Color? get noteTilecontentColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black87;
  //
  // Blocks
  Color get addBlockBurronBorderColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;
  // Todo
  Color get todoTaskDragIconColor =>
      brightness == Brightness.dark ? Colors.white30 : Colors.black38;
  Color get todoTaskDeleteIconColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black87;
  Color get todoTaskActiveCheckboxColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black87;
  Color get todoCheckedTextColor =>
      brightness == Brightness.dark ? Colors.white60 : Colors.black54;
  Color get todoProgressBarTextColor =>
      brightness == Brightness.dark ? Colors.black87 : Colors.white70;
  Color get todoAddTaskForegroundButtonColor =>
      brightness == Brightness.dark ? Colors.white60 : Colors.black54;
}
