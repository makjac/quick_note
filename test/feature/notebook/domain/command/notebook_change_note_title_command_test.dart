import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_change_note_title_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

void main() {
  group('NotebookChangeNoteTitleCommand Tests', () {
    late NotebookChangeNoteTitleCommand command;
    late Note mockNote;
    late String initialTitle;
    late String newTitle;

    setUp(() {
      initialTitle = 'Old Title';
      newTitle = 'New Title';

      mockNote = Note(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        title: initialTitle,
      );

      command = NotebookChangeNoteTitleCommand(
        note: mockNote,
        newTitle: newTitle,
      );
    });

    test('should return the correct title', () {
      expect(command.getTitle(), 'Change note title');
    });

    test('should return the correct type', () {
      expect(command.type, NotebookCommandType.global);
    });

    test('should execute and change note title', () {
      final result = command.execute();

      expect(result.title, newTitle);
    });

    test('should undo and revert to previous title', () {
      command.execute();

      final result = command.undo();

      expect(result.title, initialTitle);
    });
  });
}
