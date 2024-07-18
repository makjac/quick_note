part of 'preferences.bloc.dart';

class PreferencesState extends Equatable {
  const PreferencesState({
    AppTheme? theme,
    bool? sideMenuCollapsed,
  })  : theme = theme ?? AppTheme.dark,
        sideMenuCollapsed = sideMenuCollapsed ?? false;

  final AppTheme theme;
  final bool sideMenuCollapsed;

  PreferencesState copyWith({
    AppTheme? theme,
    bool? sideMenuCollapsed,
  }) {
    return PreferencesState(
      theme: theme ?? this.theme,
      sideMenuCollapsed: sideMenuCollapsed ?? this.sideMenuCollapsed,
    );
  }

  @override
  List<Object> get props => [theme, sideMenuCollapsed];
}

final class PreferencesInitial extends PreferencesState {}
