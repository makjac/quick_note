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
  });
}
