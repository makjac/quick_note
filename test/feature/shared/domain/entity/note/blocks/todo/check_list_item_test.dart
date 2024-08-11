import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';

void main() {
  group('ChecklistItem', () {
    test('should create a ChecklistItem instance with default values', () {
      const checklistItem = ChecklistItem(
        id: 1,
      );

      expect(checklistItem.id, 1);
      expect(checklistItem.title, "");
      expect(checklistItem.isChecked, false);
    });

    test('should create a ChecklistItem instance with custom values', () {
      const checklistItem = ChecklistItem(
        id: 2,
        title: "Sample Task",
        isChecked: true,
      );

      expect(checklistItem.id, 2);
      expect(checklistItem.title, "Sample Task");
      expect(checklistItem.isChecked, true);
    });

    test('should copy ChecklistItem with updated values using copyWith', () {
      const checklistItem = ChecklistItem(
        id: 3,
        title: "Original Task",
        isChecked: false,
      );

      final copiedItem = checklistItem.copyWith(
        title: "Updated Task",
        isChecked: true,
      );

      expect(copiedItem.id, 3); // id remains the same
      expect(copiedItem.title, "Updated Task");
      expect(copiedItem.isChecked, true);
    });

    test('should compare two ChecklistItem instances with same values as equal',
        () {
      const checklistItem1 = ChecklistItem(
        id: 4,
        title: "Task 1",
        isChecked: false,
      );

      const checklistItem2 = ChecklistItem(
        id: 4,
        title: "Task 1",
        isChecked: false,
      );

      expect(checklistItem1, checklistItem2);
    });

    test(
        'should compare two ChecklistItem instances with different values as not equal',
        () {
      const checklistItem1 = ChecklistItem(
        id: 5,
        title: "Task 1",
        isChecked: false,
      );

      const checklistItem2 = ChecklistItem(
        id: 5,
        title: "Task 2",
        isChecked: true,
      );

      expect(checklistItem1, isNot(checklistItem2));
    });
  });
}
