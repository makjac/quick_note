import 'package:equatable/equatable.dart';

class FaviconData extends Equatable {
  final String url;
  final String? sizes;
  final String? type;

  const FaviconData({
    required this.url,
    this.sizes,
    this.type,
  });

  @override
  List<Object?> get props => [url, sizes, type];
}
