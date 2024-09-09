import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_remove_task_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockRemoveTaskCommand', () {
    late TodoBlock todoBlock;
    late TodoBlockRemoveTaskCommand command;

    setUp(() {
      todoBlock = const TodoBlock(
        id: 1,
        items: [
          ChecklistItem(id: 1, title: 'Task 1', isChecked: false),
          ChecklistItem(id: 2, title: 'Task 2', isChecked: false),
        ],
      );
      command = TodoBlockRemoveTaskCommand(block: todoBlock, taskId: 1);
    });

    test('should remove the task with the given id from the todo block', () {
      final result = command.execute();

      expect(result.items.length, 1);
      expect(result.items.first.id, 2);
    });

    test('should return the original block on undo', () {
      final result = command.undo();

      expect(result.items.length, 2);
      expect(result.items.first.id, 1);
      expect(result.items.last.id, 2);
    });

    test('should have the correct ownerId', () {
      expect(command.ownerId, todoBlock.id);
    });

    test('should have the correct title', () {
      expect(command.getTitle(), "Todo Block: Remove task");
    });

    test('should have the correct type', () {
      expect(command.type, NotebookCommandType.todo);
    });
  });
}
