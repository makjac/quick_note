import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

void main() {
  group('NoteBlockType', () {
    test('should have correct values', () {
      expect(NoteBlockType.text.name, 'text');
      expect(NoteBlockType.todo.name, 'todo');
      expect(NoteBlockType.bookmarks.name, 'bookmarks');
    });
  });
}
