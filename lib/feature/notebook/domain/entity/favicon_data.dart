import 'package:equatable/equatable.dart';

class FaviconData extends Equatable {
  const FaviconData({
    required this.url,
    this.sizes,
    this.type,
  });

  final String url;
  final String? sizes;
  final String? type;

  @override
  List<Object?> get props => [url, sizes, type];
}
