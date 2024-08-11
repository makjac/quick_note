import 'package:flutter_test/flutter_test.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';

void main() {
  group('BookmarkViewMode', () {
    test('should have correct values', () {
      expect(BookmarkViewMode.values, [
        BookmarkViewMode.list,
        BookmarkViewMode.grid,
        BookmarkViewMode.icons,
      ]);
    });
  });
}
