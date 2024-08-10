// ignore_for_file: must_be_immutable

import 'package:hive/hive.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';

part 'bookmark_item.module.g.dart';

@HiveType(typeId: 8)
class BookmarkItemModel extends BookmarkItem with HiveObjectMixin {
  BookmarkItemModel({
    required super.id,
    super.title = "",
    super.url = "",
    super.faviconUrl = "",
    super.description = "",
  });

  factory BookmarkItemModel.fromEntity(BookmarkItem item) {
    return BookmarkItemModel(
      id: item.id,
      title: item.title,
      url: item.url,
      faviconUrl: item.faviconUrl,
      description: item.description,
    );
  }

  @override
  List<Object?> get props => [id, title, url, faviconUrl, description];
}
