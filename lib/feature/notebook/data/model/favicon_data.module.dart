import 'package:quick_note/feature/notebook/domain/entity/favicon_data.dart';

class FaviconDataModel extends FaviconData
    implements Comparable<FaviconDataModel> {
  const FaviconDataModel({
    required super.url,
    super.sizes,
    super.type,
  });

  factory FaviconDataModel.fromEntity(FaviconData data) {
    return FaviconDataModel(
      url: data.url,
      sizes: data.sizes,
      type: data.type,
    );
  }

  FaviconDataModel copyWith({
    String? url,
    String? sizes,
    String? type,
  }) {
    return FaviconDataModel(
      url: url ?? this.url,
      sizes: sizes ?? this.sizes,
      type: type ?? this.type,
    );
  }

  @override
  int compareTo(FaviconDataModel other) {
    if (url.endsWith('.svg') && other.url.endsWith('.svg')) {
      return url.length.compareTo(other.url.length);
    }

    if (url.endsWith('.svg')) return -1;
    if (other.url.endsWith('.svg')) return 1;

    int thisSize = _parseSize(sizes);
    int otherSize = _parseSize(other.sizes);

    if (thisSize == otherSize) {
      return url.length.compareTo(other.url.length);
    }

    return otherSize.compareTo(thisSize);
  }

  int _parseSize(String? size) {
    if (size == null) return 16;
    var sizeParts = size.split('x');
    if (sizeParts.length == 2) {
      return int.parse(sizeParts[0]);
    }
    return 16;
  }

  @override
  List<Object?> get props => [url, sizes, type];
}
