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

    test('should return CacheFailure when createNote throws an exception',
        () async {
      // Arrange
      when(() => mockLocalDataSource.createNote(noteModel))
          .thenThrow(Exception());

      // Act
      final result = await repository.createNote(note);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });

    test('should update a note successfully', () async {
      // Arrange
      when(() => mockLocalDataSource.updateNote(
              note.id, NoteModel.updateEntity(note, noteUpdates)))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.updateNote(note, noteUpdates);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockLocalDataSource.updateNote(
          note.id, NoteModel.updateEntity(note, noteUpdates))).called(1);
    });

    test('should return CacheFailure when updateNote throws an exception',
        () async {
      // Arrange
      when(() => mockLocalDataSource.updateNote(
              note.id, NoteModel.updateEntity(note, noteUpdates)))
          .thenThrow(Exception());

      // Act
      final result = await repository.updateNote(note, noteUpdates);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });

    test('should update multiple notes successfully', () async {
      // Arrange
      final notes = [noteModel];
      final changes = {note.id: NoteModel.updateEntity(note, noteUpdates)};
      when(() => mockLocalDataSource.getNotes()).thenAnswer((_) async => notes);
      when(() => mockLocalDataSource.updateMultipleNotes(changes))
          .thenAnswer((_) async {});

      // Act
      final result =
          await repository.updateMultipleNotes({note.id}, noteUpdates);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockLocalDataSource.updateMultipleNotes(changes)).called(1);
    });

    test(
        'should return CacheFailure when updateMultipleNotes throws an exception',
        () async {
      // Arrange
      when(() => mockLocalDataSource.getNotes())
          .thenAnswer((_) async => [noteModel]);
      when(() => mockLocalDataSource.updateMultipleNotes(any()))
          .thenThrow(Exception());

      // Act
      final result =
          await repository.updateMultipleNotes({note.id}, noteUpdates);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });

    test('should delete a note successfully', () async {
      // Arrange
      when(() => mockLocalDataSource.deleteNote(note.id))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.deleteNote(note.id);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockLocalDataSource.deleteNote(note.id)).called(1);
    });

    test('should return CacheFailure when deleteNote throws an exception',
        () async {
      // Arrange
      when(() => mockLocalDataSource.deleteNote(note.id))
          .thenThrow(Exception());

      // Act
      final result = await repository.deleteNote(note.id);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });

    test('should delete multiple notes successfully', () async {
      // Arrange
      final ids = [note.id];
      when(() => mockLocalDataSource.deleteMultipleNotes(ids))
          .thenAnswer((_) async {});

      // Act
      final result = await repository.deleteMultipleNotes(ids);

      // Assert
      expect(result, equals(const Right(null)));
      verify(() => mockLocalDataSource.deleteMultipleNotes(ids)).called(1);
    });

    test(
        'should return CacheFailure when deleteMultipleNotes throws an exception',
        () async {
      // Arrange
      when(() => mockLocalDataSource.deleteMultipleNotes(any()))
          .thenThrow(Exception());

      // Act
      final result = await repository.deleteMultipleNotes([note.id]);

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });

    test('should delete all notes successfully', () async {
      // Arrange
      when(() => mockLocalDataSource.deleteAllNotes())
          .thenAnswer((_) async => 0);

      // Act
      final result = await repository.deleteAllNotes();

      // Assert
      expect(result, equals(const Right(0)));
      verify(() => mockLocalDataSource.deleteAllNotes()).called(1);
    });

    test('should return CacheFailure when deleteAllNotes throws an exception',
        () async {
      // Arrange
      when(() => mockLocalDataSource.deleteAllNotes()).thenThrow(Exception());

      // Act
      final result = await repository.deleteAllNotes();

      // Assert
      expect(result, equals(const Left(CacheFailure())));
    });
  });
}
