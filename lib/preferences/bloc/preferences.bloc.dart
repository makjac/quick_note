import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/core/constans/shared_keys.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';
import 'package:quick_note/l10n/app_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'preferences_event.bloc.dart';
part 'preferences_state.bloc.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  PreferencesBloc({required this.sharedPreferences})
      : super(PreferencesInitial()) {
    on<PreferencesLoad>(_load);
    on<PreferencesSetLanguage>(_setLanguage);
    on<PreferencesSetTheme>(_setTheme);
    on<PreferencesSetSideMenuCollapse>(_setSideMenuCollapse);
  }

  final SharedPreferences sharedPreferences;

  Future<void> _load(
      PreferencesLoad event, Emitter<PreferencesState> emit) async {
    final language = sharedPreferences.getString(SharedKeys.languagePref.name);
    final theme = sharedPreferences.getString(SharedKeys.themePref.name);
    final sideMenuCollapsed =
        sharedPreferences.getBool(SharedKeys.colapseSideMenuPerf.name);

    emit(state.copyWith(
      theme: AppTheme.values.firstWhere(
        (element) => element.name == theme,
        orElse: () => AppTheme.dark,
      ),
      language: AppLanguage.values.firstWhere(
        (element) => element.name == language,
        orElse: () => AppLanguage.english,
      ),
      sideMenuCollapsed: sideMenuCollapsed,
    ));
  }

  FutureOr<void> _setLanguage(
      PreferencesSetLanguage event, Emitter<PreferencesState> emit) async {
    await sharedPreferences.setString(
        SharedKeys.languagePref.name, event.language.name);

    emit(state.copyWith(
      language: event.language,
    ));
  }

  FutureOr<void> _setTheme(
      PreferencesSetTheme event, Emitter<PreferencesState> emit) async {
    await sharedPreferences.setString(
        SharedKeys.themePref.name, event.theme.name);

    emit(state.copyWith(
      theme: event.theme,
    ));
  }

  FutureOr<void> _setSideMenuCollapse(PreferencesSetSideMenuCollapse event,
      Emitter<PreferencesState> emit) async {
    await sharedPreferences.setBool(
        SharedKeys.colapseSideMenuPerf.name, event.collapsed);

    emit(state.copyWith(
      sideMenuCollapsed: event.collapsed,
    ));
  }
}
