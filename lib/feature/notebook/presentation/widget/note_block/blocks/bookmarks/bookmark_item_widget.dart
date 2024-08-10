import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/url_helper.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/bookmarks_block_cubit/bookmarks_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/blocks/bookmarks/bookmark_favicon_widget.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class BookmarkItemWidget extends StatelessWidget {
  const BookmarkItemWidget({
    super.key,
    required this.item,
    required this.index,
    this.hasDraggableIcon = true,
    this.showFavicon = true,
    this.duplicates,
  });

  final num index;
  final BookmarkItem item;
  final bool hasDraggableIcon;
  final bool showFavicon;
  final int? duplicates;

  void _launchUrl() async {
    await UrlHelper.launchUrl(item.url);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchUrl,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Insets.xs),
        child: Row(
          children: [
            if (hasDraggableIcon) _buildDragHandle(context),
            const SizedBox(width: Insets.xs),
            if (showFavicon) _buildFavicon(context),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: Insets.xxs),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      item.url,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).bookmarkFullUrlColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _buildRemoveBookmarkButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFavicon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: Insets.xs),
      child: Badge(
        label: Tooltip(
          message: context.l10n.bookmark_duplicates_tooltip(duplicates ?? 0),
          child: Text(duplicates.toString()),
        ),
        isLabelVisible: duplicates != null,
        child: BookmarkFaviconWidget(faviconUrl: item.faviconUrl),
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context) {
    return Icon(
      Icons.drag_indicator,
      color: Theme.of(context).bookmarkDragIconColor,
    );
  }

  Widget _buildRemoveBookmarkButton(BuildContext context) {
    return Tooltip(
      message: context.l10n.bookmark_remove_tooltip,
      child: IconButton(
        onPressed: () =>
            context.read<BookmarksBlockCubit>().removeBookmark(item.id),
        icon: Icon(
          Icons.clear,
          color: Theme.of(context).bookmarkDeleteIconColor,
        ),
      ),
    );
  }
}
