import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';

class DeleteEmptyNotesUsecase extends UseCase<void, NoParams> {
  final AppRepository repository;

  DeleteEmptyNotesUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.deleteEmptyNotes();
  }
}