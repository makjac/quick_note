part of '../../note_block_builder.dart';

class TodoBlockTitle extends StatefulWidget {
  const TodoBlockTitle({super.key});

  @override
  State<TodoBlockTitle> createState() => _TodoBlockTitleState();
}

class _TodoBlockTitleState extends State<TodoBlockTitle> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<TodoBlockCubit>().state.block.title);
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
      cursorColor: Colors.white38,
      decoration: InputDecoration(
        hintText: context.l10n.todo_block_title_hint_text,
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: .7,
        fontSize: 17,
      ),
      onChanged: (title) =>
          context.read<TodoBlockCubit>().changeBlockTitle(title),
    );
  }
}
