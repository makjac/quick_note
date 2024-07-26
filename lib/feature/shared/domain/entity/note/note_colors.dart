import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';

part 'note_colors.g.dart';

@HiveType(typeId: 6)
enum NoteColors {
  @HiveField(0)
  color1,
  @HiveField(10)
  color2,
  @HiveField(20)
  color3,
  @HiveField(30)
  color4,
  @HiveField(40)
  color5,
  @HiveField(50)
  color6,
  @HiveField(60)
  color7,
  @HiveField(70)
  color8,
  @HiveField(80)
  color9,
  @HiveField(90)
  color10,
  @HiveField(100)
  color11,
  @HiveField(110)
  color12,
}

extension NoteColorsExtension on NoteColors {
  Color color(AppTheme theme) {
    switch (this) {
      case NoteColors.color1:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 89, 89, 89)
            : const Color.fromARGB(255, 211, 211, 211);
      case NoteColors.color2:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 31, 31, 31)
            : const Color.fromARGB(255, 169, 169, 169);
      case NoteColors.color3:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 102, 53, 53)
            : const Color.fromARGB(255, 210, 105, 3);
      case NoteColors.color4:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 102, 81, 53)
            : const Color.fromARGB(255, 210, 180, 140);
      case NoteColors.color5:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 80, 82, 43)
            : const Color.fromARGB(255, 189, 183, 107);
      case NoteColors.color6:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 60, 102, 53)
            : const Color.fromARGB(255, 144, 238, 144);
      case NoteColors.color7:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 36, 71, 54)
            : const Color.fromARGB(255, 64, 224, 208);
      case NoteColors.color8:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 53, 95, 102)
            : const Color.fromARGB(255, 135, 206, 235);
      case NoteColors.color9:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 53, 69, 102)
            : const Color.fromARGB(255, 173, 216, 230);
      case NoteColors.color10:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 64, 53, 102)
            : const Color.fromARGB(255, 218, 112, 214);
      case NoteColors.color11:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 95, 53, 102)
            : const Color.fromARGB(255, 221, 160, 221);
      case NoteColors.color12:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 102, 53, 71)
            : const Color.fromARGB(255, 255, 182, 193);
      default:
        return theme == AppTheme.dark
            ? const Color.fromARGB(255, 89, 89, 89)
            : const Color.fromARGB(255, 211, 211, 211);
    }
  }
}
