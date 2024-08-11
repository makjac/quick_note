import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/todo_block.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/check_list_item.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/todo_block.module.dart';

void main() {
  group('TodoBlockModel', () {
    test('should create a TodoBlockModel instance with correct properties', () {
      final checklistItemModel1 = ChecklistItemModel(
        id: 1,
        title: 'Task 1',
        isChecked: true,
      );
      final checklistItemModel2 = ChecklistItemModel(
        id: 2,
        title: 'Task 2',
        isChecked: false,
      );

      final todoBlockModel = TodoBlockModel(
        id: 1,
        title: 'My Todo Block',
        hasTitle: true,
        items: [checklistItemModel1, checklistItemModel2],
        showCompleteTasks: true,
        showProgressBar: false,
        maxVisibleTasks: 5,
        dedline: DateTime(2024, 8, 10),
      );

      expect(todoBlockModel.id, 1);
      expect(todoBlockModel.title, 'My Todo Block');
      expect(todoBlockModel.hasTitle, true);
      expect(todoBlockModel.items, [checklistItemModel1, checklistItemModel2]);
      expect(todoBlockModel.showCompleteTasks, true);
      expect(todoBlockModel.showProgressBar, false);
      expect(todoBlockModel.maxVisibleTasks, 5);
      expect(todoBlockModel.dedline, DateTime(2024, 8, 10));
    });
  });
}
