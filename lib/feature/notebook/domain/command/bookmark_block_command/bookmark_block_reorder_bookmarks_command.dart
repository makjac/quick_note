import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

class BookmarkBlockReorderBookmarksCommand
    extends NotebookCommand<BookmarksBlock> {
  BookmarkBlockReorderBookmarksCommand({
    required this.block,
    required this.oldIndex,
    required this.newIndex,
  });

  final BookmarksBlock block;
  final int oldIndex;
  final int newIndex;

  @override
  num? get ownerId => block.id;

  @override
  String getTitle() => "Bookmark Block: Reorder bookmarks";

  @override
  NotebookCommandType get type => NotebookCommandType.bookmark;

  @override
  BookmarksBlock execute() {
    final updatedItems = List<BookmarkItem>.from(block.items);
    final item = updatedItems.removeAt(oldIndex);
    updatedItems.insert(newIndex, item);

    return block.copyWith(items: updatedItems);
  }

  @override
  BookmarksBlock undo() {
    return block;
  }
}
