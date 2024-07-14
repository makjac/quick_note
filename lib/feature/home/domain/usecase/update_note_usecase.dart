import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class UpdateSingleNoteUsecase extends UseCase<void, UpdateSingleNoteParams> {
  UpdateSingleNoteUsecase({required this.repository});

  final AppRepository repository;

  @override
  Future<Either<Failure, void>> call(UpdateSingleNoteParams params) async {
    return await repository.updateNote(params.note, params.updates);
  }
}

class UpdateSingleNoteParams extends Equatable {
  const UpdateSingleNoteParams({required this.note, required this.updates});

  final Note note;
  final NoteUpdates updates;

  @override
  List<Object?> get props => [note, updates];
}
