import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/core/utils/url_helper.dart';
import 'package:quick_note/feature/notebook/domain/usecase/fetch_best_favicon_url_usecase.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

part 'bookmarks_block_state.dart';

class BookmarksBlockCubit extends Cubit<BookmarksBlockState> {
  BookmarksBlockCubit({
    BookmarksBlock? block,
    required this.fetchBestFaviconUrlUsecase,
  }) : super(BookmarksBlockState(block: block));

  final FetchBestFaviconUrlUsecase fetchBestFaviconUrlUsecase;

  FutureOr<void> loadBlock(BookmarksBlock block) async {
    emit(state.copyWith(block: block));
  }

  Future<void> changeBlockTitleVisibility(bool? visible) async {
    if (visible == null) return;

    final command = BookmarkBlockTitleVisibilityCommand(
        block: state.block, isVisible: visible);

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> changeFaviconsVisibility(bool? visible) async {
    if (visible == null) return;

    final command = BookmarkBlockToggleShowFaviconCommand(
        block: state.block, showFavicon: visible);

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  Future<void> changeBookmarksViewMode(BookmarkViewMode? visible) async {
    if (visible == null) return;

    final command = BookmarkBlockChangeBlockViewModeCommand(
        block: state.block, newViewMode: visible);

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  FutureOr<void> changeBlockTitle(String title) {
    final command =
        BookmarkBlockChangeTitleCommand(block: state.block, newTitle: title);

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  FutureOr<void> addBookmark(String url) async {
    emit(state.copyWith(addingStatus: AddBookmarkStatus.loading));

    try {
      final faviconUrl = await fetchBestFaviconUrlUsecase.call(url);

      faviconUrl.fold(
        (failure) => _addBookmarkWithoutFavicon(url),
        (favicon) => _addBookmarkWithFavicon(url, favicon),
      );
    } catch (e) {
      emit(state.copyWith(addingStatus: AddBookmarkStatus.error));
    }
  }

  void _addBookmarkWithoutFavicon(String url) {
    _addBookmark(url, "", AddBookmarkStatus.error);
  }

  void _addBookmarkWithFavicon(String url, String? favicon) {
    _addBookmark(url, favicon, AddBookmarkStatus.success);
  }

  void _addBookmark(String url, String? faviconUrl, AddBookmarkStatus status) {
    final command = BookmarkBlockAddBookmarkCommand(
      block: state.block,
      url: url,
      faviconUrl: faviconUrl,
    );

    final updatedBlock = command.execute();
    emit(state.copyWith(
        block: updatedBlock, addingStatus: status, command: command));
  }

  FutureOr<void> removeBookmark(num id) {
    final updatedBlock = state.block.copyWith(
      items: state.block.items.where((item) => item.id != id).toList(),
    );

    emit(state.copyWith(block: updatedBlock));
  }

  FutureOr<void> updateBookmark(BookmarkItem item) {
    final updatedBlock = state.block.copyWith(
      items: state.block.items.map((oldItem) {
        if (oldItem.id == item.id) {
          return item;
        }
        return oldItem;
      }).toList(),
    );

    emit(state.copyWith(block: updatedBlock));
  }

  FutureOr<void> reorderBookmarks(int oldIndex, int newIndex) {
    final updatedItems = List<BookmarkItem>.from(state.block.items);
    final item = updatedItems.removeAt(oldIndex);
    updatedItems.insert(newIndex, item);

    final updatedBlock = state.block.copyWith(items: updatedItems);

    emit(state.copyWith(block: updatedBlock));
  }

  FutureOr<void> clearBookmarks() {
    final updatedBlock = state.block.copyWith(items: []);

    emit(state.copyWith(block: updatedBlock));
  }
}
