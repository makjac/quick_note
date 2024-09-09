import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

class BookmarkBlockTitleVisibilityCommand
    extends NotebookCommand<BookmarksBlock> {
  BookmarkBlockTitleVisibilityCommand({
    required this.block,
    required this.isVisible,
  });

  final BookmarksBlock block;
  final bool isVisible;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Bookmark Block: Change title visibility";

  @override
  NotebookCommandType get type => NotebookCommandType.bookmark;

  @override
  BookmarksBlock execute() {
    return block.copyWith(hasTitle: isVisible);
  }

  @override
  BookmarksBlock undo() {
    return block;
  }
}
