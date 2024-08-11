import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';

void main() {
  group('AppState', () {
    test('should create an instance with default values', () {
      // Act
      const state = AppState();

      // Assert
      expect(state.notes, []);
      expect(state.selectedNoteIds, []);
      expect(state.isSelecting, false);
    });

    test('should return new instance with updated values using copyWith', () {
      // Arrange
      final initialState = AppState(
        notes: [
          Note(
              id: 1,
              title: 'Note 1',
              content: const [],
              created: DateTime.now(),
              modified: DateTime.now())
        ],
        selectedNoteIds: const {1},
        isSelecting: true,
      );

      // Act
      final updatedState = initialState.copyWith(
        notes: [
          Note(
              id: 2,
              title: 'Note 2',
              content: const [],
              created: DateTime.now(),
              modified: DateTime.now())
        ],
        isSelecting: false,
      );

      // Assert
      expect(updatedState.notes.length, 1);
      expect(updatedState.notes.first.id, 2);
      expect(updatedState.selectedNoteIds, {1});
      expect(updatedState.isSelecting, false);
    });
  });

  group('AppNoteCreated', () {
    test('should create an instance with provided values', () {
      // Arrange
      const noteId = 1;
      const state = AppNoteCreated(
        createdNoteId: noteId,
      );

      // Act & Assert
      expect(state.createdNoteId, noteId);
      expect(state.notes, []);
      expect(state.selectedNoteIds, []);
      expect(state.isSelecting, false);
    });

    test('should correctly create AppNoteCreated from AppState using fromState',
        () {
      // Arrange
      final initialState = AppState(
        notes: [
          Note(
              id: 1,
              title: 'Note 1',
              content: const [],
              created: DateTime.now(),
              modified: DateTime.now())
        ],
        selectedNoteIds: const {1},
        isSelecting: true,
      );
      const createdNoteId = 2;

      // Act
      final newState = AppNoteCreated.fromState(initialState, createdNoteId);

      // Assert
      expect(newState.notes, initialState.notes);
      expect(newState.selectedNoteIds, initialState.selectedNoteIds);
      expect(newState.isSelecting, initialState.isSelecting);
      expect(newState.createdNoteId, createdNoteId);
    });
  });

  group('AppError', () {
    test('should create an instance with provided values', () {
      // Arrange
      const errorMessage = 'An error occurred';
      const state = AppError(
        errorMessage: errorMessage,
      );

      // Act & Assert
      expect(state.errorMessage, errorMessage);
      expect(state.notes, []);
      expect(state.selectedNoteIds, []);
      expect(state.isSelecting, false);
    });

    test('should correctly create AppError from AppState using fromState', () {
      // Arrange
      final initialState = AppState(
        notes: [
          Note(
              id: 1,
              title: 'Note 1',
              content: const [],
              created: DateTime.now(),
              modified: DateTime.now())
        ],
        selectedNoteIds: const {1},
        isSelecting: true,
      );
      const errorMessage = 'An error occurred';

      // Act
      final errorState = AppError.fromState(initialState, errorMessage);

      // Assert
      expect(errorState.notes, initialState.notes);
      expect(errorState.selectedNoteIds, initialState.selectedNoteIds);
      expect(errorState.isSelecting, initialState.isSelecting);
      expect(errorState.errorMessage, errorMessage);
    });
  });
}
