import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/core/service/analytics/enum/note_action.dart';

void main() {
  group('NoteAction', () {
    test('contains all expected values', () {
      expect(
          NoteAction.values,
          containsAll([
            NoteAction.created,
            NoteAction.deleted,
            NoteAction.updated,
            NoteAction.restored,
            NoteAction.archived,
            NoteAction.unarchived,
            NoteAction.stared,
            NoteAction.unstared,
            NoteAction.colorChanged,
            NoteAction.addedBlock,
            NoteAction.removedBlock,
            NoteAction.reorderBlocks,
          ]));
    });

    test('has the correct number of values', () {
      expect(NoteAction.values.length, equals(12));
    });

    test('each enum value has correct index', () {
      expect(NoteAction.created.index, equals(0));
      expect(NoteAction.deleted.index, equals(1));
      expect(NoteAction.updated.index, equals(2));
      expect(NoteAction.restored.index, equals(3));
      expect(NoteAction.archived.index, equals(4));
      expect(NoteAction.unarchived.index, equals(5));
      expect(NoteAction.stared.index, equals(6));
      expect(NoteAction.unstared.index, equals(7));
      expect(NoteAction.colorChanged.index, equals(8));
      expect(NoteAction.addedBlock.index, equals(9));
      expect(NoteAction.removedBlock.index, equals(10));
      expect(NoteAction.reorderBlocks.index, equals(11));
    });

    test('toString returns the correct string representation', () {
      expect(NoteAction.created.toString(), equals('NoteAction.created'));
      expect(NoteAction.deleted.toString(), equals('NoteAction.deleted'));
      expect(NoteAction.updated.toString(), equals('NoteAction.updated'));
      expect(NoteAction.restored.toString(), equals('NoteAction.restored'));
      expect(NoteAction.archived.toString(), equals('NoteAction.archived'));
      expect(NoteAction.unarchived.toString(), equals('NoteAction.unarchived'));
      expect(NoteAction.stared.toString(), equals('NoteAction.stared'));
      expect(NoteAction.unstared.toString(), equals('NoteAction.unstared'));
      expect(NoteAction.colorChanged.toString(),
          equals('NoteAction.colorChanged'));
      expect(NoteAction.addedBlock.toString(), equals('NoteAction.addedBlock'));
      expect(NoteAction.removedBlock.toString(),
          equals('NoteAction.removedBlock'));
      expect(NoteAction.reorderBlocks.toString(),
          equals('NoteAction.reorderBlocks'));
    });
  });
}
