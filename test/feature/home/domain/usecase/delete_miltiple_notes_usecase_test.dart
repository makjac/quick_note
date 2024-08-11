import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/delete_miltiple_notes_usecase.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  late MockAppRepository mockAppRepository;
  late DeleteMiltipleNotesUsecase usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = DeleteMiltipleNotesUsecase(repository: mockAppRepository);
  });

  group('DeleteMiltipleNotesUsecase', () {
    final noteIds = [1, 2, 3];

    test('should return void when deleteMultipleNotes is called successfully',
        () async {
      // Arrange
      when(() => mockAppRepository.deleteMultipleNotes(noteIds))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(noteIds);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockAppRepository.deleteMultipleNotes(noteIds)).called(1);
    });

    test(
        'should return CacheFailure when deleteMultipleNotes throws an exception',
        () async {
      // Arrange
      when(() => mockAppRepository.deleteMultipleNotes(noteIds))
          .thenAnswer((_) async => const Left(CacheFailure()));

      // Act
      final result = await usecase(noteIds);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });
}
