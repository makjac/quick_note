import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:hive/hive.dart';
import 'package:quick_note/core/error/exception/cache_exception.dart';
import 'package:quick_note/feature/notebook/data/datasource/notebook_local_datasource.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';
import 'package:quick_note/hive/hive_keys.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox extends Mock implements Box<NoteModel> {}

void main() {
  late NotebookLocalDatasourceImpl datasource;
  late MockHive mockHive;
  late MockBox mockBox;

  setUp(() {
    mockHive = MockHive();
    mockBox = MockBox();
    datasource = NotebookLocalDatasourceImpl(hive: mockHive);
  });

  group('getNoteByKey', () {
    const tKey = 1;
    final tNote = NoteModel(
      id: tKey,
      created: DateTime.now(),
      modified: DateTime.now(),
      title: 'Test Note',
      content: const [],
    );

    test('should return NoteModel when the note is found in the box', () async {
      // Arrange
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.get(tKey)).thenReturn(tNote);

      // Act
      final result = await datasource.getNoteByKey(tKey);

      // Assert
      expect(result, equals(tNote));
      verify(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name)).called(1);
      verify(() => mockBox.get(tKey)).called(1);
    });

    test(
        'should throw CacheValueException when the note is not found in the box',
        () async {
      // Arrange
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.get(tKey)).thenReturn(null);

      // Act & Assert
      expect(
          () => datasource.getNoteByKey(tKey), throwsA(isA<CacheException>()));
      verify(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name)).called(1);
      verifyNever(() => mockBox.get(tKey));
    });

    test('should throw CacheException when there is an error opening the box',
        () async {
      // Arrange
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenThrow(Exception('Failed to open box'));

      // Act & Assert
      expect(
          () => datasource.getNoteByKey(tKey), throwsA(isA<CacheException>()));
      verify(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name)).called(1);
    });

    test('should throw CacheException when there is a general error', () async {
      // Arrange
      when(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name))
          .thenAnswer((_) async => mockBox);
      when(() => mockBox.get(tKey)).thenThrow(Exception('Failed to get note'));

      // Act & Assert
      expect(
          () => datasource.getNoteByKey(tKey), throwsA(isA<CacheException>()));
      verify(() => mockHive.openBox<NoteModel>(HiveBoxes.note.name)).called(1);
      verifyNever(() => mockBox.get(tKey));
    });
  });
}
