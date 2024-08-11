import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';
import 'package:quick_note/feature/shared/data/model/note/note.module.dart';

class MockNoteBlock extends NoteBlock {
  const MockNoteBlock({
    required super.id,
    super.title = "",
    super.hasTitle = true,
    super.type = NoteBlockType.text,
  });
}

void main() {
  group('NoteModel', () {
    test('should create a NoteModel instance with the correct properties', () {
      final now = DateTime.now();
      final note = NoteModel(
        id: 1,
        created: now,
        modified: now,
        title: 'Test Note',
        content: const [],
        archived: false,
        author: 'Author',
        isStarred: true,
        color: NoteColors.color2,
      );

      expect(note.id, 1);
      expect(note.created, now);
      expect(note.modified, now);
      expect(note.title, 'Test Note');
      expect(note.content, []);
      expect(note.archived, false);
      expect(note.author, 'Author');
      expect(note.isStarred, true);
      expect(note.color, NoteColors.color2);
    });

    test('should convert Note to NoteModel using fromEntity', () {
      final now = DateTime.now();
      final note = Note(
        id: 1,
        created: now,
        modified: now,
        title: 'Test Note',
        content: const [],
        archived: false,
        author: 'Author',
        isStarred: true,
        color: NoteColors.color2,
      );

      final noteModel = NoteModel.fromEntity(note);

      expect(noteModel.id, note.id);
      expect(noteModel.created, note.created);
      expect(noteModel.modified, note.modified);
      expect(noteModel.title, note.title);
      expect(noteModel.content, note.content);
      expect(noteModel.archived, note.archived);
      expect(noteModel.author, note.author);
      expect(noteModel.isStarred, note.isStarred);
      expect(noteModel.color, note.color);
    });

    test('should update NoteModel using updateEntity', () {
      final now = DateTime.now();
      final note = Note(
        id: 1,
        created: now,
        modified: now,
        title: 'Old Note',
        content: const [],
        archived: false,
        author: 'Author',
        isStarred: false,
        color: NoteColors.color1,
      );

      final updatedNote = NoteUpdates(
        modified: now.add(const Duration(days: 1)),
        title: 'Updated Note',
        archived: true,
        isStarred: true,
        color: NoteColors.color2,
      );

      final updatedNoteModel = NoteModel.updateEntity(note, updatedNote);

      expect(updatedNoteModel.id, note.id);
      expect(updatedNoteModel.created, note.created);
      expect(updatedNoteModel.modified, updatedNote.modified);
      expect(updatedNoteModel.title, 'Updated Note');
      expect(updatedNoteModel.content, note.content);
      expect(updatedNoteModel.archived, true);
      expect(updatedNoteModel.author, note.author);
      expect(updatedNoteModel.isStarred, true);
      expect(updatedNoteModel.color, NoteColors.color2);
    });

    test('should convert NoteModel back to Note using toEntity', () {
      final now = DateTime.now();
      final noteModel = NoteModel(
        id: 1,
        created: now,
        modified: now,
        title: 'Test Note',
        content: const [],
        archived: false,
        author: 'Author',
        isStarred: true,
        color: NoteColors.color2,
      );

      final note = noteModel.toEntity();

      expect(note.id, noteModel.id);
      expect(note.created, noteModel.created);
      expect(note.modified, noteModel.modified);
      expect(note.title, noteModel.title);
      expect(note.content, noteModel.content);
      expect(note.archived, noteModel.archived);
      expect(note.author, noteModel.author);
      expect(note.isStarred, noteModel.isStarred);
      expect(note.color, noteModel.color);
    });

    test('should compare two NoteModel instances with the same values as equal',
        () {
      final now = DateTime.now();
      final noteModel1 = NoteModel(
        id: 1,
        created: now,
        modified: now,
        title: 'Test Note',
        content: const [],
        archived: false,
        author: 'Author',
        isStarred: true,
        color: NoteColors.color2,
      );

      final noteModel2 = NoteModel(
        id: 1,
        created: now,
        modified: now,
        title: 'Test Note',
        content: const [],
        archived: false,
        author: 'Author',
        isStarred: true,
        color: NoteColors.color2,
      );

      expect(noteModel1, noteModel2);
    });

    test(
        'should compare two NoteModel instances with different values as not equal',
        () {
      final now = DateTime.now();
      final noteModel1 = NoteModel(
        id: 1,
        created: now,
        modified: now,
        title: 'Test Note',
        content: const [],
        archived: false,
        author: 'Author',
        isStarred: true,
        color: NoteColors.color2,
      );

      final noteModel2 = NoteModel(
        id: 2,
        created: now,
        modified: now,
        title: 'Different Note',
        content: const [],
        archived: true,
        author: 'Another Author',
        isStarred: false,
        color: NoteColors.color1,
      );

      expect(noteModel1, isNot(noteModel2));
    });
  });
}
