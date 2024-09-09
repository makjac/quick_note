import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_change_title_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

void main() {
  group('TextBlockChangeTitleCommand', () {
    late TextBlock block;
    late TextBlockChangeTitleCommand command;

    setUp(() {
      block = const TextBlock(id: 1, title: 'Old Title', text: 'Some content');
      command =
          TextBlockChangeTitleCommand(block: block, newTitle: 'New Title');
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), 'Text Block: Change title');
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.text);
    });

    test('should change the title of the text block on execute', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.title, 'New Title');
    });

    test('should return the original block on undo', () {
      command.execute();
      final originalBlock = command.undo();
      expect(originalBlock.title, 'Old Title');
    });
  });
}
