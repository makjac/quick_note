import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/import-export/domain/entity/note_data_package.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

void main() {
  group('NoteDataPackage', () {
    final note1 = Note(
      id: 1,
      title: 'Note 1',
      content: const [TextBlock(id: 1, text: 'Content 1')],
      created: DateTime(2023, 1, 1),
      modified: DateTime(2023, 1, 1),
    );
    final note2 = Note(
      id: 2,
      title: 'Note 2',
      content: const [TextBlock(id: 1, text: 'Content 2')],
      created: DateTime(2023, 1, 2),
      modified: DateTime(2023, 1, 3),
    );

    final notes = [note1, note2];
    final creationDate = DateTime(2023, 1, 3);
    const exportedBy = 'User1';
    const exportVersion = '1.0.0';
    const description = 'Test description';

    test('should create a NoteDataPackage with given parameters', () {
      final package = NoteDataPackage(
        notes: notes,
        creationDate: creationDate,
        exportedBy: exportedBy,
        exportVersion: exportVersion,
        description: description,
      );

      expect(package.notes, notes);
      expect(package.creationDate, creationDate);
      expect(package.exportedBy, exportedBy);
      expect(package.exportVersion, exportVersion);
      expect(package.description, description);
    });

    test('should use default values for optional parameters', () {
      final package = NoteDataPackage(
        notes: notes,
        creationDate: creationDate,
      );

      expect(package.notes, notes);
      expect(package.creationDate, creationDate);
      expect(package.exportedBy, '');
      expect(package.exportVersion, '');
      expect(package.description, '');
    });

    test('should be equatable', () {
      final package1 = NoteDataPackage(
        notes: notes,
        creationDate: creationDate,
        exportedBy: exportedBy,
        exportVersion: exportVersion,
        description: description,
      );

      final package2 = NoteDataPackage(
        notes: notes,
        creationDate: creationDate,
        exportedBy: exportedBy,
        exportVersion: exportVersion,
        description: description,
      );

      expect(package1, package2);
    });
  });
}
