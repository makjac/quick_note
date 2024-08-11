import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

void main() {
  group('TodoBlock', () {
    test('should create a TodoBlock instance with default values', () {
      const todoBlock = TodoBlock(
        id: 1,
        items: [],
      );

      expect(todoBlock.id, 1);
      expect(todoBlock.title, "");
      expect(todoBlock.hasTitle, true);
      expect(todoBlock.type, NoteBlockType.todo);
      expect(todoBlock.items, []);
      expect(todoBlock.showCompleteTasks, false);
      expect(todoBlock.showProgressBar, false);
      expect(todoBlock.maxVisibleTasks, isNull);
      expect(todoBlock.dedline, isNull);
    });

    test('should create a TodoBlock instance with custom values', () {
      final items = [
        const ChecklistItem(id: 1, title: "Task 1", isChecked: false),
        const ChecklistItem(id: 2, title: "Task 2", isChecked: true),
      ];

      final dedline = DateTime.now().add(const Duration(days: 7));

      final todoBlock = TodoBlock(
        id: 2,
        title: "My Todo List",
        hasTitle: false,
        items: items,
        showCompleteTasks: true,
        showProgressBar: true,
        maxVisibleTasks: 5,
        dedline: dedline,
      );

      expect(todoBlock.id, 2);
      expect(todoBlock.title, "My Todo List");
      expect(todoBlock.hasTitle, false);
      expect(todoBlock.type, NoteBlockType.todo);
      expect(todoBlock.items, items);
      expect(todoBlock.showCompleteTasks, true);
      expect(todoBlock.showProgressBar, true);
      expect(todoBlock.maxVisibleTasks, 5);
      expect(todoBlock.dedline, dedline);
    });
  });
}
