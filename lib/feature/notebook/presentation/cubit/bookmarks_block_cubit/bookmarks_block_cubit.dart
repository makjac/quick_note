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

    final updatedBlock = state.block.copyWith(hasTitle: visible);
    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> changeFaviconsVisibility(bool? visible) async {
    if (visible == null) return;

    final updatedBlock = state.block.copyWith(visibleFavicons: visible);
    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> changeBookmarksViewMode(BookmarkViewMode? visible) async {
    if (visible == null) return;

    final updatedBlock = state.block.copyWith(viewMode: visible);
    emit(state.copyWith(block: updatedBlock));
  }

  FutureOr<void> changeBlockTitle(String title) {
    final updatedBlock = state.block.copyWith(title: title);
    emit(state.copyWith(block: updatedBlock));
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
    _addBookmark(url, "");
  }

  void _addBookmarkWithFavicon(String url, String? favicon) {
    _addBookmark(url, favicon);
  }
}
