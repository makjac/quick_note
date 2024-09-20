import 'package:dartz/dartz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_note/core/error/exception/file_not_found_exception.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/file_not_found_failure.dart';
import 'package:quick_note/feature/import-export/data/datasource/note_export_import_datasouce.dart';
import 'package:quick_note/feature/import-export/data/model/note_data_package.module.dart';
import 'package:quick_note/feature/import-export/domain/repository/note_export_import_repository.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class NoteExportImportRepositoryImpl implements NoteExportImportRepository {
  const NoteExportImportRepositoryImpl({
    required this.noteExportImportDatasouce,
  });

  final NoteExportImportDatasouce noteExportImportDatasouce;

  @override
  Future<Either<Failure, void>> exportNotes({
    required List<Note> notes,
    String? filePath,
  }) async {
    try {
      final creationDate = DateTime.now();
      final noteDataPackage = NoteDataPackageModel(
        notes: notes,
        creationDate: creationDate,
      );

      final exportFilePath = filePath ??
          "${(await getApplicationDocumentsDirectory()).path}/notes_${creationDate.toIso8601String()}.json";

      await noteExportImportDatasouce.writeNotes(
        filePath: exportFilePath,
        notesPackage: noteDataPackage,
      );

      return const Right(null);
    } catch (_) {
      return const Left(CacheFailure());
    }
  }
}
