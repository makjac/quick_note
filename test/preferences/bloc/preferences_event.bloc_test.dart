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
  });
}
