import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_change_note_title_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';

void main() {
  group('NotebookState', () {
    final testNote = Note(
      id: 1,
      created: DateTime.now(),
      modified: DateTime.now(),
    );

    test('supports value equality', () {
      expect(
        NotebookState(note: testNote),
        equals(NotebookState(note: testNote)),
      );
    });

    test('props include note', () {
      expect(
        NotebookState(note: testNote).props,
        equals([testNote]),
      );
    });

    test('copyWith returns a new instance with updated note', () {
      final initialState = NotebookState(note: testNote);
      final newState = initialState.copyWith(note: testNote);

      expect(newState.note, equals(testNote));
      expect(newState, equals(initialState));
    });

    test('NotebookInitial is a subclass of NotebookState', () {
      expect(NotebookInitial(), isA<NotebookState>());
    });

    test('NotebookErrorState can be created from state with message', () {
      final state = NotebookState(note: testNote);
      final errorState = NotebookErrorState.fromState(state, 'Error message');

      expect(errorState.note, equals(testNote));
      expect(errorState.message, equals('Error message'));
      expect(errorState, isA<NotebookErrorState>());
    });

    test('NotebookErrorState props include note and message', () {
      final errorState =
          NotebookErrorState(note: testNote, message: 'Error message');

      expect(
        errorState.props,
        equals([testNote, 'Error message']),
      );
    });

    test('NotebookNoteDeleted is a subclass of NotebookState', () {
      expect(NotebookNoteDeleted(), isA<NotebookState>());
    });

    test('NotebookUndoRedoState can be created from state', () {
      final state = NotebookState(note: testNote);
      final undoRedoState = NotebookUndoRedoState.fromState(state);

      expect(undoRedoState.note, equals(testNote));
      expect(undoRedoState, isA<NotebookUndoRedoState>());
    });
  });
}
