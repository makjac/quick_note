import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_toggle_show_favicon_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

void main() {
  group('BookmarkBlockToggleShowFaviconCommand', () {
    late BookmarksBlock block;
    late BookmarkBlockToggleShowFaviconCommand command;

    setUp(() {
      block = const BookmarksBlock(id: 1, visibleFavicons: false);
      command = BookmarkBlockToggleShowFaviconCommand(
          block: block, showFavicon: true);
    });

    test('should return correct ownerId', () {
      expect(command.ownerId, block.id);
    });

    test('should return correct title', () {
      expect(command.getTitle(), "Bookmark Block: Toggle show favicon");
    });

    test('should return correct type', () {
      expect(command.type, NotebookCommandType.bookmark);
    });

    test('should execute command and toggle show favicon', () {
      final updatedBlock = command.execute();
      expect(updatedBlock.visibleFavicons, true);
    });

    test('should undo command and return original block', () {
      final originalBlock = command.undo();
      expect(originalBlock.visibleFavicons, false);
    });
  });
}
