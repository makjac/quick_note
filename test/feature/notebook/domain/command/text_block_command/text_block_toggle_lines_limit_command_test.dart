import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_toggle_lines_limit_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

void main() {
  group('TextBlockToggleLinesLimitCommand', () {
    late TextBlock block;
    late TextBlockToggleLinesLimitCommand command;

    setUp(() {
      block =
          const TextBlock(id: 1, text: 'Sample text', hasMaxLineLimit: false);
      command = TextBlockToggleLinesLimitCommand(
        block: block,
        newHasLinesLimit: true,
      );
    });

    test('should toggle lines limit when executed', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.hasMaxLineLimit, true);
    });

    test('should return original block when undone', () {
      command.execute();
      final originalBlock = command.undo();
      expect(originalBlock.hasMaxLineLimit, false);
    });

    test('should have correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should have correct title', () {
      expect(command.getTitle(), "Text Block: Toggle lines limit");
    });

    test('should have correct type', () {
      expect(command.type, NotebookCommandType.text);
    });
  });
}
