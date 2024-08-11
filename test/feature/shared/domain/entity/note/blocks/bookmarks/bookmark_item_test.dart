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
  });
}
