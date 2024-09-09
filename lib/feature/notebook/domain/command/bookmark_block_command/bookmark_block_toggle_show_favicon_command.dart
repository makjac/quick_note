import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

class BookmarkBlockToggleShowFaviconCommand
    extends NotebookCommand<BookmarksBlock> {
  BookmarkBlockToggleShowFaviconCommand({
    required this.block,
    required this.showFavicon,
  });

  final BookmarksBlock block;
  final bool showFavicon;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Bookmark Block: Toggle show favicon";

  @override
  NotebookCommandType get type => NotebookCommandType.bookmark;

  @override
  BookmarksBlock execute() {
    return block.copyWith(visibleFavicons: showFavicon);
  }

  @override
  BookmarksBlock undo() {
    return block;
  }
}
