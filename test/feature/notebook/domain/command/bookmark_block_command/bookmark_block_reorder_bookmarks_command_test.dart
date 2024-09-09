import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_reorder_bookmarks_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

void main() {
  group('BookmarkBlockReorderBookmarksCommand', () {
    late BookmarksBlock block;
    late BookmarkBlockReorderBookmarksCommand command;

    setUp(() {
      block = const BookmarksBlock(
        id: 1,
        items: [
          BookmarkItem(id: 1, title: 'Bookmark 1', url: 'http://example.com/1'),
          BookmarkItem(id: 2, title: 'Bookmark 2', url: 'http://example.com/2'),
          BookmarkItem(id: 3, title: 'Bookmark 3', url: 'http://example.com/3'),
        ],
      );
    });

    test('should reorder bookmarks correctly', () {
      command = BookmarkBlockReorderBookmarksCommand(
        block: block,
        oldIndex: 0,
        newIndex: 2,
      );

      final result = command.execute();

      expect(result.items[0].id, 2);
      expect(result.items[1].id, 3);
      expect(result.items[2].id, 1);
    });

    test('should return the original block on undo', () {
      command = BookmarkBlockReorderBookmarksCommand(
        block: block,
        oldIndex: 0,
        newIndex: 2,
      );

      final result = command.undo();

      expect(result.items[0].id, 1);
      expect(result.items[1].id, 2);
      expect(result.items[2].id, 3);
    });

    test('should have correct ownerId', () {
      command = BookmarkBlockReorderBookmarksCommand(
        block: block,
        oldIndex: 0,
        newIndex: 2,
      );

      expect(command.ownerId, block.id);
    });

    test('should have correct title', () {
      command = BookmarkBlockReorderBookmarksCommand(
        block: block,
        oldIndex: 0,
        newIndex: 2,
      );

      expect(command.getTitle(), "Bookmark Block: Reorder bookmarks");
    });

    test('should have correct type', () {
      command = BookmarkBlockReorderBookmarksCommand(
        block: block,
        oldIndex: 0,
        newIndex: 2,
      );

      expect(command.type, NotebookCommandType.bookmark);
    });
  });
}
