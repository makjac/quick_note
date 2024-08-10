import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/url_helper.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/bookmarks_block_cubit/bookmarks_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/blocks/bookmarks/bookmark_favicon_widget.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/blocks/bookmarks/bookmark_item_widget.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

class BookmarksGridWidget extends StatelessWidget {
  const BookmarksGridWidget({
    super.key,
    required this.block,
  });

  final BookmarksBlock block;

  @override
  Widget build(BuildContext context) {
    return ReorderableGridView.builder(
      gridDelegate: _buildSliverGridDelegate(context),
      itemBuilder: (context, index) {
        return _buildElement(block.items[index], index);
      },
      itemCount: block.items.length,
      onReorder: (oldIndex, newIndex) => context
          .read<BookmarksBlockCubit>()
          .reorderBookmarks(oldIndex, newIndex),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      proxyDecorator: proxyDecorator,
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return Material(
      color: Colors.transparent,
      child: ScaleTransition(
        scale: animation.drive(
          Tween<double>(begin: 1, end: 1).chain(
            CurveTween(curve: Curves.linear),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(Insets.xs),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildElement(BookmarkItem bookmark, int index) {
    if (block.viewMode != BookmarkViewMode.icons) {
      return BookmarkItemWidget(
        key: ValueKey("${bookmark.id}"),
        index: index,
        item: bookmark,
        hasDraggableIcon: _hasDraggIcon(),
        showFavicon: block.visibleFavicons,
        duplicates: _calculateBookmarkDuplicate(bookmark.url),
      );
    } else {
      return InkWell(
        key: ValueKey("${bookmark.id}"),
        onTap: () => UrlHelper.launchUrl(bookmark.url),
        child: BookmarkFaviconWidget(faviconUrl: bookmark.faviconUrl),
      );
    }
  }

  SliverGridDelegate _buildSliverGridDelegate(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    if (block.viewMode == BookmarkViewMode.icons) {
      return const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
        crossAxisSpacing: Insets.xs,
        mainAxisSpacing: Insets.xs,
      );
    }
    return SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
      crossAxisCount: _caltulatecrossAxisCount(width),
      crossAxisSpacing: Insets.xs,
      mainAxisSpacing: Insets.xs,
      height: 64.0,
    );
  }

  int _caltulatecrossAxisCount(double width) {
    if (width < 200 || block.viewMode == BookmarkViewMode.list) return 1;
    if (width < AppConstans.mobileSize) return (width / 200).floor();
    return (width / 350).floor();
  }

  bool _hasDraggIcon() {
    return block.viewMode == BookmarkViewMode.list;
  }

  int? _calculateBookmarkDuplicate(String url) {
    final duplicates =
        block.items.where((bookmark) => bookmark.url == url).length;

    return duplicates > 1 ? duplicates - 1 : null;
  }
}

class SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight
    extends SliverGridDelegate {
  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.height = 56.0,
  })  : assert(crossAxisCount > 0),
        assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0),
        assert(height > 0);

  final int crossAxisCount;

  final double mainAxisSpacing;

  final double crossAxisSpacing;

  final double height;

  bool _debugAssertIsValid() {
    assert(crossAxisCount > 0);
    assert(mainAxisSpacing >= 0.0);
    assert(crossAxisSpacing >= 0.0);
    assert(height > 0.0);
    return true;
  }

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    assert(_debugAssertIsValid());
    final double usableCrossAxisExtent =
        constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
    final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
    final double childMainAxisExtent = height;
    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: childMainAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childMainAxisExtent: childMainAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(
      SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing ||
        oldDelegate.height != height;
  }
}
