import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class BookmarkItem extends Equatable {
  const BookmarkItem({
    required this.id,
    this.title = "",
    this.url = "",
    this.faviconUrl = "",
    this.description = "",
  });

  @HiveField(0)
  final num id;
  @HiveField(10, defaultValue: "")
  final String title;
  @HiveField(20, defaultValue: "")
  final String url;
  @HiveField(25, defaultValue: "")
  final String faviconUrl;
  @HiveField(30, defaultValue: "")
  final String description;

  BookmarkItem copyWith({String? title, String? url, String? faviconUrl}) {
    return BookmarkItem(
      id: id,
      title: title ?? this.title,
      faviconUrl: faviconUrl ?? this.faviconUrl,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [id, title, faviconUrl, url];
}
