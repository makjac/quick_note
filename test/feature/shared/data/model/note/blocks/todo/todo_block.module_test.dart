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

    test('should convert TodoBlock to TodoBlockModel using fromEntity', () {
      const checklistItem = ChecklistItem(
        id: 1,
        title: 'Task 1',
        isChecked: true,
      );
      final todoBlock = TodoBlock(
        id: 1,
        title: 'My Todo Block',
        hasTitle: true,
        items: const [checklistItem],
        showCompleteTasks: true,
        showProgressBar: false,
        maxVisibleTasks: 5,
        dedline: DateTime(2024, 8, 10),
      );

      final todoBlockModel = TodoBlockModel.fromEntity(todoBlock);

      expect(todoBlockModel.id, todoBlock.id);
      expect(todoBlockModel.title, todoBlock.title);
      expect(todoBlockModel.hasTitle, todoBlock.hasTitle);
      expect(todoBlockModel.items.length, todoBlock.items.length);
      expect(todoBlockModel.items[0].id, todoBlock.items[0].id);
      expect(todoBlockModel.showCompleteTasks, todoBlock.showCompleteTasks);
      expect(todoBlockModel.showProgressBar, todoBlock.showProgressBar);
      expect(todoBlockModel.maxVisibleTasks, todoBlock.maxVisibleTasks);
      expect(todoBlockModel.dedline, todoBlock.dedline);
    });

    test(
        'should compare two TodoBlockModel instances with the same values as equal',
        () {
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

      final todoBlockModel1 = TodoBlockModel(
        id: 1,
        title: 'My Todo Block',
        hasTitle: true,
        items: [checklistItemModel1, checklistItemModel2],
        showCompleteTasks: true,
        showProgressBar: false,
        maxVisibleTasks: 5,
        dedline: DateTime(2024, 8, 10),
      );

      final todoBlockModel2 = TodoBlockModel(
        id: 1,
        title: 'My Todo Block',
        hasTitle: true,
        items: [checklistItemModel1, checklistItemModel2],
        showCompleteTasks: true,
        showProgressBar: false,
        maxVisibleTasks: 5,
        dedline: DateTime(2024, 8, 10),
      );

      expect(todoBlockModel1, todoBlockModel2);
    });

    test(
        'should compare two TodoBlockModel instances with different values as not equal',
        () {
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

      final todoBlockModel1 = TodoBlockModel(
        id: 1,
        title: 'My Todo Block',
        hasTitle: true,
        items: [checklistItemModel1, checklistItemModel2],
        showCompleteTasks: true,
        showProgressBar: false,
        maxVisibleTasks: 5,
        dedline: DateTime(2024, 8, 10),
      );

      final todoBlockModel2 = TodoBlockModel(
        id: 2,
        title: 'Different Todo Block',
        hasTitle: false,
        items: [checklistItemModel1],
        showCompleteTasks: false,
        showProgressBar: true,
        maxVisibleTasks: 10,
        dedline: DateTime(2024, 12, 31),
      );

      expect(todoBlockModel1, isNot(todoBlockModel2));
    });
  });
}
