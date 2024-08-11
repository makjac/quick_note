import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:quick_note/core/error/failure/cache_failure.dart';
import 'package:quick_note/feature/home/data/datasource/app_local_data_source.dart';
import 'package:quick_note/feature/home/data/repository/app_repository_impl.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class MockAppLocalDataSource extends Mock implements AppLocalDataSource {}

void main() {
  late MockAppLocalDataSource mockLocalDataSource;
  late AppRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockAppLocalDataSource();
    repository = AppRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('AppRepositoryImpl', () {
    final note = Note(
      id: 1,
      title: 'Test Note',
      content: const [],
      created: DateTime.now(),
      modified: DateTime.now(),
    );
    final noteModel = NoteModel.fromEntity(note);
    const noteUpdates = NoteUpdates(title: 'Updated Title', content: null);

    test('should return CacheFailure when getAllNotes throws an exception',
        () async {
      // Arrange
      when(() => mockLocalDataSource.getNotes()).thenThrow(Exception());

      // Act
      final result = await repository.getAllNotes();

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });

    test('should create a note successfully', () async {
      // Arrange
      when(() => mockLocalDataSource.createNote(noteModel))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.createNote(note);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockLocalDataSource.createNote(noteModel)).called(1);
    });
  });
}
