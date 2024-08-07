import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

class UpdateMultipleNotesUsecase extends UseCase<void, UpdateNotesParams> {
  UpdateMultipleNotesUsecase({required this.repository});

  final AppRepository repository;

  @override
  Future<Either<Failure, void>> call(UpdateNotesParams params) async {
    return await repository.updateMultipleNotes(params.keys, params.updates);
  }
}

class UpdateNotesParams extends Equatable {
  const UpdateNotesParams({required this.keys, required this.updates});

  final Set<num> keys;
  final NoteUpdates updates;

  @override
  List<Object?> get props => [keys, updates];
}

class NoteUpdates extends Equatable {
  const NoteUpdates({
    this.modified,
    this.expirydate,
    this.title,
    this.content,
    this.archived,
    this.author,
    this.isStarred,
    this.color,
  });

  final DateTime? modified;
  final DateTime? expirydate;
  final String? title;
  final List<NoteBlock>? content;
  final bool? archived;
  final String? author;
  final bool? isStarred;
  final NoteColors? color;

  @override
  List<Object?> get props => [
        modified,
        expirydate,
        title,
        content,
        archived,
        author,
        isStarred,
        color,
      ];
}
