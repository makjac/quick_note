import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/exception/cache_exception.dart';
import 'package:quick_note/core/error/exception/cache_value_exception.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/error/failure/cache_value_failure.dart';
import 'package:quick_note/core/error/failure/failure.dart';
import 'package:quick_note/core/error/failure/unknown_failure.dart';
import 'package:quick_note/feature/notebook/data/datasource/notebook_local_datasource.dart';
import 'package:quick_note/feature/notebook/domain/repository/notebook_repository.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class NotebookRepositoryImpl implements NotebookRepository {
  const NotebookRepositoryImpl({required this.datasource});

  final NotebookLocalDatasource datasource;

  @override
  Future<Either<Failure, Note>> getNoteByKey(num key) async {
    try {
      final note = await datasource.getNoteByKey(key);

      return Right(note);
    } on CacheValueException {
      return Left(CacheValueFailure());
    } on CacheException {
      return Left(CacheFailure());
    } catch (_) {
      return Left(UnknownFailure());
    }
  }
}
