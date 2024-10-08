import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

class _TestNoteBlock extends NoteBlock {
  const _TestNoteBlock({
    required super.id,
    super.title = "",
    super.hasTitle = true,
    required super.type,
  });
}

void main() {
  group('NoteBlock', () {
    test('should create a NoteBlock instance with default values', () {
      const noteBlock = _TestNoteBlock(
        id: 1,
        type: NoteBlockType.text,
      );

      expect(noteBlock.id, 1);
      expect(noteBlock.title, "");
      expect(noteBlock.hasTitle, true);
      expect(noteBlock.type, NoteBlockType.text);
    });

    test('should create a NoteBlock instance with custom values', () {
      const noteBlock = _TestNoteBlock(
        id: 2,
        title: "Test Title",
        hasTitle: false,
        type: NoteBlockType.todo,
      );

      expect(noteBlock.id, 2);
      expect(noteBlock.title, "Test Title");
      expect(noteBlock.hasTitle, false);
      expect(noteBlock.type, NoteBlockType.todo);
    });

    test('should compare two NoteBlock instances with same values as equal',
        () {
      const noteBlock1 = _TestNoteBlock(
        id: 3,
        title: "Test Title",
        hasTitle: true,
        type: NoteBlockType.bookmarks,
      );

      const noteBlock2 = _TestNoteBlock(
        id: 3,
        title: "Test Title",
        hasTitle: true,
        type: NoteBlockType.bookmarks,
      );

      expect(noteBlock1, noteBlock2);
    });

    test(
        'should compare two NoteBlock instances with different values as not equal',
        () {
      const noteBlock1 = _TestNoteBlock(
        id: 4,
        title: "Title 1",
        hasTitle: true,
        type: NoteBlockType.text,
      );

      const noteBlock2 = _TestNoteBlock(
        id: 4,
        title: "Title 2",
        hasTitle: true,
        type: NoteBlockType.text,
      );

      expect(noteBlock1, isNot(noteBlock2));
    });
  });
}
