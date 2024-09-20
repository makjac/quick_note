import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/import-export/data/datasource/note_export_import_datasouce.dart';
import 'package:quick_note/feature/import-export/data/model/note_data_package.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';

void main() {
  late NoteExportImportDatasouceImpl datasource;

  setUp(() {
    datasource = NoteExportImportDatasouceImpl();
  });

  group('NoteExportImportDatasouceImpl', () {
    test('should write notes to file', () async {
      const filePath = 'test_notatka.json';
      final note = NoteModel(
        id: 1,
        title: 'Test Note',
        content: const [],
        created: DateTime.now(),
        modified: DateTime.now(),
      );

      final notesPackage = NoteDataPackageModel(
        notes: [note],
        creationDate: DateTime.now(),
      );

      await datasource.writeNotes(
          notesPackage: notesPackage, filePath: filePath);
    });
  });
}
