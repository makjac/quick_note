import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/error/failure/cache_value_failure.dart';
import 'package:quick_note/core/error/failure/unknown_failure.dart';
import 'package:quick_note/feature/notebook/domain/repository/notebook_repository.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/notebook/domain/usecase/get_note_by_key_usecase.dart';

class MockNotebookRepository extends Mock implements NotebookRepository {}

void main() {
  late GetNoteByKeyUsecase usecase;
  late MockNotebookRepository mockRepository;

  setUp(() {
    mockRepository = MockNotebookRepository();
    usecase = GetNoteByKeyUsecase(repository: mockRepository);
  });

  const tKey = 1;
  final tNote = Note(
    id: tKey,
    created: DateTime.now(),
    modified: DateTime.now(),
  );

  group('GetNoteByKeyUsecase', () {
    test('should return Note when repository returns a note', () async {
      // Arrange
      when(() => mockRepository.getNoteByKey(tKey))
          .thenAnswer((_) async => Right(tNote));

      // Act
      final result = await usecase(tKey);

      // Assert
      expect(result, equals(Right(tNote)));
      verify(() => mockRepository.getNoteByKey(tKey)).called(1);
    });

    group('when repository returns an error', () {
      test(
          'should return CacheValueFailure when repository returns CacheValueFailure',
          () async {
        // Arrange
        when(() => mockRepository.getNoteByKey(tKey))
            .thenAnswer((_) async => const Left(CacheValueFailure()));

        // Act
        final result = await usecase(tKey);

        // Assert
        expect(result, equals(const Left(CacheValueFailure())));
        verify(() => mockRepository.getNoteByKey(tKey)).called(1);
      });

      test('should return CacheFailure when repository returns CacheFailure',
          () async {
        // Arrange
        when(() => mockRepository.getNoteByKey(tKey))
            .thenAnswer((_) async => const Left(CacheFailure()));

        // Act
        final result = await usecase(tKey);

        // Assert
        expect(result, equals(const Left(CacheFailure())));
        verify(() => mockRepository.getNoteByKey(tKey)).called(1);
      });

      test(
          'should return UnknownFailure when repository returns UnknownFailure',
          () async {
        // Arrange
        when(() => mockRepository.getNoteByKey(tKey))
            .thenAnswer((_) async => const Left(UnknownFailure()));

        // Act
        final result = await usecase(tKey);

        // Assert
        expect(result, equals(const Left(UnknownFailure())));
        verify(() => mockRepository.getNoteByKey(tKey)).called(1);
      });
    });
  });
}
