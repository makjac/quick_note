import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/todo/check_list_item.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/todo/check_list_item.module.dart';

void main() {
  group('ChecklistItemModel', () {
    test('should create a ChecklistItemModel instance with correct properties',
        () {
      final checklistItemModel = ChecklistItemModel(
        id: 1,
        title: 'Sample Item',
        isChecked: true,
      );

      expect(checklistItemModel.id, 1);
      expect(checklistItemModel.title, 'Sample Item');
      expect(checklistItemModel.isChecked, true);
    });
  });
}
