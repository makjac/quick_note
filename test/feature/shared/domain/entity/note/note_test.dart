import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

void main() {
  group('Note', () {
    test('should create a Note instance with default values', () {
      final note = Note(
        id: 1,
        created: DateTime(2023, 8, 10),
        modified: DateTime(2023, 8, 11),
      );

      expect(note.id, 1);
      expect(note.created, DateTime(2023, 8, 10));
      expect(note.modified, DateTime(2023, 8, 11));
      expect(note.expiryDate, isNull);
      expect(note.title, "");
      expect(note.content, []);
      expect(note.archived, false);
      expect(note.author, isNull);
      expect(note.isStarred, false);
      expect(note.color, NoteColors.color1);
    });
  });
}
