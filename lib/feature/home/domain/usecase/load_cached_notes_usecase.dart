import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class LoadCachedNotesUsecase extends UseCase<List<Note>, NoParams> {
  LoadCachedNotesUsecase({required this.repository});

  final AppRepository repository;

  @override
  Future<Either<Failure, List<Note>>> call(NoParams params) async {
    return await repository.getAllNotes();
  }
}
