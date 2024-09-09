import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_add_bookmark_command.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_change_block_view_mode_command.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_change_title_command.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_remove_bookmark_command.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_reorder_bookmarks_command.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_title_visibility_command.dart';
import 'package:quick_note/feature/notebook/domain/command/bookmark_block_command/bookmark_block_toggle_show_favicon_command.dart';
import 'package:quick_note/feature/notebook/domain/command/notebook_command.dart';
import 'package:quick_note/feature/notebook/domain/usecase/fetch_best_favicon_url_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

part 'bookmarks_block_state.dart';

class BookmarksBlockCubit extends Cubit<BookmarksBlockState> {
  BookmarksBlockCubit({
    required NotebookBloc notebookBloc,
    BookmarksBlock? block,
    required this.fetchBestFaviconUrlUsecase,
  }) : super(BookmarksBlockState(block: block)) {
    notebookBlocSubscription = notebookBloc.stream.listen((notebookState) {
      if (notebookState is NotebookNoteBlockCommand) {
        if (notebookState.command.type != NotebookCommandType.bookmark) return;
        if (notebookState.command.ownerId != state.block.id) return;
        if (notebookState.isUndo) {
          undo(notebookState.command);
        } else {
          redo(notebookState.command);
        }
      }
    });
  }

  final FetchBestFaviconUrlUsecase fetchBestFaviconUrlUsecase;
  StreamSubscription<NotebookState>? notebookBlocSubscription;

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
    final command = BookmarkBlockRemoveBookmarkCommand(
      block: state.block,
      bookmarkId: id,
    );

    final updatedBlock = command.execute();
    emit(state.copyWith(block: updatedBlock, command: command));
  }

  FutureOr<void> reorderBookmarks(int oldIndex, int newIndex) {
    final command = BookmarkBlockReorderBookmarksCommand(
      block: state.block,
      oldIndex: oldIndex,
      newIndex: newIndex,
    );

    final updatedBlock = command.execute();

    emit(state.copyWith(block: updatedBlock, command: command));
  }

  FutureOr<void> clearBookmarks() {
    final updatedBlock = state.block.copyWith(items: []);

    emit(state.copyWith(block: updatedBlock));
  }

  Future<void> undo(NotebookCommand command) async {
    final updatedBlock = command.undo();

    emit(BookmarksBlockUndoRedoState.fromState(
        state.copyWith(block: updatedBlock)));
  }

  Future<void> redo(NotebookCommand command) async {
    final updatedBlock = command.execute();

    emit(BookmarksBlockUndoRedoState.fromState(
        state.copyWith(block: updatedBlock)));
  }

  @override
  Future<void> close() {
    notebookBlocSubscription?.cancel();
    return super.close();
  }
}
