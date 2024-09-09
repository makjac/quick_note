import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_change_title_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

void main() {
  group('BookmarkBlockChangeTitleCommand', () {
    late BookmarksBlock block;
    late BookmarkBlockChangeTitleCommand command;

    setUp(() {
      block = const BookmarksBlock(id: 1, title: 'Old Title', items: []);
      command =
          BookmarkBlockChangeTitleCommand(block: block, newTitle: 'New Title');
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Bookmark Block: Change title");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.bookmark);
    });

    test('should change the title of the block on execute', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.title, 'New Title');
    });

    test('should return the original block on undo', () {
      final originalBlock = command.undo();
      expect(originalBlock.title, 'Old Title');
    });
  });
}
