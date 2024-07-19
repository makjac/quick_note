part of 'note_search_cubit.dart';

class NoteSearchState extends Equatable {
  const NoteSearchState({String? searchTerm}) : searchTerm = searchTerm ?? "";

  final String searchTerm;

  @override
  List<Object> get props => [searchTerm];
}

final class NoteSearchInitial extends NoteSearchState {}
