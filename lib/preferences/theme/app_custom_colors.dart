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
  Color? get changeNoteColorPopupBacgroundColor =>
      brightness == Brightness.dark ? Colors.grey[800] : Colors.grey[300];
  //
  // Note tile
  Color? get noteTilecontentColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black87;
  //
  // Blocks
  Color get addBlockButtonBorderColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;
  Color get noteBlockBorderColor =>
      brightness == Brightness.dark ? Colors.white10 : Colors.black12;
  Color get noteTitleTextFieldColor =>
      brightness == Brightness.dark ? Colors.white54 : Colors.black54;
  // _Todo
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
  Color get todoTaskHoverColor =>
      brightness == Brightness.dark ? Colors.white12 : Colors.black12;
  // Bookmark
  Color get bookmarkDragIconColor =>
      brightness == Brightness.dark ? Colors.white30 : Colors.black38;
  Color get bookmarkDeleteIconColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black87;
  Color get bookmarkFaviconBackgroundColor =>
      brightness == Brightness.dark ? Colors.white : Colors.white70;
  Color get bookmarkFullUrlColor =>
      brightness == Brightness.dark ? Colors.white54 : Colors.black54;
  Color get bookmarkHoverColor =>
      brightness == Brightness.dark ? Colors.white12 : Colors.black12;
}
