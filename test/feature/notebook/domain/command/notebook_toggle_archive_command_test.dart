import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_toggle_archive_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

void main() {
  group('NotebookToggleArchiveCommand Tests', () {
    late NotebookToggleArchiveCommand command;
    late Note mockNote;
    late bool initialArchivedStatus;

    setUp(() {
      initialArchivedStatus = false;

      mockNote = Note(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        archived: initialArchivedStatus,
      );

      command = NotebookToggleArchiveCommand(
        note: mockNote,
      );
    });

    test('should return the correct title', () {
      expect(command.getTitle(), 'Toggle note archive');
    });

    test('should return the correct type', () {
      expect(command.type, NotebookCommandType.global);
    });

    test('should execute and toggle the archived status', () {
      final result = command.execute();

      expect(result.archived, !initialArchivedStatus);
    });

    test('should undo and restore the previous archived status', () {
      command.execute();

      final result = command.undo();

      expect(result.archived, initialArchivedStatus);
    });
  });
}
