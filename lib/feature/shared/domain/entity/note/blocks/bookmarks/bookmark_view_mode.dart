import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quick_note/l10n/l10n.dart';

part 'bookmark_view_mode.g.dart';

@HiveType(typeId: 9)
enum BookmarkViewMode {
  @HiveField(0, defaultValue: [])
  list,
  @HiveField(10, defaultValue: [])
  grid,
  @HiveField(20, defaultValue: [])
  icons,
}

extension BookmarkViewModeExtension on BookmarkViewMode {
  String translatedName(BuildContext context) {
    switch (this) {
      case BookmarkViewMode.list:
        return context.l10n.bookmark_list_view_mode;
      case BookmarkViewMode.grid:
        return context.l10n.bookmark_grid_view_mode;
      case BookmarkViewMode.icons:
        return context.l10n.bookmark_icons_view_mode;
    }
  }
}
