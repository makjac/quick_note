import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_rename_task_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockRenameTaskCommand', () {
    late TodoBlock block;
    late TodoBlockRenameTaskCommand command;

    setUp(() {
      block = const TodoBlock(
        id: 1,
        items: [
          ChecklistItem(id: 1, title: 'Task 1'),
          ChecklistItem(id: 2, title: 'Task 2'),
        ],
      );
      command = TodoBlockRenameTaskCommand(
        block: block,
        taskId: 1,
        newTaskName: 'Updated Task 1',
      );
    });

    test('should rename the task with the given taskId', () {
      final updatedBlock = command.execute();

      expect(updatedBlock.items.firstWhere((item) => item.id == 1).title,
          'Updated Task 1');
      expect(updatedBlock.items.firstWhere((item) => item.id == 2).title,
          'Task 2');
    });

    test('should not change other tasks', () {
      final updatedBlock = command.execute();

      expect(updatedBlock.items.firstWhere((item) => item.id == 2).title,
          'Task 2');
    });

    test('should return the original block on undo', () {
      command.execute();
      final originalBlock = command.undo();

      expect(originalBlock, block);
      expect(originalBlock.items.firstWhere((item) => item.id == 1).title,
          'Task 1');
    });

    test('should have correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should have correct title', () {
      expect(command.getTitle(), 'Todo Block: Rename task');
    });

    test('should have correct type', () {
      expect(command.type, NotebookCommandType.todo);
    });
  });
}
