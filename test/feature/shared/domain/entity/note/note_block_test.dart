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
  });
}
