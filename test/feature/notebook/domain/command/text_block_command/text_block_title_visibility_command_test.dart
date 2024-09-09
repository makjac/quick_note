import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/text_block_command/text_block_title_visibility_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';

void main() {
  group('TextBlockTitleVisibilityCommand', () {
    late TextBlock block;
    late TextBlockTitleVisibilityCommand command;

    setUp(() {
      block = const TextBlock(id: 1, hasTitle: false);
      command = TextBlockTitleVisibilityCommand(
        block: block,
        newTitleVisibility: true,
      );
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Text Block: Change title visibility");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.text);
    });

    test('should execute and change title visibility', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.hasTitle, true);
    });

    test('should undo and revert to original block', () {
      command.execute();
      final revertedBlock = command.undo();
      expect(revertedBlock.hasTitle, false);
    });
  });
}
