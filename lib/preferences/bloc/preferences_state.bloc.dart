part of 'preferences.bloc.dart';

class PreferencesState extends Equatable {
  const PreferencesState({
    AppTheme? theme,
    AppLanguage? language,
    bool? sideMenuCollapsed,
  })  : theme = theme ?? AppTheme.dark,
        language = language ?? AppLanguage.english,
        sideMenuCollapsed = sideMenuCollapsed ?? false;

  final AppTheme theme;
  final AppLanguage language;
  final bool sideMenuCollapsed;

  PreferencesState copyWith({
    AppTheme? theme,
    AppLanguage? language,
    bool? sideMenuCollapsed,
  }) {
    return PreferencesState(
      theme: theme ?? this.theme,
      language: language ?? this.language,
      sideMenuCollapsed: sideMenuCollapsed ?? this.sideMenuCollapsed,
    );
  }

  @override
  List<Object> get props => [theme, language, sideMenuCollapsed];
}

final class PreferencesInitial extends PreferencesState {}
