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
      expect(bookmarksBlock.hasTitle, false);
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

    test('should correctly copy a BookmarksBlock using copyWith', () {
      const originalItems = [
        BookmarkItem(id: 1, title: "Google", url: "https://google.com"),
      ];

      const bookmarksBlock = BookmarksBlock(
        id: 3,
        title: "Old Bookmarks",
        items: originalItems,
        visibleFavicons: true,
        maxVisibleBookmakrs: 3,
        viewMode: BookmarkViewMode.list,
      );

      final updatedBlock = bookmarksBlock.copyWith(
        title: "Updated Bookmarks",
        visibleFavicons: false,
        maxVisibleBookmakrs: 10,
        viewMode: BookmarkViewMode.icons,
      );

      expect(updatedBlock.id, 3); // id remains the same
      expect(updatedBlock.title, "Updated Bookmarks"); // title updated
      expect(updatedBlock.items, originalItems); // items remain the same
      expect(updatedBlock.visibleFavicons, false); // visibleFavicons updated
      expect(
          updatedBlock.maxVisibleBookmakrs, 10); // maxVisibleBookmakrs updated
      expect(updatedBlock.viewMode, BookmarkViewMode.icons); // viewMode updated
    });

    test(
        'should compare two BookmarksBlock instances with the same values as equal',
        () {
      const items = [
        BookmarkItem(id: 1, title: "Google", url: "https://google.com"),
      ];

      const block1 = BookmarksBlock(
        id: 4,
        title: "Bookmarks",
        items: items,
        visibleFavicons: true,
        maxVisibleBookmakrs: 5,
        viewMode: BookmarkViewMode.list,
      );

      const block2 = BookmarksBlock(
        id: 4,
        title: "Bookmarks",
        items: items,
        visibleFavicons: true,
        maxVisibleBookmakrs: 5,
        viewMode: BookmarkViewMode.list,
      );

      expect(block1, block2);
    });

    test(
        'should compare two BookmarksBlock instances with different values as not equal',
        () {
      const items1 = [
        BookmarkItem(id: 1, title: "Google", url: "https://google.com"),
      ];

      const items2 = [
        BookmarkItem(id: 2, title: "Flutter", url: "https://flutter.dev"),
      ];

      const block1 = BookmarksBlock(
        id: 5,
        title: "Bookmarks 1",
        items: items1,
        visibleFavicons: true,
        maxVisibleBookmakrs: 5,
        viewMode: BookmarkViewMode.list,
      );

      const block2 = BookmarksBlock(
        id: 5,
        title: "Bookmarks 2",
        items: items2,
        visibleFavicons: false,
        maxVisibleBookmakrs: 10,
        viewMode: BookmarkViewMode.icons,
      );

      expect(block1, isNot(block2));
    });
  });
}
