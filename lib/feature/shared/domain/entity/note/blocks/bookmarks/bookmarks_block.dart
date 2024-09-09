import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

class BookmarksBlock extends NoteBlock {
  const BookmarksBlock({
    required super.id,
    super.title = "",
    super.hasTitle = false,
    super.type = NoteBlockType.bookmarks,
    this.items = const [],
    this.visibleFavicons = true,
    this.maxVisibleBookmakrs,
    this.viewMode = BookmarkViewMode.list,
  });

  final List<BookmarkItem> items;
  @HiveField(30, defaultValue: true)
  final bool visibleFavicons;
  @HiveField(40, defaultValue: null)
  final int? maxVisibleBookmakrs;
  @HiveField(50, defaultValue: BookmarkViewMode.list)
  final BookmarkViewMode viewMode;

  BookmarksBlock copyWith({
    num? id,
    String? title,
    bool? hasTitle,
    List<BookmarkItem>? items,
    bool? visibleFavicons,
    int? maxVisibleBookmakrs,
    BookmarkViewMode? viewMode,
  }) {
    return BookmarksBlock(
      id: id ?? this.id,
      title: title ?? this.title,
      hasTitle: hasTitle ?? this.hasTitle,
      items: items ?? this.items,
      visibleFavicons: visibleFavicons ?? this.visibleFavicons,
      maxVisibleBookmakrs: maxVisibleBookmakrs ?? this.maxVisibleBookmakrs,
      viewMode: viewMode ?? this.viewMode,
      type: type,
    );
  }

  @override
  List<Object?> get props => [
        super.props,
        id,
        title,
        hasTitle,
        type,
        items,
        visibleFavicons,
        maxVisibleBookmakrs,
        viewMode
      ];
}
