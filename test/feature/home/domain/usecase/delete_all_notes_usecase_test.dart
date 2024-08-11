import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_all_notes_usecase.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  late MockAppRepository mockAppRepository;
  late DeleteAllNotesUsecase usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = DeleteAllNotesUsecase(repository: mockAppRepository);
  });

  group('DeleteAllNotesUsecase', () {
    test(
        'should return the number of deleted notes when deleteAllNotes is successful',
        () async {
      // Arrange
      const deletedCount = 5;
      when(() => mockAppRepository.deleteAllNotes())
          .thenAnswer((_) async => const Right(deletedCount));

      // Act
      final result = await usecase(NoParams());

      // Assert
      expect(result, equals(const Right(deletedCount)));
      verify(() => mockAppRepository.deleteAllNotes()).called(1);
    });

    test('should return CacheFailure when deleteAllNotes throws an exception',
        () async {
      // Arrange
      when(() => mockAppRepository.deleteAllNotes())
          .thenAnswer((_) async => const Left(CacheFailure()));
      // Act
      final result = await usecase(NoParams());

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });
}
