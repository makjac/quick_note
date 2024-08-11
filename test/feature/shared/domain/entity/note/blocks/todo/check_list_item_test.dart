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
  });
}
