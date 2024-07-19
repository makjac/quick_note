import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'note_search_state.dart';

class NoteSearchCubit extends Cubit<NoteSearchState> {
  NoteSearchCubit() : super(NoteSearchInitial());

  FutureOr<void> setSearchTerm(String searchTerm) async {
    emit(NoteSearchState(searchTerm: searchTerm));
  }

  FutureOr<void> clearSearchTerm() async {
    emit(const NoteSearchState());
  }
}
