import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/create_note_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  late MockAppRepository mockAppRepository;
  late CreateNoteUsecase usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = CreateNoteUsecase(repository: mockAppRepository);
  });

  group('CreateNoteUsecase', () {
    final note = Note(
      id: 1,
      title: 'Test Note',
      content: const [], // Assuming content is a list, if not, adjust accordingly
      created: DateTime.now(),
      modified: DateTime.now(),
    );

    test('should return Right(null) when createNote is called successfully',
        () async {
      // Arrange
      when(() => mockAppRepository.createNote(note))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(note);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockAppRepository.createNote(note)).called(1);
    });

    test('should return CacheFailure when createNote throws an exception',
        () async {
      // Arrange
      when(() => mockAppRepository.createNote(note))
          .thenAnswer((_) async => const Left(CacheFailure()));

      // Act
      final result = await usecase(note);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });
}
