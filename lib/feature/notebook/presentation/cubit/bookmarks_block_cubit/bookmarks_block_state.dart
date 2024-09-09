part of 'bookmarks_block_cubit.dart';

enum AddBookmarkStatus {
  none,
  loading,
  success,
  error,
}

class BookmarksBlockState extends Equatable {
  const BookmarksBlockState(
      {BookmarksBlock? block, AddBookmarkStatus? addingStatus, this.command})
      : block = block ?? const BookmarksBlock(id: -1),
        addingStatus = addingStatus ?? AddBookmarkStatus.none;

  final BookmarksBlock block;
  final AddBookmarkStatus addingStatus;
  final NotebookCommand? command;

  BookmarksBlockState copyWith(
      {BookmarksBlock? block,
      AddBookmarkStatus? addingStatus,
      NotebookCommand? command}) {
    return BookmarksBlockState(
      block: block ?? this.block,
      addingStatus: addingStatus ?? this.addingStatus,
      command: command,
    );
  }

  @override
  List<Object> get props => [block, addingStatus];
}

final class BookmarksBlockInitial extends BookmarksBlockState {}
