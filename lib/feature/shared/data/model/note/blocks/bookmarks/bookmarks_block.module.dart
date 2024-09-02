// ignore_for_file: must_be_immutable, overridden_fields

import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/data/model/note/blocks/bookmarks/bookmark_item.module.dart';
import 'package:quick_note/feature/shared/data/model/note/note_block.module.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

part 'bookmarks_block.module.g.dart';

@HiveType(typeId: 7)
class BookmarksBlockModel extends BookmarksBlock implements NoteBlockModel {
  factory BookmarksBlockModel.fromEntity(BookmarksBlock block) {
    return BookmarksBlockModel(
      id: block.id,
      title: block.title,
      hasTitle: block.hasTitle,
      items: block.items.map(BookmarkItemModel.fromEntity).toList(),
      visibleFavicons: block.visibleFavicons,
      maxVisibleBookmakrs: block.maxVisibleBookmakrs,
      viewMode: block.viewMode,
    );
  }

  const BookmarksBlockModel({
    required super.id,
    super.title = "",
    super.hasTitle = true,
    super.type = NoteBlockType.bookmarks,
    this.items = const [],
    super.visibleFavicons = true,
    super.maxVisibleBookmakrs,
    super.viewMode = BookmarkViewMode.list,
  }) : super(items: items);

  @override
  @HiveField(20, defaultValue: [])
  final List<BookmarkItemModel> items;

  @override
  List<Object?> get props => [super.props, title, hasTitle, items, type];
}
