import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/domain/usecase/update_note_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  late MockAppRepository mockAppRepository;
  late UpdateSingleNoteUsecase usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = UpdateSingleNoteUsecase(repository: mockAppRepository);
  });

  group('UpdateSingleNoteUsecase', () {
    final note = Note(
      id: 1,
      title: 'Original Title',
      content: const [],
      created: DateTime.now(),
      modified: DateTime.now(),
    );

    const updates = NoteUpdates(
      title: 'Updated Title',
      content: [TextBlock(id: 1, text: 'Updated Content')],
      color: NoteColors.color11,
    );

    final params = UpdateSingleNoteParams(note: note, updates: updates);

    test('should return Right(void) when updateNote is called successfully',
        () async {
      // Arrange
      when(() => mockAppRepository.updateNote(note, updates))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockAppRepository.updateNote(note, updates)).called(1);
    });

    test('should return CacheFailure when updateNote throws an exception',
        () async {
      // Arrange
      when(() => mockAppRepository.updateNote(note, updates))
          .thenAnswer((_) async => const Left(CacheFailure()));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });
}
