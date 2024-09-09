import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/todo_block_command/todo_block_reorder_tasks_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';

void main() {
  group('TodoBlockReorderTasksCommand', () {
    late TodoBlock block;
    late TodoBlockReorderTasksCommand command;

    setUp(() {
      block = const TodoBlock(
        id: 1,
        items: [
          ChecklistItem(id: 1, title: 'Task 1', isChecked: false),
          ChecklistItem(id: 2, title: 'Task 2', isChecked: false),
          ChecklistItem(id: 3, title: 'Task 3', isChecked: false),
        ],
      );
    });

    test('reorders tasks correctly', () {
      command = TodoBlockReorderTasksCommand(
        block: block,
        oldIndex: 0,
        newIndex: 2,
      );

      final result = command.execute();

      expect(result.items[0].id, 2);
      expect(result.items[1].id, 3);
      expect(result.items[2].id, 1);
    });

    test('returns the same block if indices are out of range', () {
      command = TodoBlockReorderTasksCommand(
        block: block,
        oldIndex: -1,
        newIndex: 2,
      );

      final result = command.execute();

      expect(result, block);

      command = TodoBlockReorderTasksCommand(
        block: block,
        oldIndex: 0,
        newIndex: 3,
      );

      final result2 = command.execute();

      expect(result2, block);
    });

    test('undo returns the original block', () {
      command = TodoBlockReorderTasksCommand(
        block: block,
        oldIndex: 0,
        newIndex: 2,
      );

      final result = command.undo();

      expect(result, block);
    });
  });
}
