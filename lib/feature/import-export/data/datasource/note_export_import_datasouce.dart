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
  String _toJson(NoteDataPackageModel notesPackage) {
    final notes = notesPackage.notes
        .map((note) => NoteModel.fromEntity(note).toJson())
        .toList();

    return jsonEncode(notes);
  }

  List<NoteModel> _fromJson(String jsonString) {
    final jsonData = jsonDecode(jsonString);

    return jsonData.map<NoteModel>((note) => NoteModel.fromJson(note)).toList();
  }
}
