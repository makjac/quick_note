import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_change_note_color_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

void main() {
  group('NotebookChangeNoteColorCommand Tests', () {
    late NotebookChangeNoteColorCommand command;
    late Note mockNote;
    late NoteColors initialColor;
    late NoteColors newColor;

    setUp(() {
      initialColor = NoteColors.color1;
      newColor = NoteColors.color2;

      mockNote = Note(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        color: initialColor,
      );

      command = NotebookChangeNoteColorCommand(
        note: mockNote,
        color: newColor,
      );
    });

    test('should return the correct title', () {
      expect(command.getTitle(), 'Change note color');
    });

    test('should return the correct type', () {
      expect(command.type, NotebookCommandType.global);
    });

    test('should execute and change note color', () {
      final result = command.execute();

      expect(result.color, newColor);
    });

    test('should undo and revert to previous color', () {
      command.execute();

      final result = command.undo();

      expect(result.color, initialColor);
    });
  });
}
