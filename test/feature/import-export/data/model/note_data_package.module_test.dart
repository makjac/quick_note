import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/import-export/data/model/note_data_package.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/text/text_block.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';
import 'package:quick_note/feature/import-export/domain/entity/note_data_package.dart';

void main() {
  group('NoteDataPackageModel', () {
    final noteModel = NoteModel(
      id: 1,
      title: 'Note 1',
      created: DateTime.now(),
      modified: DateTime.now().add(const Duration(seconds: 1)),
      content: const [TextBlockModel(id: 1, text: 'Content 1')],
    );
    final noteDataPackage = NoteDataPackage(
      notes: [noteModel],
      creationDate: DateTime.now(),
      exportedBy: 'John Doe',
      exportVersion: '1.0',
      description: 'Exported notes for project X',
    );

    test('should create an instance from an entity', () {
      final model = NoteDataPackageModel.fromEntity(noteDataPackage);

      expect(model.notes, noteDataPackage.notes);
      expect(model.creationDate, noteDataPackage.creationDate);
      expect(model.exportedBy, noteDataPackage.exportedBy);
      expect(model.exportVersion, noteDataPackage.exportVersion);
      expect(model.description, noteDataPackage.description);
    });
  });
}
