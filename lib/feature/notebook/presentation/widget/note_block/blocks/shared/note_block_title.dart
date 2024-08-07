part of '../../note_block_builder.dart';

class NoteBlockTitle extends StatefulWidget {
  const NoteBlockTitle({super.key, this.initValue, this.onChanged});

  final String? initValue;
  final void Function(String title)? onChanged;

  @override
  State<NoteBlockTitle> createState() => _NoteBlockTitleState();
}

class _NoteBlockTitleState extends State<NoteBlockTitle> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.initValue);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      maxLines: null,
      decoration: InputDecoration(
        hintText: context.l10n.todo_block_title_hint_text,
        border: InputBorder.none,
      ),
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        letterSpacing: .7,
        fontSize: 17,
      ),
      onChanged: widget.onChanged,
    );
  }
}
