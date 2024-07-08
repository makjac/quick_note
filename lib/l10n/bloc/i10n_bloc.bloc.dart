import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/core/constans/shared_keys.dart';
import 'package:quick_note/l10n/app_language.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'i10n_event.bloc.dart';
part 'i10n_state.bloc.dart';

class I10nBloc extends Bloc<I10nEvent, I10nState> {
  I10nBloc({required this.sharedPreferences}) : super(I10nInitial()) {
    on<ChangeLanguage>(_changeLanguage);
    on<GetLanguage>(_getLanguage);
  }

  final SharedPreferences sharedPreferences;

  FutureOr<void> _changeLanguage(
      ChangeLanguage event, Emitter<I10nState> emit) async {
    await sharedPreferences.setString(
        SharedKeys.languagePref.name, event.language.name);

    emit(state.copyWith(
      currentLanguage: event.language,
    ));
  }

  FutureOr<void> _getLanguage(
      GetLanguage event, Emitter<I10nState> emit) async {
    final language = sharedPreferences.getString(SharedKeys.languagePref.name);

    emit(state.copyWith(
      currentLanguage: AppLanguage.values.firstWhere(
        (element) => element.name == language,
        orElse: () => AppLanguage.english,
      ),
    ));
  }
}
