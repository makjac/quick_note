import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/l10n/app_language.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';

void main() {
  group('PreferencesState', () {
    test('should have default values', () {
      const state = PreferencesState();

      expect(state.theme, AppTheme.dark);
      expect(state.language, AppLanguage.english);
      expect(state.sideMenuCollapsed, false);
    });
  });
}
