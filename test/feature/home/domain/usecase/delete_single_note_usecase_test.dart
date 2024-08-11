import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_single_note_usecase.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  late MockAppRepository mockAppRepository;
  late DeleteSingleNoteUsecase usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = DeleteSingleNoteUsecase(repository: mockAppRepository);
  });

  group('DeleteSingleNoteUsecase', () {
    const noteId = 1;

    test('should return void when deleteNote is called successfully', () async {
      // Arrange
      when(() => mockAppRepository.deleteNote(noteId))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(noteId);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockAppRepository.deleteNote(noteId)).called(1);
    });

    test('should return CacheFailure when deleteNote throws an exception',
        () async {
      // Arrange
      when(() => mockAppRepository.deleteNote(noteId))
          .thenAnswer((_) async => const Left(CacheFailure()));

      // Act
      final result = await usecase(noteId);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });
}
