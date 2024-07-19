part of 'preferences.bloc.dart';

sealed class PreferencesEvent extends Equatable {
  const PreferencesEvent();

  @override
  List<Object> get props => [];
}

class PreferencesLoad extends PreferencesEvent {}

class PreferencesSetTheme extends PreferencesEvent {
  const PreferencesSetTheme({required this.theme});

  final AppTheme theme;

  @override
  List<Object> get props => [theme];
}

class PreferencesSetSideMenuCollapse extends PreferencesEvent {
  const PreferencesSetSideMenuCollapse({required this.collapsed});

  final bool collapsed;

  @override
  List<Object> get props => [collapsed];
}

class PreferencesSetLanguage extends PreferencesEvent {
  const PreferencesSetLanguage({required this.language});

  final AppLanguage language;

  @override
  List<Object> get props => [language];
}
