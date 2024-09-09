import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_remove_bookmark_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';

void main() {
  group('BookmarkBlockRemoveBookmarkCommand', () {
    late BookmarksBlock block;
    late BookmarkBlockRemoveBookmarkCommand command;

    setUp(() {
      block = const BookmarksBlock(
        id: 1,
        items: [
          BookmarkItem(id: 1, title: 'Bookmark 1', url: 'http://example.com/1'),
          BookmarkItem(id: 2, title: 'Bookmark 2', url: 'http://example.com/2'),
        ],
      );
      command = BookmarkBlockRemoveBookmarkCommand(
        block: block,
        bookmarkId: 1,
      );
    });

    test('should remove the bookmark with the given id', () {
      final updatedBlock = command.execute();

      expect(updatedBlock.items.length, 1);
      expect(updatedBlock.items.first.id, 2);
    });

    test('should return the original block on undo', () {
      final originalBlock = command.undo();

      expect(originalBlock.items.length, 2);
      expect(originalBlock.items.first.id, 1);
      expect(originalBlock.items.last.id, 2);
    });

    test('should have the correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should have the correct title', () {
      expect(command.getTitle(), "Bookmark Block: Remove bookmark");
    });

    test('should have the correct type', () {
      expect(command.type, NotebookCommandType.bookmark);
    });
  });
}
