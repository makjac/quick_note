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
  const NotebookErrorState({super.note, required this.message});

  final String message;

  factory NotebookErrorState.fromState(NotebookState state, String message) {
    return NotebookErrorState(
      note: state.note,
      message: message,
    );
  }

  @override
  List<Object> get props => [note ?? _emptyNote, message];
}

class NotebookNoteDeleted extends NotebookState {}

Note _emptyNote = Note(
  id: -1,
  created: DateTime(1000),
  modified: DateTime(1010),
);
