import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/error/failure/cache_value_failure.dart';
import 'package:quick_note/core/error/failure/unknown_failure.dart';
import 'package:quick_note/core/error/exception/cache_exception.dart';
import 'package:quick_note/core/error/exception/cache_value_exception.dart';
import 'package:quick_note/feature/notebook/data/datasource/notebook_local_datasource.dart';
import 'package:quick_note/feature/notebook/data/repository/notebook_repository_impl.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';

// Mocking NotebookLocalDatasource
class MockNotebookLocalDatasource extends Mock
    implements NotebookLocalDatasource {}

void main() {
  late NotebookRepositoryImpl repository;
  late MockNotebookLocalDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockNotebookLocalDatasource();
    repository = NotebookRepositoryImpl(datasource: mockDatasource);
  });

  group('getNoteByKey', () {
    const tKey = 1;

    final tNoteModel = NoteModel(
      id: tKey,
      created: DateTime.now(),
      modified: DateTime.now(),
      title: "Test Note",
      content: const [],
    );

    test('should return Note when the datasource returns a note', () async {
      // Arrange
      when(() => mockDatasource.getNoteByKey(tKey))
          .thenAnswer((_) async => tNoteModel);

      // Act
      final result = await repository.getNoteByKey(tKey);

      // Assert
      expect(result, equals(Right(tNoteModel)));
      verify(() => mockDatasource.getNoteByKey(tKey)).called(1);
    });

    test('should return CacheValueFailure when CacheValueException is thrown',
        () async {
      // Arrange
      when(() => mockDatasource.getNoteByKey(tKey))
          .thenThrow(CacheValueException());

      // Act
      final result = await repository.getNoteByKey(tKey);

      // Assert
      expect(result, equals(const Left(CacheValueFailure())));
      verify(() => mockDatasource.getNoteByKey(tKey)).called(1);
    });

    test('should return CacheFailure when CacheException is thrown', () async {
      // Arrange
      when(() => mockDatasource.getNoteByKey(tKey)).thenThrow(CacheException());

      // Act
      final result = await repository.getNoteByKey(tKey);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
      verify(() => mockDatasource.getNoteByKey(tKey)).called(1);
    });

    test('should return UnknownFailure when an unknown exception is thrown',
        () async {
      // Arrange
      when(() => mockDatasource.getNoteByKey(tKey))
          .thenThrow(Exception('Unknown error'));

      // Act
      final result = await repository.getNoteByKey(tKey);

      // Assert
      expect(result, equals(const Left(UnknownFailure())));
      verify(() => mockDatasource.getNoteByKey(tKey)).called(1);
    });
  });
}
