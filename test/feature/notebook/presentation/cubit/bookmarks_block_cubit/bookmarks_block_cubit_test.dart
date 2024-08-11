import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quick_note/core/error/failure/network_failure.dart';
import 'package:quick_note/feature/notebook/domain/usecase/fetch_best_favicon_url_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/bookmarks_block_cubit/bookmarks_block_cubit.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmark_view_mode.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';

class MockFetchBestFaviconUrlUsecase extends Mock
    implements FetchBestFaviconUrlUsecase {}

void main() {
  late MockFetchBestFaviconUrlUsecase mockFetchBestFaviconUrlUsecase;
  late BookmarksBlockCubit cubit;

  setUp(() {
    mockFetchBestFaviconUrlUsecase = MockFetchBestFaviconUrlUsecase();
    cubit = BookmarksBlockCubit(
        fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);
  });

  group('BookmarksBlockCubit', () {
    test('loadBlock updates the block in the state', () async {
      const block = BookmarksBlock(id: 1);
      await cubit.loadBlock(block);

      expect(cubit.state.block, block);
    });

    test('changeBlockTitleVisibility updates visibility of the title',
        () async {
      const block = BookmarksBlock(id: 1, hasTitle: false);
      cubit = BookmarksBlockCubit(
          block: block,
          fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);

      await cubit.changeBlockTitleVisibility(true);

      expect(cubit.state.block.hasTitle, true);
    });

    test('changeFaviconsVisibility updates visibility of favicons', () async {
      const block = BookmarksBlock(id: 1, visibleFavicons: false);
      cubit = BookmarksBlockCubit(
          block: block,
          fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);

      await cubit.changeFaviconsVisibility(true);

      expect(cubit.state.block.visibleFavicons, true);
    });

    test('changeBookmarksViewMode updates view mode', () async {
      const block = BookmarksBlock(id: 1, viewMode: BookmarkViewMode.list);
      cubit = BookmarksBlockCubit(
          block: block,
          fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);

      await cubit.changeBookmarksViewMode(BookmarkViewMode.grid);

      expect(cubit.state.block.viewMode, BookmarkViewMode.grid);
    });

    test('changeBlockTitle updates the title of the block', () async {
      const block = BookmarksBlock(id: 1, title: 'Old Title');
      cubit = BookmarksBlockCubit(
          block: block,
          fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);

      await cubit.changeBlockTitle('New Title');

      expect(cubit.state.block.title, 'New Title');
    });

    test('addBookmark updates state on success', () async {
      const url = 'https://example.com';
      const faviconUrl = 'https://example.com/favicon.ico';

      when(() => mockFetchBestFaviconUrlUsecase.call(url))
          .thenAnswer((_) async => const Right(faviconUrl));

      await cubit.addBookmark(url);

      expect(cubit.state.addingStatus, AddBookmarkStatus.success);
      expect(cubit.state.block.items.length, 1);
      expect(cubit.state.block.items.first.url, url);
      expect(cubit.state.block.items.first.faviconUrl, faviconUrl);
    });

    test('addBookmark updates state on failure', () async {
      const url = 'https://example.com';

      when(() => mockFetchBestFaviconUrlUsecase.call(url))
          .thenAnswer((_) async => const Left(NetworkFailure()));

      await cubit.addBookmark(url);

      expect(cubit.state.addingStatus, AddBookmarkStatus.error);
      expect(cubit.state.block.items.isEmpty, false);
    });

    test('removeBookmark updates state', () async {
      const block = BookmarksBlock(id: 1, items: [
        BookmarkItem(id: 1, title: 'Item 1', url: 'url1'),
        BookmarkItem(id: 2, title: 'Item 2', url: 'url2'),
      ]);
      cubit = BookmarksBlockCubit(
          block: block,
          fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);

      await cubit.removeBookmark(1);

      expect(cubit.state.block.items.length, 1);
      expect(cubit.state.block.items.first.id, 2);
    });

    test('updateBookmark updates state', () async {
      const block = BookmarksBlock(id: 1, items: [
        BookmarkItem(id: 1, title: 'Old Title', url: 'url1'),
      ]);
      cubit = BookmarksBlockCubit(
          block: block,
          fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);

      const updatedItem = BookmarkItem(id: 1, title: 'New Title', url: 'url1');
      await cubit.updateBookmark(updatedItem);

      expect(cubit.state.block.items.first.title, 'New Title');
    });

    test('reorderBookmarks updates state', () async {
      const block = BookmarksBlock(id: 1, items: [
        BookmarkItem(id: 1, title: 'Item 1', url: 'url1'),
        BookmarkItem(id: 2, title: 'Item 2', url: 'url2'),
      ]);
      cubit = BookmarksBlockCubit(
          block: block,
          fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);

      await cubit.reorderBookmarks(0, 1);

      expect(cubit.state.block.items[0].id, 2);
      expect(cubit.state.block.items[1].id, 1);
    });

    test('clearBookmarks updates state', () async {
      const block = BookmarksBlock(id: 1, items: [
        BookmarkItem(id: 1, title: 'Item 1', url: 'url1'),
      ]);
      cubit = BookmarksBlockCubit(
          block: block,
          fetchBestFaviconUrlUsecase: mockFetchBestFaviconUrlUsecase);

      await cubit.clearBookmarks();

      expect(cubit.state.block.items.isEmpty, true);
    });
  });
}
