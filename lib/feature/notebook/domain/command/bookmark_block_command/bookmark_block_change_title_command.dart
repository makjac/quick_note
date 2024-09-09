import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

class BookmarkBlockChangeTitleCommand extends NotebookCommand<BookmarksBlock> {
  BookmarkBlockChangeTitleCommand({
    required this.block,
    required this.newTitle,
  });

  final BookmarksBlock block;
  final String newTitle;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Bookmark Block: Change title";

  @override
  NotebookCommandType get type => NotebookCommandType.bookmark;

  @override
  BookmarksBlock execute() {
    return block.copyWith(title: newTitle);
  }

  @override
  BookmarksBlock undo() {
    return block;
  }
}
