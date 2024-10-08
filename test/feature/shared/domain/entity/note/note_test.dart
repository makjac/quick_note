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

    test('should create a Note instance with custom values', () {
      const noteBlock = TextBlock(id: 1, text: 'Example content');
      final note = Note(
        id: 2,
        created: DateTime(2023, 8, 10),
        modified: DateTime(2023, 8, 11),
        expiryDate: DateTime(2023, 12, 31),
        title: "Test Note",
        content: const [noteBlock],
        archived: true,
        author: "John Doe",
        isStarred: true,
        color: NoteColors.color5,
      );

      expect(note.id, 2);
      expect(note.created, DateTime(2023, 8, 10));
      expect(note.modified, DateTime(2023, 8, 11));
      expect(note.expiryDate, DateTime(2023, 12, 31));
      expect(note.title, "Test Note");
      expect(note.content, [noteBlock]);
      expect(note.archived, true);
      expect(note.author, "John Doe");
      expect(note.isStarred, true);
      expect(note.color, NoteColors.color5);
    });

    test('should compare two Note instances with same values as equal', () {
      final note1 = Note(
        id: 3,
        created: DateTime(2023, 8, 10),
        modified: DateTime(2023, 8, 11),
      );

      final note2 = Note(
        id: 3,
        created: DateTime(2023, 8, 10),
        modified: DateTime(2023, 8, 11),
      );

      expect(note1, note2);
    });

    test('should compare two Note instances with different values as not equal',
        () {
      final note1 = Note(
        id: 4,
        created: DateTime(2023, 8, 10),
        modified: DateTime(2023, 8, 11),
        title: "Note 1",
      );

      final note2 = Note(
        id: 4,
        created: DateTime(2023, 8, 10),
        modified: DateTime(2023, 8, 11),
        title: "Note 2",
      );

      expect(note1, isNot(note2));
    });
  });
}
