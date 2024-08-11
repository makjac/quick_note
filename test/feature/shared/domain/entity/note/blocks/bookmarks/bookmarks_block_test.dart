import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

void main() {
  group('BookmarksBlock', () {
    test('should create a BookmarksBlock instance with default values', () {
      const bookmarksBlock = BookmarksBlock(id: 1);

      expect(bookmarksBlock.id, 1);
      expect(bookmarksBlock.title, "");
      expect(bookmarksBlock.hasTitle, true);
      expect(bookmarksBlock.type, NoteBlockType.bookmarks);
      expect(bookmarksBlock.items, []);
      expect(bookmarksBlock.visibleFavicons, true);
      expect(bookmarksBlock.maxVisibleBookmakrs, null);
      expect(bookmarksBlock.viewMode, BookmarkViewMode.list);
    });
  });
}
