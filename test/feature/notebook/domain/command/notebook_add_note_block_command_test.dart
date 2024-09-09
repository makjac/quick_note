import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_add_note_block_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

void main() {
  group('NotebookAddNoteBlockCommand Tests', () {
    late NotebookAddNoteBlockCommand command;
    late Note mockNote;
    late TextBlock mockTextBlock;
    late List<NoteBlock> initialContent;

    setUp(() {
      mockTextBlock = const TextBlock(
        id: 1,
        text: 'Sample text',
      );

      initialContent = [
        const TextBlock(
          id: 1,
          text: 'Sample text',
        ),
      ];
      mockNote = Note(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        content: initialContent,
      );

      command = NotebookAddNoteBlockCommand(
        note: mockNote,
        noteBlock: mockTextBlock,
      );
    });

    test('should return the correct title', () {
      expect(command.getTitle(), 'Add note block');
    });

    test('should return the correct type', () {
      expect(command.type, NotebookCommandType.global);
    });

    test('should execute and add note block to content', () {
      final result = command.execute();

      expect(result.content, contains(mockTextBlock));
      expect(result.content?.length, initialContent.length + 1);
    });

    test('should undo and revert to previous content', () {
      command.execute();

      final result = command.undo();

      expect(result.content, initialContent);
    });
  });
}
