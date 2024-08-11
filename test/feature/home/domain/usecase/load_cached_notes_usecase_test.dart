import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/core/usecase/usecase.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/load_cached_notes_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  late MockAppRepository mockAppRepository;
  late LoadCachedNotesUsecase usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = LoadCachedNotesUsecase(repository: mockAppRepository);
  });

  group('LoadCachedNotesUsecase', () {
    final notes = <Note>[
      Note(
        id: 1,
        title: 'Test Note 1',
        content: const [],
        created: DateTime.now(),
        modified: DateTime.now(),
      ),
      Note(
        id: 2,
        title: 'Test Note 2',
        content: const [],
        created: DateTime.now(),
        modified: DateTime.now(),
      ),
    ];

    test('should return list of notes when getAllNotes is called successfully',
        () async {
      // Arrange
      when(() => mockAppRepository.getAllNotes())
          .thenAnswer((_) async => Right(notes));

      // Act
      final result = await usecase(NoParams());

      // Assert
      expect(result, equals(Right(notes)));
      verify(() => mockAppRepository.getAllNotes()).called(1);
    });

    test('should return CacheFailure when getAllNotes throws an exception',
        () async {
      // Arrange
      when(() => mockAppRepository.getAllNotes())
          .thenAnswer((_) async => const Left(CacheFailure()));

      // Act
      final result = await usecase(NoParams());

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });
}
