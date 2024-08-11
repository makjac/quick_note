import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

void main() {
  group('NoteColorsExtension', () {
    test('returns correct color for dark theme', () {
      expect(NoteColors.color1.color(AppTheme.dark),
          const Color.fromARGB(255, 89, 89, 89));
      expect(NoteColors.color2.color(AppTheme.dark),
          const Color.fromARGB(255, 31, 31, 31));
      expect(NoteColors.color3.color(AppTheme.dark),
          const Color.fromARGB(255, 102, 53, 53));
      expect(NoteColors.color4.color(AppTheme.dark),
          const Color.fromARGB(255, 102, 81, 53));
      expect(NoteColors.color5.color(AppTheme.dark),
          const Color.fromARGB(255, 80, 82, 43));
      expect(NoteColors.color6.color(AppTheme.dark),
          const Color.fromARGB(255, 60, 102, 53));
      expect(NoteColors.color7.color(AppTheme.dark),
          const Color.fromARGB(255, 36, 71, 54));
      expect(NoteColors.color8.color(AppTheme.dark),
          const Color.fromARGB(255, 53, 95, 102));
      expect(NoteColors.color9.color(AppTheme.dark),
          const Color.fromARGB(255, 53, 69, 102));
      expect(NoteColors.color10.color(AppTheme.dark),
          const Color.fromARGB(255, 64, 53, 102));
      expect(NoteColors.color11.color(AppTheme.dark),
          const Color.fromARGB(255, 95, 53, 102));
      expect(NoteColors.color12.color(AppTheme.dark),
          const Color.fromARGB(255, 102, 53, 71));
    });
  });
}
