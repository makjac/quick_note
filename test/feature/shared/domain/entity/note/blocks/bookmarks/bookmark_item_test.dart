import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';

void main() {
  group('BookmarkItem', () {
    test('should create a BookmarkItem instance with default values', () {
      const bookmarkItem = BookmarkItem(id: 1);

      expect(bookmarkItem.id, 1);
      expect(bookmarkItem.title, "");
      expect(bookmarkItem.url, "");
      expect(bookmarkItem.faviconUrl, "");
      expect(bookmarkItem.description, "");
    });

    test('should create a BookmarkItem instance with custom values', () {
      const bookmarkItem = BookmarkItem(
        id: 2,
        title: "Example",
        url: "https://example.com",
        faviconUrl: "https://example.com/favicon.ico",
        description: "This is an example bookmark.",
      );

      expect(bookmarkItem.id, 2);
      expect(bookmarkItem.title, "Example");
      expect(bookmarkItem.url, "https://example.com");
      expect(bookmarkItem.faviconUrl, "https://example.com/favicon.ico");
      expect(bookmarkItem.description, "This is an example bookmark.");
    });

    test('should copy BookmarkItem with updated values using copyWith', () {
      const bookmarkItem = BookmarkItem(
        id: 3,
        title: "Example",
        url: "https://example.com",
        faviconUrl: "https://example.com/favicon.ico",
      );

      final updatedItem = bookmarkItem.copyWith(
        title: "Updated Example",
        url: "https://updated.com",
      );

      expect(updatedItem.id, 3); // id remains the same
      expect(updatedItem.title, "Updated Example"); // title updated
      expect(updatedItem.url, "https://updated.com"); // url updated
      expect(updatedItem.faviconUrl,
          "https://example.com/favicon.ico"); // faviconUrl remains the same
    });

    test('should compare two BookmarkItem instances with same values as equal',
        () {
      const bookmarkItem1 = BookmarkItem(
        id: 4,
        title: "Example",
        url: "https://example.com",
        faviconUrl: "https://example.com/favicon.ico",
      );

      const bookmarkItem2 = BookmarkItem(
        id: 4,
        title: "Example",
        url: "https://example.com",
        faviconUrl: "https://example.com/favicon.ico",
      );

      expect(bookmarkItem1, bookmarkItem2);
    });

    test(
        'should compare two BookmarkItem instances with different values as not equal',
        () {
      const bookmarkItem1 = BookmarkItem(
        id: 5,
        title: "Example 1",
        url: "https://example1.com",
        faviconUrl: "https://example1.com/favicon.ico",
      );

      const bookmarkItem2 = BookmarkItem(
        id: 5,
        title: "Example 2",
        url: "https://example2.com",
        faviconUrl: "https://example2.com/favicon.ico",
      );

      expect(bookmarkItem1, isNot(bookmarkItem2));
    });
  });
}
