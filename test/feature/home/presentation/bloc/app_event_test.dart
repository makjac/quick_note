import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

void main() {
  group('AppEvent', () {
    test('AppLoadCachedNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppLoadCachedNotes();

      // Assert
      expect(event, isA<AppLoadCachedNotes>());
      expect(event.props, []);
    });

    test('AppCreateNote should be instantiated correctly', () {
      // Arrange & Act
      final event = AppCreateNote();

      // Assert
      expect(event, isA<AppCreateNote>());
      expect(event.props, []);
    });

    test('AppDeleteSingleNote should be instantiated correctly with id', () {
      // Arrange
      const id = 1;
      const event = AppDeleteSingleNote(id: id);

      // Assert
      expect(event, isA<AppDeleteSingleNote>());
      expect(event.id, id);
      expect(event.props, [id]);
    });

    test('AppDeleteAllNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppDeleteAllNotes();

      // Assert
      expect(event, isA<AppDeleteAllNotes>());
      expect(event.props, []);
    });

    test('AppDeleteSelectedNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppDeleteSelectedNotes();

      // Assert
      expect(event, isA<AppDeleteSelectedNotes>());
      expect(event.props, []);
    });

    test(
        'AppUpdateSingleNote should be instantiated correctly with note and updates',
        () {
      // Arrange
      final note = Note(
        id: 1,
        title: 'Test Note',
        content: const [],
        created: DateTime.now(),
        modified: DateTime.now(),
      );
      const updates = NoteUpdates(
        title: 'Updated Note',
      );
      final event = AppUpdateSingleNote(
        note: note,
        updates: updates,
      );

      // Assert
      expect(event, isA<AppUpdateSingleNote>());
      expect(event.note, note);
      expect(event.updates, updates);
      expect(event.props, [note, updates]);
    });

    test('AppUpdateSelectedNotes should be instantiated correctly with updates',
        () {
      // Arrange
      const updates = NoteUpdates(
        title: 'Updated Note',
      );
      const event = AppUpdateSelectedNotes(updates: updates);

      // Assert
      expect(event, isA<AppUpdateSelectedNotes>());
      expect(event.updates, updates);
      expect(event.props, [updates]);
    });

    test('AppStarSelectedNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppStarSelectedNotes();

      // Assert
      expect(event, isA<AppStarSelectedNotes>());
      expect(event.props, []);
    });

    test('AppArchiveSelectedNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppArchiveSelectedNotes();

      // Assert
      expect(event, isA<AppArchiveSelectedNotes>());
      expect(event.props, []);
    });

    test('AppSelectNote should be instantiated correctly with noteId', () {
      // Arrange
      const noteId = 1;
      const event = AppSelectNote(noteId: noteId);

      // Assert
      expect(event, isA<AppSelectNote>());
      expect(event.noteId, noteId);
      expect(event.props, [noteId]);
    });

    test('AppUnselectAllNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppUnselectAllNotes();

      // Assert
      expect(event, isA<AppUnselectAllNotes>());
      expect(event.props, []);
    });

    test('AppSelectAllNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppSelectAllNotes();

      // Assert
      expect(event, isA<AppSelectAllNotes>());
      expect(event.props, []);
    });

    test('AppSetSearchTerm should be instantiated correctly', () {
      // Arrange & Act
      final event = AppSetSearchTerm();

      // Assert
      expect(event, isA<AppSetSearchTerm>());
      expect(event.props, []);
    });

    test('AppClearSearchTerm should be instantiated correctly', () {
      // Arrange & Act
      final event = AppClearSearchTerm();

      // Assert
      expect(event, isA<AppClearSearchTerm>());
      expect(event.props, []);
    });

    test('AppMoveSelectedNotesToTrash should be instantiated correctly', () {
      // Arrange & Act
      final event = AppMoveSelectedNotesToTrash();

      // Assert
      expect(event, isA<AppMoveSelectedNotesToTrash>());
      expect(event.props, []);
    });

    test('AppMoveToTrashSingleNote should be instantiated correctly with note',
        () {
      // Arrange
      final note = Note(
        id: 1,
        title: 'Test Note',
        content: const [],
        created: DateTime.now(),
        modified: DateTime.now(),
      );
      final event = AppMoveToTrashSingleNote(note: note);

      // Assert
      expect(event, isA<AppMoveToTrashSingleNote>());
      expect(event.note, note);
      expect(event.props, [note]);
    });

    test('AppRestoreSelectedNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppRestoreSelectedNotes();

      // Assert
      expect(event, isA<AppRestoreSelectedNotes>());
      expect(event.props, []);
    });

    test('AppRestoreSingleNote should be instantiated correctly with note', () {
      // Arrange
      final note = Note(
        id: 1,
        title: 'Test Note',
        content: const [],
        created: DateTime.now(),
        modified: DateTime.now(),
      );
      final event = AppRestoreSingleNote(note: note);

      // Assert
      expect(event, isA<AppRestoreSingleNote>());
      expect(event.note, note);
      expect(event.props, [note]);
    });

    test('AppEmptyRecycleBin should be instantiated correctly', () {
      // Arrange & Act
      final event = AppEmptyRecycleBin();

      // Assert
      expect(event, isA<AppEmptyRecycleBin>());
      expect(event.props, []);
    });

    test('AppCheckDeleteNotes should be instantiated correctly', () {
      // Arrange & Act
      final event = AppCheckDeleteNotes();

      // Assert
      expect(event, isA<AppCheckDeleteNotes>());
      expect(event.props, []);
    });
  });
}
