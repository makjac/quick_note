import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_toggle_hide_complete_tasks_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockToggleHideCompleteTasksCommand', () {
    late TodoBlock block;
    late TodoBlockToggleHideCompleteTasksCommand command;

    setUp(() {
      block = const TodoBlock(id: 1, showCompleteTasks: true, items: []);
      command = TodoBlockToggleHideCompleteTasksCommand(
          block: block, isVisible: false);
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Todo Block: Toggle hide complete tasks");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.todo);
    });

    test('should execute and toggle visibility of complete tasks', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.showCompleteTasks, false);
    });

    test('should undo and return original block', () {
      final originalBlock = command.undo();
      expect(originalBlock, block);
    });
  });
}
