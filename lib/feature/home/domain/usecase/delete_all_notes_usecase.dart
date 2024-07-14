import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';

class DeleteAllNotesUsecase extends UseCase<int, NoParams> {
  DeleteAllNotesUsecase({required this.repository});

  final AppRepository repository;

  @override
  Future<Either<Failure, int>> call(NoParams params) async {
    return await repository.deleteAllNotes();
  }
}
