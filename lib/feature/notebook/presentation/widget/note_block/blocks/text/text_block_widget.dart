part of '../../note_block_builder.dart';

class TextBlockWidget extends StatelessWidget {
  const TextBlockWidget({super.key, required this.block});

  final TextBlock block;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TextBlockCubit(block: block),
      child: Builder(
        builder: (context) => NoteBlockWidget(
          block: const _TextBlockBody(),
          blockId: block.id,
          onMorePressed: () => showTextBlockSettings(context),
        ),
      ),
    );
  }
}

class _TextBlockBody extends StatelessWidget {
  const _TextBlockBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TextBlockCubit, TextBlockState>(
      listenWhen: (previous, current) => previous.block != current.block,
      listener: (context, state) {
        BlocProvider.of<NotebookBloc>(context)
            .add(NotebookUpdateNoteBlock(block: state.block));
      },
      builder: (context, state) {
        return Column(
          children: [
            _blockTitle(context, state),
            const SizedBox(height: Insets.xxs),
            TextBlockContent(block: state.block),
          ],
        );
      },
    );
  }

  Widget _blockTitle(BuildContext context, TextBlockState state) {
    if (state.block.hasTitle) {
      return NoteBlockTitle(
        initValue: state.block.title,
        hintText: context.l10n.text_block_title_hint_text,
        onChanged: (title) =>
            context.read<TextBlockCubit>().changeBlockTitle(title),
      );
    } else {
      return const SizedBox(height: Insets.s);
    }
  }
}
