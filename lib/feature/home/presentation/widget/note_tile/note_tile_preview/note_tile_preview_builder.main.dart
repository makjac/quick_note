// ignore_for_file: type_literal_in_constant_pattern

part of 'note_tile_preview_builder.dart';

class NoteTilePreviewBuilder extends StatelessWidget {
  const NoteTilePreviewBuilder({super.key, this.noteBlock});

  final NoteBlock? noteBlock;

  @override
  Widget build(BuildContext context) {
    switch (noteBlock?.type) {
      case NoteBlockType.text:
        return TextBlockPreview(content: noteBlock! as TextBlock);
      case NoteBlockType.todo:
        return TodoBlockPreview(content: noteBlock! as TodoBlock);
      case NoteBlockType.bookmarks:
        return BookmarksBlockPreview(content: noteBlock! as BookmarksBlock);
      default:
        return const SizedBox.shrink();
    }
  }
}
