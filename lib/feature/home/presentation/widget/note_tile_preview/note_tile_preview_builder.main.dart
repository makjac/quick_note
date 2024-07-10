// ignore_for_file: type_literal_in_constant_pattern

part of 'note_tile_preview_builder.dart';

class NoteTilePreviewBuilder extends StatelessWidget {
  const NoteTilePreviewBuilder({super.key, this.noteBlock});

  final NoteBlock? noteBlock;

  @override
  Widget build(BuildContext context) {
    switch (noteBlock.runtimeType) {
      case TextBlock:
        return TextBlockPreview(content: noteBlock! as TextBlock);
      case TodoBlock:
        return TodoBlockPreview(content: noteBlock! as TodoBlock);
      default:
        return const SizedBox.shrink();
    }
  }
}
