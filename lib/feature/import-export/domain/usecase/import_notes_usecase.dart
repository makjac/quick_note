import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/import-export/domain/repository/note_export_import_repository.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class ImportNotesUsecase extends UseCase<List<Note>, String> {
  ImportNotesUsecase({required this.repository});

  final NoteExportImportRepository repository;

  @override
  Future<Either<Failure, List<Note>>> call(String params) async {
    return await repository.importNotes(filePath: params);
  }
}
