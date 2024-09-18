import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/bookmarks/bookmark_item.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';

void main() {
  group('BookmarkItemModel', () {
    test('should create a BookmarkItemModel instance with correct properties',
        () {
      final bookmarkItemModel = BookmarkItemModel(
        id: 1,
        title: 'Sample Title',
        url: 'http://example.com',
        faviconUrl: 'http://example.com/favicon.ico',
        description: 'Sample Description',
      );

      expect(bookmarkItemModel.id, 1);
      expect(bookmarkItemModel.title, 'Sample Title');
      expect(bookmarkItemModel.url, 'http://example.com');
      expect(bookmarkItemModel.faviconUrl, 'http://example.com/favicon.ico');
      expect(bookmarkItemModel.description, 'Sample Description');
    });

    test('should convert BookmarkItem to BookmarkItemModel using fromEntity',
        () {
      const bookmarkItem = BookmarkItem(
        id: 1,
        title: 'Sample Title',
        url: 'http://example.com',
        faviconUrl: 'http://example.com/favicon.ico',
        description: 'Sample Description',
      );

      final bookmarkItemModel = BookmarkItemModel.fromEntity(bookmarkItem);

      expect(bookmarkItemModel.id, bookmarkItem.id);
      expect(bookmarkItemModel.title, bookmarkItem.title);
      expect(bookmarkItemModel.url, bookmarkItem.url);
      expect(bookmarkItemModel.faviconUrl, bookmarkItem.faviconUrl);
      expect(bookmarkItemModel.description, bookmarkItem.description);
    });

    test('should convert JSON to BookmarkItemModel using fromJson', () {
      final json = {
        'id': 1,
        'title': 'Sample Title',
        'url': 'http://example.com',
        'faviconUrl': 'http://example.com/favicon.ico',
        'description': 'Sample Description',
      };

      final bookmarkItemModel = BookmarkItemModel.fromJson(json);

      expect(bookmarkItemModel.id, 1);
      expect(bookmarkItemModel.title, 'Sample Title');
      expect(bookmarkItemModel.url, 'http://example.com');
      expect(bookmarkItemModel.faviconUrl, 'http://example.com/favicon.ico');
      expect(bookmarkItemModel.description, 'Sample Description');
    });

    test(
        'should compare two BookmarkItemModel instances with the same values as equal',
        () {
      final bookmarkItemModel1 = BookmarkItemModel(
        id: 1,
        title: 'Sample Title',
        url: 'http://example.com',
        faviconUrl: 'http://example.com/favicon.ico',
        description: 'Sample Description',
      );

      final bookmarkItemModel2 = BookmarkItemModel(
        id: 1,
        title: 'Sample Title',
        url: 'http://example.com',
        faviconUrl: 'http://example.com/favicon.ico',
        description: 'Sample Description',
      );

      expect(bookmarkItemModel1, bookmarkItemModel2);
    });

    test(
        'should compare two BookmarkItemModel instances with different values as not equal',
        () {
      final bookmarkItemModel1 = BookmarkItemModel(
        id: 1,
        title: 'Sample Title',
        url: 'http://example.com',
        faviconUrl: 'http://example.com/favicon.ico',
        description: 'Sample Description',
      );

      final bookmarkItemModel2 = BookmarkItemModel(
        id: 2,
        title: 'Different Title',
        url: 'http://different.com',
        faviconUrl: 'http://different.com/favicon.ico',
        description: 'Different Description',
      );

      expect(bookmarkItemModel1, isNot(bookmarkItemModel2));
    });
  });
}
