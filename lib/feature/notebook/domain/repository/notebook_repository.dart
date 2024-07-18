import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

abstract class NotebookRepository {
  Future<Either<Failure, Note>> getNoteByKey(num key);
}
