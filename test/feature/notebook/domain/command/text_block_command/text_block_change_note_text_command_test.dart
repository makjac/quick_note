import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_change_note_text_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

void main() {
  group('TextBlockChangeNoteTextCommand', () {
    late TextBlock initialBlock;
    late TextBlockChangeNoteTextCommand command;

    setUp(() {
      initialBlock = const TextBlock(id: 1, text: 'Initial Text');
      command = TextBlockChangeNoteTextCommand(
        block: initialBlock,
        newNoteText: 'New Text',
      );
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, initialBlock.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), 'Text Block: Change note text');
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.text);
    });

    test('should execute and change the text of the block', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.text, 'New Text');
    });

    test('should undo and return the original block', () {
      command.execute();
      final undoneBlock = command.undo();
      expect(undoneBlock.text, 'Initial Text');
    });
  });
}
