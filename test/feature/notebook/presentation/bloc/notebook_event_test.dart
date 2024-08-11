import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

void main() {
  group('NotebookEvent', () {
    test('NotebookCreateNote props are empty list', () {
      final event = NotebookCreateNote();
      expect(event.props, []);
    });

    test('NotebookGetNote props include noteId', () {
      const noteId = 1;
      const event = NotebookGetNote(noteId: noteId);
      expect(event.props, [noteId]);
    });

    test('NotebookGetNote props default to -1 if noteId is null', () {
      const event = NotebookGetNote();
      expect(event.props, [-1]);
    });

    test('NotebookUpdateNote props include updates', () {
      const updates = NoteUpdates(isStarred: true);
      const event = NotebookUpdateNote(updates: updates);
      expect(event.props, [updates]);
    });

    test('NotebookDeleteNote props are empty list', () {
      final event = NotebookDeleteNote();
      expect(event.props, []);
    });

    test('NotebookAddNoteBlock props include type', () {
      const type = NoteBlockType.text;
      const event = NotebookAddNoteBlock(type: type);
      expect(event.props, [type]);
    });

    test('NotebookUpdateNoteBlock props include block', () {
      const block = TextBlock(id: 1, type: NoteBlockType.text);
      const event = NotebookUpdateNoteBlock(block: block);
      expect(event.props, [block]);
    });

    test('NotebookDeleteBlock props include blockId', () {
      const blockId = 1;
      const event = NotebookDeleteBlock(blockId: blockId);
      expect(event.props, [blockId]);
    });

    test('NotebookChangeColor props include color', () {
      const color = 'blue';
      const event = NotebookChangeColor(color: color);
      expect(event.props, [color]);
    });

    test('NotebookToggleStar props are empty list', () {
      final event = NotebookToggleStar();
      expect(event.props, []);
    });

    test('NotebookToggleArchive props are empty list', () {
      final event = NotebookToggleArchive();
      expect(event.props, []);
    });
  });
}
