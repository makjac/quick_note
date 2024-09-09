import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_add_task_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockAddTaskCommand Tests', () {
    late TodoBlockAddTaskCommand command;
    late TodoBlock mockTodoBlock;
    late List<ChecklistItem> initialItems;

    setUp(() {
      const newTaskItem = ChecklistItem(
        id: 1,
        title: 'New Task',
        isChecked: false,
      );

      initialItems = [
        const ChecklistItem(id: 2, title: 'Existing Task', isChecked: false),
      ];

      mockTodoBlock = TodoBlock(
        id: 123,
        items: initialItems,
      );

      command = TodoBlockAddTaskCommand(
        block: mockTodoBlock,
        newTaskItem: newTaskItem,
      );
    });

    test('should return the correct title', () {
      expect(command.getTitle(), 'Todo Block: Add task');
    });

    test('should return the correct type', () {
      expect(command.type, NotebookCommandType.todo);
    });

    test('should execute and add new task item to TodoBlock', () {
      final result = command.execute();

      expect(result.items, [
        ...initialItems,
        const ChecklistItem(id: 1, title: 'New Task', isChecked: false)
      ]);
      expect(result.items.length, initialItems.length + 1);
    });

    test('should undo and return the original TodoBlock', () {
      command.execute();

      final result = command.undo();

      expect(result.items, initialItems);
    });
  });
}
