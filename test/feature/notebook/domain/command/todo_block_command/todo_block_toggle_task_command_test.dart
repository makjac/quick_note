import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_toggle_task_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockToggleTaskCommand', () {
    late TodoBlock block;
    late TodoBlockToggleTaskCommand command;

    setUp(() {
      block = const TodoBlock(
        id: 1,
        items: [
          ChecklistItem(id: 1, title: 'Task 1', isChecked: false),
          ChecklistItem(id: 2, title: 'Task 2', isChecked: true),
        ],
      );
      command = TodoBlockToggleTaskCommand(block: block, taskId: 1);
    });

    test('should toggle the task status', () {
      final result = command.execute();

      expect(result.items[0].isChecked, true);
      expect(result.items[1].isChecked, true);
    });

    test('should return the original block on undo', () {
      final result = command.undo();

      expect(result.items[0].isChecked, false);
      expect(result.items[1].isChecked, true);
    });

    test('should have correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should have correct title', () {
      expect(command.getTitle(), "Todo Block: Toggle task");
    });

    test('should have correct type', () {
      expect(command.type, NotebookCommandType.todo);
    });
  });
}
