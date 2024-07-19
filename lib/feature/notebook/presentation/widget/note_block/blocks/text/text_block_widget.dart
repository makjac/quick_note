part of '../../note_block_builder.dart';

class TextBlockWidget extends StatelessWidget {
  const TextBlockWidget({super.key, required this.content});

  final TextBlock content;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextBlockCubit(block: content),
      child: const _TextBlockBody(),
    );
  }
}

class _TextBlockBody extends StatefulWidget {
  const _TextBlockBody();

  @override
  State<_TextBlockBody> createState() => _TextBlockBodyState();
}

class _TextBlockBodyState extends State<_TextBlockBody> {
  late TextEditingController _controller;
  late TextEditingController _titleController;

  @override
  void initState() {
    _controller = TextEditingController(
        text: context.read<TextBlockCubit>().state.block.text);
    _titleController = TextEditingController(
        text: context.read<TextBlockCubit>().state.block.title);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextBlockCubit, TextBlockState>(
      listenWhen: (previous, current) => previous.block != current.block,
      listener: (context, state) {
        BlocProvider.of<NotebookBloc>(context)
            .add(NotebookUpdateNoteBlock(block: state.block));
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(Insets.s),
          margin: const EdgeInsets.symmetric(vertical: Insets.xs),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.white10),
              bottom: BorderSide(color: Colors.white10),
            ),
          ),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLines: null,
                cursorColor: Colors.white38,
                decoration: InputDecoration(
                  hintText: context.l10n.text_block_title_hint_text,
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .7,
                  fontSize: 17,
                ),
                onChanged: (title) =>
                    context.read<TextBlockCubit>().changeBlockTitle(title),
              ),
              const SizedBox(height: Insets.xxs),
              TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                cursorColor: Colors.white38,
                decoration: InputDecoration(
                  hintText: context.l10n.text_block_note_hint_text,
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white60),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: .6,
                ),
                onChanged: (value) =>
                    context.read<TextBlockCubit>().changeNoteText(value),
              ),
            ],
          ),
        );
      },
    );
  }
}
