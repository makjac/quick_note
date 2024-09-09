import 'package:quick_note/core/utils/url_helper.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

class BookmarkBlockAddBookmarkCommand extends NotebookCommand<BookmarksBlock> {
  BookmarkBlockAddBookmarkCommand({
    required this.block,
    required this.url,
    this.faviconUrl,
  });

  final BookmarksBlock block;
  final String? faviconUrl;
  final String url;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Bookmark Block: Add bookmark";

  @override
  NotebookCommandType get type => NotebookCommandType.bookmark;

  @override
  BookmarksBlock execute() {
    final domain = UrlHelper.extractDomain(url);
    final maxId = block.items.isNotEmpty
        ? block.items.map((item) => item.id).reduce((a, b) => a > b ? a : b)
        : 0;

    final newBookmark = BookmarkItem(
      id: maxId + 1,
      title: domain,
      url: url,
      faviconUrl: faviconUrl ?? "",
    );

    return block.copyWith(
      items: [...block.items, newBookmark],
    );
  }

  @override
  BookmarksBlock undo() {
    return block;
  }
}
