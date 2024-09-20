import 'dart:convert';
import 'dart:io';

import 'package:quick_note/feature/import-export/data/model/note_data_package.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';

abstract class NoteExportImportDatasouce {
  Future<List<NoteModel>> readNotes({
    required String filePath,
  });
  Future<void> writeNotes({
    required NoteDataPackageModel notesPackage,
    required String filePath,
  });
}

class NoteExportImportDatasouceImpl implements NoteExportImportDatasouce {
}
