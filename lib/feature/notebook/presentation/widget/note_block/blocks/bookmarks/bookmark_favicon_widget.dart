import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class BookmarkFaviconWidget extends StatelessWidget {
  const BookmarkFaviconWidget({super.key, required this.faviconUrl});

  final String faviconUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Theme.of(context).bookmarkFaviconBackgroundColor,
      child: _buildFaviconImage(),
    );
  }

  Widget _buildFaviconImage() {
    if (faviconUrl.isEmpty) {
      return const NoFaviconWidget();
    }
    if (faviconUrl.endsWith(".svg")) {
      return SvgPicture.network(
        faviconUrl,
        width: 32,
        height: 32,
        placeholderBuilder: (context) => const NoFaviconWidget(),
      );
    }
    return CachedNetworkImage(
      imageUrl: faviconUrl,
      width: 32,
      height: 32,
      errorWidget: (context, url, error) => const NoFaviconWidget(),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(
        value: downloadProgress.progress ?? 0.0,
        color: Colors.black87,
        strokeWidth: 3.0,
      ),
    );
  }
}

class NoFaviconWidget extends StatelessWidget {
  const NoFaviconWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Theme.of(context).bookmarkFaviconBackgroundColor,
      child: const Icon(Icons.link_off, color: Colors.black),
    );
  }
}
