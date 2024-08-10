part of 'bookmarks_block_cubit.dart';

enum AddBookmarkStatus {
  none,
  loading,
  success,
  error,
}

class BookmarksBlockState extends Equatable {
  const BookmarksBlockState(
      {BookmarksBlock? block, AddBookmarkStatus? addingStatus})
      : block = block ?? const BookmarksBlock(id: -1),
        addingStatus = addingStatus ?? AddBookmarkStatus.none;

  final BookmarksBlock block;
  final AddBookmarkStatus addingStatus;

  BookmarksBlockState copyWith(
      {BookmarksBlock? block, AddBookmarkStatus? addingStatus}) {
    return BookmarksBlockState(
      block: block ?? this.block,
      addingStatus: addingStatus ?? this.addingStatus,
    );
  }

  @override
  List<Object> get props => [block, addingStatus];
}

final class BookmarksBlockInitial extends BookmarksBlockState {}
