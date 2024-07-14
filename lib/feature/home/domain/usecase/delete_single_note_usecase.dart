import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';

class DeleteSingleNoteUsecase extends UseCase<void, num> {
  DeleteSingleNoteUsecase({required this.repository});

  final AppRepository repository;

  @override
  Future<Either<Failure, void>> call(num params) async {
    return await repository.deleteNote(params);
  }
}
