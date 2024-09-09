import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_add_bookmark_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

void main() {
  group('BookmarkBlockAddBookmarkCommand', () {
    late BookmarksBlock block;
    late BookmarkBlockAddBookmarkCommand command;

    setUp(() {
      block = const BookmarksBlock(
        id: 1,
        items: [
          BookmarkItem(
              id: 1,
              title: 'Example',
              url: 'https://example.com',
              faviconUrl: 'https://example.com/favicon.ico'),
        ],
      );
      command = BookmarkBlockAddBookmarkCommand(
        block: block,
        url: 'https://newsite.com',
        faviconUrl: 'https://newsite.com/favicon.ico',
      );
    });

    test('should add a new bookmark to the block', () {
      final updatedBlock = command.execute();

      expect(updatedBlock.items.length, 2);
      expect(updatedBlock.items.last.url, 'https://newsite.com');
      expect(updatedBlock.items.last.faviconUrl,
          'https://newsite.com/favicon.ico');
    });

    test('should generate a new id for the new bookmark', () {
      final updatedBlock = command.execute();

      expect(updatedBlock.items.last.id, 2);
    });

    test('should use the domain as the title if no title is provided', () {
      final updatedBlock = command.execute();

      expect(updatedBlock.items.last.title, 'newsite.com');
    });

    test('should return the original block on undo', () {
      final originalBlock = command.undo();

      expect(originalBlock, block);
    });
  });
}
