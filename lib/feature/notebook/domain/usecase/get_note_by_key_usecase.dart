import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/notebook/domain/repository/notebook_repository.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class GetNoteByKeyUsecase extends UseCase<Note, num> {
  GetNoteByKeyUsecase({required this.repository});

  final NotebookRepository repository;

  @override
  Future<Either<Failure, Note>> call(num params) async {
    return await repository.getNoteByKey(params);
  }
}
