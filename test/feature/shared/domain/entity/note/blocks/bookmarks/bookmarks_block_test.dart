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

    test('should create a BookmarksBlock instance with custom values', () {
      const items = [
        BookmarkItem(id: 1, title: "Google", url: "https://google.com"),
        BookmarkItem(id: 2, title: "Flutter", url: "https://flutter.dev"),
      ];

      const bookmarksBlock = BookmarksBlock(
        id: 2,
        title: "Bookmarks",
        hasTitle: false,
        items: items,
        visibleFavicons: false,
        maxVisibleBookmakrs: 5,
        viewMode: BookmarkViewMode.grid,
      );

      expect(bookmarksBlock.id, 2);
      expect(bookmarksBlock.title, "Bookmarks");
      expect(bookmarksBlock.hasTitle, false);
      expect(bookmarksBlock.type, NoteBlockType.bookmarks);
      expect(bookmarksBlock.items, items);
      expect(bookmarksBlock.visibleFavicons, false);
      expect(bookmarksBlock.maxVisibleBookmakrs, 5);
      expect(bookmarksBlock.viewMode, BookmarkViewMode.grid);
    });
  });
}
