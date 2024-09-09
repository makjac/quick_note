part of 'notebook_bloc.dart';

class NotebookState extends Equatable {
  const NotebookState({this.note});

  final Note? note;

  NotebookState copyWith({Note? note}) {
    return NotebookState(
      note: note ?? this.note,
    );
  }

  @override
  List<Object> get props => [note ?? _emptyNote];
}

final class NotebookInitial extends NotebookState {}

class NotebookErrorState extends NotebookState {
  factory NotebookErrorState.fromState(NotebookState state, String message) {
    return NotebookErrorState(
      note: state.note,
      message: message,
    );
  }

  const NotebookErrorState({super.note, required this.message});

  final String message;

  @override
  List<Object> get props => [note ?? _emptyNote, message];
}

class NotebookNoteDeleted extends NotebookState {}

class NotebookNoteBlockAdded extends NotebookState {
  factory NotebookNoteBlockAdded.fromState(
      NotebookState state, NoteBlock block) {
    return NotebookNoteBlockAdded(
      note: state.note,
      block: block,
    );
  }

  const NotebookNoteBlockAdded({super.note, required this.block});

  final NoteBlock block;

  @override
  List<Object> get props => [super.props, block];
}

class NotebookUndoRedoState extends NotebookState {
  factory NotebookUndoRedoState.fromState(NotebookState state) {
    return NotebookUndoRedoState(
      note: state.note,
    );
  }

  const NotebookUndoRedoState({super.note});

  @override
  List<Object> get props => [super.props];
}

class NotebookNoteBlockCommand extends NotebookState {
  factory NotebookNoteBlockCommand.fromState(
      NotebookState state, NotebookCommand command,
      [bool? isUndo]) {
    return NotebookNoteBlockCommand(
      note: state.note,
      command: command,
      isUndo: isUndo ?? true,
    );
  }

  const NotebookNoteBlockCommand({
    super.note,
    required this.command,
    this.isUndo = true,
  });

  final NotebookCommand command;
  final bool isUndo;

  @override
  List<Object> get props => [super.props, command, isUndo];
}

Note _emptyNote = Note(
  id: -1,
  created: DateTime(1000),
  modified: DateTime(1010),
);
