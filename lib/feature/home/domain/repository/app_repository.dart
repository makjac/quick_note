import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

abstract class AppRepository {
  Future<Either<Failure, List<Note>>> getAllNotes();
  Future<Either<Failure, void>> createNote(Note note);
  Future<Either<Failure, void>> updateNote(Note note, NoteUpdates updates);
  Future<Either<Failure, void>> updateMultipleNotes(
      Set<num> keys, NoteUpdates updates);
  Future<Either<Failure, void>> deleteNote(num key);
  Future<Either<Failure, void>> deleteMultipleNotes(List<num> keys);
  Future<Either<Failure, int>> deleteAllNotes();
  Future<Either<Failure, void>> deleteEmptyNotes();
}
