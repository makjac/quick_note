import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_change_note_title_command.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/text/text_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';

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

    test('NotebookMoveToTrash props are empty list', () {
      final event = NotebookMoveToTrash();
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
      expect(event.props, [block, -1]);
    });

    test('NotebookUpdateNoteBlock props include block and command', () {
      const block = TextBlock(id: 1, type: NoteBlockType.text);
      final command = NotebookChangeNoteTitleCommand(
        newTitle: "newTitle",
        note: Note(
          id: 1,
          created: DateTime.now(),
          modified: DateTime.now(),
        ),
      );
      final event = NotebookUpdateNoteBlock(block: block, command: command);
      expect(event.props, [block, command]);
    });

    test('NotebookDeleteBlock props include blockId', () {
      const blockId = 1;
      const event = NotebookDeleteBlock(blockId: blockId);
      expect(event.props, [blockId]);
    });

    test('NotebookChangeColor props include color', () {
      const color = NoteColors.color12;
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

    test('NotebookDeleteNote props are empty list', () {
      final event = NotebookDeleteNote();
      expect(event.props, []);
    });
  });
}
