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
  });
}
