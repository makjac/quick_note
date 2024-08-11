import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/l10n/app_language.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';

void main() {
  group('PreferencesEvent', () {
    test('PreferencesLoad should have empty props', () {
      final event = PreferencesLoad();

      expect(event.props, isEmpty);
    });

    test('PreferencesSetTheme should have correct props', () {
      const theme = AppTheme.light;
      const event = PreferencesSetTheme(theme: theme);

      expect(event.theme, theme);
      expect(event.props, [theme]);
    });

    test('PreferencesSetSideMenuCollapse should have correct props', () {
      const collapsed = true;
      const event = PreferencesSetSideMenuCollapse(collapsed: collapsed);

      expect(event.collapsed, collapsed);
      expect(event.props, [collapsed]);
    });

    test('PreferencesSetLanguage should have correct props', () {
      const language = AppLanguage.spanish;
      const event = PreferencesSetLanguage(language: language);

      expect(event.language, language);
      expect(event.props, [language]);
    });

    test('Different PreferencesEvents with same properties should be equal',
        () {
      const theme = AppTheme.dark;
      const language = AppLanguage.english;
      const event1 = PreferencesSetTheme(theme: theme);
      const event2 = PreferencesSetTheme(theme: theme);

      expect(event1, event2);

      const event3 = PreferencesSetLanguage(language: language);
      const event4 = PreferencesSetLanguage(language: language);

      expect(event3, event4);
    });
  });
}
