import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

class BookmarkBlockRemoveBookmarkCommand
    extends NotebookCommand<BookmarksBlock> {
  BookmarkBlockRemoveBookmarkCommand({
    required this.block,
    required this.bookmarkId,
  });

  final BookmarksBlock block;
  final num bookmarkId;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Bookmark Block: Remove bookmark";

  @override
  NotebookCommandType get type => NotebookCommandType.bookmark;

  @override
  BookmarksBlock execute() {
    return block.copyWith(
      items: block.items.where((item) => item.id != bookmarkId).toList(),
    );
  }

  @override
  BookmarksBlock undo() {
    return block;
  }
}
