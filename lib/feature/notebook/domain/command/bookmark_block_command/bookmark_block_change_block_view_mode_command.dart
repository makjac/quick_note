import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

class BookmarkBlockChangeBlockViewModeCommand
    extends NotebookCommand<BookmarksBlock> {
  BookmarkBlockChangeBlockViewModeCommand({
    required this.block,
    required this.newViewMode,
  });

  final BookmarksBlock block;
  final BookmarkViewMode newViewMode;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Bookmark Block: Change block view mode";

  @override
  NotebookCommandType get type => NotebookCommandType.bookmark;

  @override
  BookmarksBlock execute() {
    return block.copyWith(viewMode: newViewMode);
  }

  @override
  BookmarksBlock undo() {
    return block;
  }
}
