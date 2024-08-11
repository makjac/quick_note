import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/feature/home/domain/repository/app_repository.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

class MockAppRepository extends Mock implements AppRepository {}

void main() {
  late MockAppRepository mockAppRepository;
  late UpdateMultipleNotesUsecase usecase;

  setUp(() {
    mockAppRepository = MockAppRepository();
    usecase = UpdateMultipleNotesUsecase(repository: mockAppRepository);
  });

  group('UpdateMultipleNotesUsecase', () {
    final keys = <num>{1, 2};
    const updates = NoteUpdates(
      title: 'Updated Title',
      content: [TextBlock(id: 1, text: 'Updated Content')],
      color: NoteColors.color2,
    );

    final params = UpdateNotesParams(keys: keys, updates: updates);

    test(
        'should return Right(void) when updateMultipleNotes is called successfully',
        () async {
      // Arrange
      when(() => mockAppRepository.updateMultipleNotes(keys, updates))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockAppRepository.updateMultipleNotes(keys, updates))
          .called(1);
    });

    test(
        'should return CacheFailure when updateMultipleNotes throws an exception',
        () async {
      // Arrange
      when(() => mockAppRepository.updateMultipleNotes(keys, updates))
          .thenAnswer((_) async => const Left(CacheFailure()));

      // Act
      final result = await usecase(params);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });
}
