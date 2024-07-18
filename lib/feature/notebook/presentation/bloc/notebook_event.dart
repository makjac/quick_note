part of 'notebook_bloc.dart';

sealed class NotebookEvent extends Equatable {
  const NotebookEvent();

  @override
  List<Object> get props => [];
}

class NotebookCreateNote extends NotebookEvent {}

class NotebookGetNote extends NotebookEvent {
  const NotebookGetNote({this.noteId});

  final num? noteId;

  @override
  List<Object> get props => [noteId ?? -1];
}

class NotebookUpdateNote extends NotebookEvent {
  const NotebookUpdateNote({
    required this.updates,
  });

  final NoteUpdates updates;

  @override
  List<Object> get props => [updates];
}

class NotebookDeleteNote extends NotebookEvent {
  const NotebookDeleteNote({required this.noteId});

  final num noteId;

  @override
  List<Object> get props => [noteId];
}

class NotebookAddNoteBlock extends NotebookEvent {
  const NotebookAddNoteBlock({required this.type});

  final NoteBlockType type;

  @override
  List<Object> get props => [type];
}

class NotebookUpdateNoteBlock extends NotebookEvent {
  const NotebookUpdateNoteBlock({
    required this.block,
  });

  final NoteBlock block;

  @override
  List<Object> get props => [block];
}

class NotebookDeleteBlock extends NotebookEvent {
  const NotebookDeleteBlock({required this.blockId});

  final num blockId;

  @override
  List<Object> get props => [blockId];
}