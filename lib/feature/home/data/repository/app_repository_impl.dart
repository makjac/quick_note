import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/feature/home/data/datasource/app_local_data_source.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class AppRepositoryImpl implements AppRepository {
  final AppLocalDataSource localDataSource;

  const AppRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final notes = await localDataSource.getNotes();
      return Right(notes);
    } catch (e) {
      return left(const CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createNote(Note note) async {
    try {
      final key = await localDataSource.createNote(NoteModel.fromEntity(note));

      return Right(key);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(
      Note note, NoteUpdates updates) async {
    try {
      final result = await localDataSource.updateNote(
          note.id, NoteModel.updateEntity(note, updates));

      return Right(result);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateMultipleNotes(
      Set<num> keys, NoteUpdates updates) async {
    try {
      final notes = (await localDataSource.getNotes())
          .where((note) => keys.contains(note.id));

      final changes = {
        for (var note in notes) note.id: NoteModel.updateEntity(note, updates)
      };

      final result = await localDataSource.updateMultipleNotes(changes);

      return Right(result);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteNote(num key) async {
    try {
      final result = await localDataSource.deleteNote(key);

      return Right(result);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteMultipleNotes(List<num> keys) async {
    try {
      final result = await localDataSource.deleteMultipleNotes(keys);

      return Right(result);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>> deleteAllNotes() async {
    try {
      final result = await localDataSource.deleteAllNotes();

      return Right(result);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmptyNotes() async {
    try {
      final notes = await localDataSource.getNotes();
      final emptyNotes = notes.where((note) => note.isEmpty);

      final result = await localDataSource
          .deleteMultipleNotes(emptyNotes.map((note) => note.id).toList());

      return Right(result);
    } catch (e) {
      return const Left(CacheFailure());
    }
  }
}
