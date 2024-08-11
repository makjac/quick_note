import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/bookmarks/bookmark_item.module.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/bookmarks/bookmarks_block.module.dart';

void main() {
  group('BookmarksBlockModel', () {
    test('should create a BookmarksBlockModel instance with correct properties',
        () {
      final bookmarkItemModel1 = BookmarkItemModel(
        id: 1,
        title: 'Item 1',
        url: 'http://example.com/1',
        faviconUrl: 'http://example.com/1/favicon.ico',
        description: 'Description 1',
      );

      final bookmarkItemModel2 = BookmarkItemModel(
        id: 2,
        title: 'Item 2',
        url: 'http://example.com/2',
        faviconUrl: 'http://example.com/2/favicon.ico',
        description: 'Description 2',
      );

      final bookmarksBlockModel = BookmarksBlockModel(
        id: 1,
        title: 'Bookmarks Block',
        hasTitle: true,
        items: [bookmarkItemModel1, bookmarkItemModel2],
        visibleFavicons: true,
        maxVisibleBookmakrs: 10,
        viewMode: BookmarkViewMode.grid,
      );

      expect(bookmarksBlockModel.id, 1);
      expect(bookmarksBlockModel.title, 'Bookmarks Block');
      expect(bookmarksBlockModel.hasTitle, true);
      expect(
          bookmarksBlockModel.items, [bookmarkItemModel1, bookmarkItemModel2]);
      expect(bookmarksBlockModel.visibleFavicons, true);
      expect(bookmarksBlockModel.maxVisibleBookmakrs, 10);
      expect(bookmarksBlockModel.viewMode, BookmarkViewMode.grid);
    });
  });
}
