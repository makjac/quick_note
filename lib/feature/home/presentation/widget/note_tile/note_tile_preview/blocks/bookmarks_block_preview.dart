part of '../note_tile_preview_builder.dart';

class BookmarksBlockPreview extends StatelessWidget {
  const BookmarksBlockPreview({super.key, required this.content});

  final BookmarksBlock content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BookmarksItemsPreview(items: content.items),
        _RemainingBookmarksItemsCount(items: content.items),
      ],
    );
  }
}

class _BookmarksItemsPreview extends StatelessWidget {
  const _BookmarksItemsPreview({required this.items});

  final List<BookmarkItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .take(4)
          .map((item) => _BookmarkItemPreview(item: item))
          .toList(),
    );
  }
}

class _RemainingBookmarksItemsCount extends StatelessWidget {
  const _RemainingBookmarksItemsCount({required this.items});

  final List<BookmarkItem> items;

  int countOfRemainingElements() => items.length - 4;

  @override
  Widget build(BuildContext context) {
    return items.length > 4
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.xxs),
            child: Text(
              "+ ${countOfRemainingElements()} items",
              style: TextStyle(color: Theme.of(context).noteTilecontentColor),
            ),
          )
        : const SizedBox.shrink();
  }
}

class _BookmarkItemPreview extends StatelessWidget {
  const _BookmarkItemPreview({required this.item});

  final BookmarkItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildFavicon(),
          const SizedBox(width: Insets.xs),
          Flexible(
            child: Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Theme.of(context).noteTilecontentColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavicon() {
    const iconSize = 16.0;
    if (item.faviconUrl.isEmpty) {
      return _noFaviconWidget();
    }
    if (item.faviconUrl.endsWith(".svg")) {
      return SvgPicture.network(
        item.faviconUrl,
        width: iconSize,
        height: iconSize,
        placeholderBuilder: (context) => _noFaviconWidget(),
      );
    }
    return CachedNetworkImage(
      imageUrl: item.faviconUrl,
      width: iconSize,
      height: iconSize,
      errorWidget: (context, url, error) => _noFaviconWidget(),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(
        value: downloadProgress.progress ?? 0.0,
        color: Colors.black87,
        strokeWidth: 3.0,
      ),
    );
  }

  Widget _noFaviconWidget() {
    return const Icon(
      Icons.link,
      size: 18,
    );
  }
}
