part of '../note_block_builder.dart';

class TextBlockWidget extends StatelessWidget {
  const TextBlockWidget({super.key, required this.content});

  final TextBlock content;

  @override
  Widget build(BuildContext context) {
    return Text(content.text);
  }
}
