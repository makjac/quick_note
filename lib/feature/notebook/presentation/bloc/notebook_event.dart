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

class NotebookMoveToTrash extends NotebookEvent {}

class NotebookAddNoteBlock extends NotebookEvent {
  const NotebookAddNoteBlock({required this.type});

  final NoteBlockType type;

  @override
  List<Object> get props => [type];
}

class NotebookUpdateNoteBlock extends NotebookEvent {
  const NotebookUpdateNoteBlock({
    required this.block,
    this.command,
  });

  final NoteBlock block;
  final NotebookCommand? command;

  @override
  List<Object> get props => [block, command ?? -1];
}

class NotebookDeleteBlock extends NotebookEvent {
  const NotebookDeleteBlock({required this.blockId});

  final num blockId;

  @override
  List<Object> get props => [blockId];
}

class NotebookChangeColor extends NotebookEvent {
  const NotebookChangeColor({required this.color});

  final NoteColors color;

  @override
  List<Object> get props => [color];
}

class NotebookToggleStar extends NotebookEvent {}

class NotebookToggleArchive extends NotebookEvent {}

class NotebookDeleteNote extends NotebookEvent {}

class NotebookChangeNoteTitle extends NotebookEvent {
  const NotebookChangeNoteTitle({required this.title});

  final String title;

  @override
  List<Object> get props => [title];
}
