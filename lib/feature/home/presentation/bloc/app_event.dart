part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class LoadCachedNotes extends AppEvent {}

class CreateNote extends AppEvent {
  final Note note;

  const CreateNote({required this.note});

  @override
  List<Object> get props => [note];
}

class DeleteSingleNote extends AppEvent {
  const DeleteSingleNote({required this.id});

  final num id;

  @override
  List<Object> get props => [id];
}

class DeleteAllNotes extends AppEvent {}

class DeleteSelectedNotes extends AppEvent {}

class UpdateSingleNote extends AppEvent {
  const UpdateSingleNote({required this.note, required this.updates});

  final Note note;
  final NoteUpdates updates;

  @override
  List<Object> get props => [note, updates];
}

class UpdateSelectedNotes extends AppEvent {
  const UpdateSelectedNotes({required this.updates});

  final NoteUpdates updates;

  @override
  List<Object> get props => [updates];
}

class StarSelectedNotes extends AppEvent {}

class ArchiveSelectedNotes extends AppEvent {}

class SelectNote extends AppEvent {
  const SelectNote({required this.noteId});

  final num noteId;

  @override
  List<Object> get props => [noteId];
}

class UnselectAllNotes extends AppEvent {}

class SelectAllNotes extends AppEvent {}
