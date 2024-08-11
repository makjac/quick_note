import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:quick_note/core/error/exception/cache_exception.dart';
import 'package:quick_note/feature/home/data/datasource/app_local_data_source.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';
import 'package:quick_note/hive/hive_keys.dart';

class MockHiveInterface extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box<NoteModel> {}

void main() {
  late MockHiveInterface mockHive;
  late MockBox mockBox;
  late AppLocalDataSourceImpl localDataSource;

  setUp(() {
    mockHive = MockHiveInterface();
    mockBox = MockBox();
    localDataSource = AppLocalDataSourceImpl(hive: mockHive);
  });

  group('AppLocalDataSourceImpl', () {
    test('should return a list of notes when getNotes is called successfully',
        () async {
      // Arrange
      final notes = [
        NoteModel(
          id: 1,
          created: DateTime.now(),
          modified: DateTime.now(),
          title: 'Test Note',
          content: const [],
        )
      ];
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.values).thenReturn(notes);

      // Act
      final result = await localDataSource.getNotes();

      // Assert
      expect(result, notes);
      verify(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name)).called(1);
    });

    test('should throw CacheException when getNotes throws an exception',
        () async {
      // Arrange
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenThrow(Exception());

      // Act & Assert
      expect(() => localDataSource.getNotes(), throwsA(isA<CacheException>()));
    });

    test('should create a note successfully', () async {
      // Arrange
      final note = NoteModel(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        title: 'Test Note',
        content: const [],
      );
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.put(note.id.toInt(), note)).thenAnswer((_) async => 0);

      // Act
      await localDataSource.createNote(note);

      // Assert
      verify(() => mockBox.put(note.id.toInt(), note)).called(1);
    });

    test('should throw CacheException when createNote throws an exception',
        () async {
      // Arrange
      final note = NoteModel(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        title: 'Test Note',
        content: const [],
      );
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenThrow(Exception());

      // Act & Assert
      expect(() => localDataSource.createNote(note),
          throwsA(isA<CacheException>()));
    });

    test('should update a note successfully', () async {
      // Arrange
      final note = NoteModel(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        title: 'Test Note',
        content: const [],
      );
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.put(note.id, note)).thenAnswer((_) async => 0);

      // Act
      await localDataSource.updateNote(1, note);

      // Assert
      verify(() => mockBox.put(note.id, note)).called(1);
    });

    test('should throw CacheException when updateNote throws an exception',
        () async {
      // Arrange
      final note = NoteModel(
        id: 1,
        created: DateTime.now(),
        modified: DateTime.now(),
        title: 'Test Note',
        content: const [],
      );
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenThrow(Exception());

      // Act & Assert
      expect(() => localDataSource.updateNote(1, note),
          throwsA(isA<CacheException>()));
    });

    test('should update multiple notes successfully', () async {
      // Arrange
      final updates = {
        1: NoteModel(
          id: 1,
          created: DateTime.now(),
          modified: DateTime.now(),
          title: 'Test Note',
          content: const [],
        )
      };
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.putAll(updates)).thenAnswer((_) async => 0);

      // Act
      await localDataSource.updateMultipleNotes(updates);

      // Assert
      verify(() => mockBox.putAll(updates)).called(1);
    });

    test(
        'should throw CacheException when updateMultipleNotes throws an exception',
        () async {
      // Arrange
      final updates = {
        1: NoteModel(
          id: 1,
          created: DateTime.now(),
          modified: DateTime.now(),
          title: 'Test Note',
          content: const [],
        )
      };
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenThrow(Exception());

      // Act & Assert
      expect(() => localDataSource.updateMultipleNotes(updates),
          throwsA(isA<CacheException>()));
    });

    test('should delete a note successfully', () async {
      // Arrange
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.delete(1)).thenAnswer((_) async => 0);

      // Act
      await localDataSource.deleteNote(1);

      // Assert
      verify(() => mockBox.delete(1)).called(1);
    });
  });
}