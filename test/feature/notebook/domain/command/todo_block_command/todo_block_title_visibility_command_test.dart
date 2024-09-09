import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_title_visibility_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockTitleVisibilityCommand', () {
    late TodoBlock todoBlock;
    late TodoBlockTitleVisibilityCommand command;

    setUp(() {
      todoBlock = const TodoBlock(id: 1, hasTitle: false, items: []);
      command =
          TodoBlockTitleVisibilityCommand(block: todoBlock, isVisible: true);
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, todoBlock.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Todo Block: Change title visibility");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.todo);
    });

    test('should execute command and change title visibility', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.hasTitle, true);
    });

    test('should undo command and return original block', () {
      final originalBlock = command.undo();
      expect(originalBlock.hasTitle, false);
    });
  });
}
