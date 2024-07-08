part of 'i10n_bloc.bloc.dart';

class I10nState extends Equatable {
  const I10nState({
    AppLanguage? currentLanguage,
  }) : currentLanguage = currentLanguage ?? AppLanguage.english;

  final AppLanguage currentLanguage;

  I10nState copyWith({AppLanguage? currentLanguage}) {
    return I10nState(currentLanguage: currentLanguage ?? this.currentLanguage);
  }

  @override
  List<Object> get props => [currentLanguage];
}

final class I10nInitial extends I10nState {}
