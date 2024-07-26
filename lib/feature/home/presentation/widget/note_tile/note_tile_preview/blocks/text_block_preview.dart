part of '../note_tile_preview_builder.dart';

class TextBlockPreview extends StatelessWidget {
  const TextBlockPreview({super.key, required this.content});

  final TextBlock content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content.text,
      maxLines: 8,
      style: TextStyle(color: Theme.of(context).noteTilecontentColor),
    );
  }
}
