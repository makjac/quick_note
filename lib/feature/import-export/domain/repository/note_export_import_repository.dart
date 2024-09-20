import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

abstract class NoteExportImportRepository {
  Future<Either<Failure, void>> exportNotes({
    required List<Note> notes,
    String? filePath,
  });
  Future<Either<Failure, List<Note>>> importNotes({
    required String filePath,
  });
}
