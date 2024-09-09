import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_toggle_note_star_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

void main() {
  group('NotebookToggleNoteStarCommand Tests', () {
    late NotebookToggleNoteStarCommand command;
    late Note mockNote;
    late bool initialIsStarredStatus;

    setUp(() {
      initialIsStarredStatus = false;

      mockNote = Note(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        isStarred: initialIsStarredStatus,
      );

      command = NotebookToggleNoteStarCommand(
        note: mockNote,
      );
    });

    test('should return the correct title', () {
      expect(command.getTitle(), 'Toggle note star');
    });

    test('should return the correct type', () {
      expect(command.type, NotebookCommandType.global);
    });

    test('should execute and toggle the isStarred status', () {
      final result = command.execute();

      expect(result.isStarred, !initialIsStarredStatus);
    });

    test('should undo and restore the previous isStarred status', () {
      command.execute();

      final result = command.undo();

      expect(result.isStarred, initialIsStarredStatus);
    });
  });
}
