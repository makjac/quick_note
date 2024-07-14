part of '../note_block_builder.dart';

class TextBlockWidget extends StatefulWidget {
  const TextBlockWidget({super.key, required this.content});

  final TextBlock content;

  @override
  State<TextBlockWidget> createState() => _TextBlockWidgetState();
}

class _TextBlockWidgetState extends State<TextBlockWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.content.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
    );
  }
}
