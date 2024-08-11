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
  });
}
