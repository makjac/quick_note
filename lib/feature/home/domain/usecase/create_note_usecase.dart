import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class CreateNoteUsecase extends UseCase<void, Note> {
  final AppRepository repository;

  CreateNoteUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(Note params) async {
    return await repository.createNote(params);
  }
}
