part of 'i10n_bloc.bloc.dart';

sealed class I10nEvent extends Equatable {
  const I10nEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguage extends I10nEvent {
  const ChangeLanguage({required this.language});

  final AppLanguage language;

  @override
  List<Object> get props => [language];
}

class GetLanguage extends I10nEvent {}
