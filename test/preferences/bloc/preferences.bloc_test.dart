import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/constans/shared_keys.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';
import 'package:quick_note/l10n/app_language.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('PreferencesBloc', () {
    late PreferencesBloc preferencesBloc;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      preferencesBloc =
          PreferencesBloc(sharedPreferences: mockSharedPreferences);

      when(() => mockSharedPreferences.getString(any())).thenReturn(null);
      when(() => mockSharedPreferences.getBool(any())).thenReturn(null);
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      when(() => mockSharedPreferences.setBool(any(), any()))
          .thenAnswer((_) async => true);
    });

    test('initial state is PreferencesInitial', () {
      expect(preferencesBloc.state, isA<PreferencesInitial>());
    });

    blocTest<PreferencesBloc, PreferencesState>(
      'emits new state with default values when PreferencesLoad is added',
      build: () => preferencesBloc,
      act: (bloc) => bloc.add(PreferencesLoad()),
      expect: () => [
        const PreferencesState(
          theme: AppTheme.dark,
          language: AppLanguage.english,
          sideMenuCollapsed: false,
        ),
      ],
    );

    blocTest<PreferencesBloc, PreferencesState>(
      'emits new state with updated language when PreferencesSetLanguage is added',
      build: () => preferencesBloc,
      act: (bloc) {
        when(() => mockSharedPreferences.setString(
                SharedKeys.languagePref.name, AppLanguage.spanish.name))
            .thenAnswer((_) async => true);
        bloc.add(const PreferencesSetLanguage(language: AppLanguage.spanish));
      },
      expect: () => [
        const PreferencesState(
          theme: AppTheme.dark,
          language: AppLanguage.spanish,
          sideMenuCollapsed: false,
        ),
      ],
    );

    blocTest<PreferencesBloc, PreferencesState>(
      'emits new state with updated theme when PreferencesSetTheme is added',
      build: () => preferencesBloc,
      act: (bloc) {
        when(() => mockSharedPreferences.setString(
                SharedKeys.themePref.name, AppTheme.light.name))
            .thenAnswer((_) async => true);
        bloc.add(const PreferencesSetTheme(theme: AppTheme.light));
      },
      expect: () => [
        const PreferencesState(
          theme: AppTheme.light,
          language: AppLanguage.english,
          sideMenuCollapsed: false,
        ),
      ],
    );
  });
}
