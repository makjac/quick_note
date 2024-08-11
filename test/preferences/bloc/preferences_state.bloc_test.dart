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

    test('copyWith should return a new instance with updated values', () {
      const state = PreferencesState(
        theme: AppTheme.light,
        language: AppLanguage.french,
        sideMenuCollapsed: true,
      );

      final newState = state.copyWith(
        theme: AppTheme.dark,
        sideMenuCollapsed: false,
      );

      expect(newState.theme, AppTheme.dark);
      expect(newState.language, AppLanguage.french);
      expect(newState.sideMenuCollapsed, false);
    });

    test('copyWith should return the same instance if no changes are made', () {
      const state = PreferencesState();

      final newState = state.copyWith();

      expect(newState, state);
    });

    test('props should include theme, language, and sideMenuCollapsed', () {
      const state = PreferencesState(
        theme: AppTheme.light,
        language: AppLanguage.spanish,
        sideMenuCollapsed: true,
      );

      expect(state.props, [AppTheme.light, AppLanguage.spanish, true]);
    });

    test('PreferencesInitial should have default values', () {
      final initial = PreferencesInitial();

      expect(initial.theme, AppTheme.dark);
      expect(initial.language, AppLanguage.english);
      expect(initial.sideMenuCollapsed, false);
    });
  });
}
