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

  factory BookmarksBlockModel.fromEntity(BookmarksBlock block) {
    return BookmarksBlockModel(
      id: block.id,
      title: block.title,
      hasTitle: block.hasTitle,
      type: block.type,
      items: block.items.map(BookmarkItemModel.fromEntity).toList(),
      visibleFavicons: block.visibleFavicons,
      maxVisibleBookmakrs: block.maxVisibleBookmakrs,
      viewMode: block.viewMode,
    );
  }

  factory BookmarksBlockModel.fromJson(Map<String, dynamic> json) {
    return BookmarksBlockModel(
      id: json['id'] as num,
      title: json['title'] as String,
      hasTitle: json['hasTitle'] as bool,
      type: NoteBlockType.values[json['type'] as int],
      items: (json['items'] as List<dynamic>)
          .map((item) =>
              BookmarkItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      visibleFavicons: json['visibleFavicons'] as bool,
      maxVisibleBookmakrs: json['maxVisibleBookmakrs'] as int?,
      viewMode: BookmarkViewMode.values[json['viewMode'] as int],
    );
  }

  @override
  @HiveField(20, defaultValue: [])
  final List<BookmarkItemModel> items;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'hasTitle': hasTitle,
      'type': type.index,
      'items': items.map((item) => item.toJson()).toList(),
      'visibleFavicons': visibleFavicons,
      'maxVisibleBookmakrs': maxVisibleBookmakrs,
      'viewMode': viewMode.index,
    };
  }

  @override
  List<Object?> get props => [super.props, title, hasTitle, items, type];
}
