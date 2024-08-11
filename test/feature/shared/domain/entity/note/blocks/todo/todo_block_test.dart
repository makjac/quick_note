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
  });
}
