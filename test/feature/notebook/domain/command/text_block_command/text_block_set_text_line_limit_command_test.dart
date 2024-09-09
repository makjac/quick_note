import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_set_text_line_limit_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

void main() {
  group('TextBlockSetTextLineLimitCommand', () {
    late TextBlock block;
    late TextBlockSetTextLineLimitCommand command;

    setUp(() {
      block = const TextBlock(id: 1, text: 'Sample text', maxLines: 5);
      command =
          TextBlockSetTextLineLimitCommand(block: block, newLineLimit: 10);
    });

    test('should set new line limit on execute', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.maxLines, 10);
    });

    test('should return original block on undo', () {
      final originalBlock = command.undo();
      expect(originalBlock.maxLines, 5);
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Text Block: Set text line limit");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.text);
    });
  });
}
