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
  });
}
