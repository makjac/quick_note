import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_remove_note_block_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';

void main() {
  group('NotebookRemoveNoteBlockCommand Tests', () {
    late NotebookRemoveNoteBlockCommand command;
    late Note mockNote;
    late List<NoteBlock> initialContent;
    late TextBlock blockToRemove;
    late num blockIdToRemove;

    setUp(() {
      blockIdToRemove = 1;
      blockToRemove = TextBlock(
        id: blockIdToRemove,
        text: 'Text to remove',
      );
      const otherBlock = TextBlock(
        id: 2,
        text: 'Other text',
      );

      initialContent = [blockToRemove, otherBlock];
      mockNote = Note(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        content: initialContent,
      );

      command = NotebookRemoveNoteBlockCommand(
        note: mockNote,
        blockId: blockIdToRemove,
      );
    });

    test('should return the correct title', () {
      expect(command.getTitle(), 'Remove note block');
    });

    test('should return the correct type', () {
      expect(command.type, NotebookCommandType.global);
    });

    test('should execute and remove note block by blockId', () {
      final result = command.execute();

      expect(result.content, [initialContent[1]]);
    });

    test('should undo and restore previous content', () {
      command.execute();

      final result = command.undo();

      expect(result.content, initialContent);
    });
  });
}
