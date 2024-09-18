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

  factory BookmarkItemModel.fromJson(Map<String, dynamic> json) {
    return BookmarkItemModel(
      id: json['id'] as num,
      title: json['title'] as String? ?? "",
      url: json['url'] as String? ?? "",
      faviconUrl: json['faviconUrl'] as String? ?? "",
      description: json['description'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'faviconUrl': faviconUrl,
      'description': description,
    };
  }

  @override
  List<Object?> get props => [id, title, url, faviconUrl, description];
}
