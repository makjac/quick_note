part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppLoadCachedNotes extends AppEvent {}

class AppCreateNote extends AppEvent {}

class AppDeleteSingleNote extends AppEvent {
  const AppDeleteSingleNote({required this.id});

  final num id;

  @override
  List<Object> get props => [id];
}

class AppDeleteAllNotes extends AppEvent {}

class AppDeleteSelectedNotes extends AppEvent {}

class AppUpdateSingleNote extends AppEvent {
  const AppUpdateSingleNote({required this.note, required this.updates});

  final Note note;
  final NoteUpdates updates;

  @override
  List<Object> get props => [note, updates];
}

class AppUpdateSelectedNotes extends AppEvent {
  const AppUpdateSelectedNotes({required this.updates});

  final NoteUpdates updates;

  @override
  List<Object> get props => [updates];
}

class AppStarSelectedNotes extends AppEvent {}

class AppArchiveSelectedNotes extends AppEvent {}

class AppSelectNote extends AppEvent {
  const AppSelectNote({required this.noteId});

  final num noteId;

  @override
  List<Object> get props => [noteId];
}

class AppUnselectAllNotes extends AppEvent {}

class AppSelectAllNotes extends AppEvent {}

class AppSetSearchTerm extends AppEvent {}

class AppClearSearchTerm extends AppEvent {}
