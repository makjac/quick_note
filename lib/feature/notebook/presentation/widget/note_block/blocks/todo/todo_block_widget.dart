part of '../../note_block_builder.dart';

class TodoBlockWidget extends StatelessWidget {
  const TodoBlockWidget({super.key, required this.block});

  final TodoBlock block;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBlockCubit(
        notebookBloc: context.read<NotebookBloc>(),
block: block,
),
      child: Builder(
        builder: (context) => NoteBlockWidget(
          block: const _TodoBlockBody(),
          blockId: block.id,
          onMorePressed: () => showTodoBlockSettings(context),
        ),
      ),
    );
  }
}

class _TodoBlockBody extends StatelessWidget {
  const _TodoBlockBody();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBlockCubit, TodoBlockState>(
      listenWhen: (previous, current) => previous.block != current.block,
      listener: (context, state) {
        BlocProvider.of<NotebookBloc>(context)
            .add(NotebookUpdateNoteBlock(block: state.block));
      },
      builder: (context, state) {
        return Column(
          children: [
            _blockTitle(context, state),
            if (state.block.showProgressBar)
              TodoBlockProgressBar(items: state.block.items),
            TodoBlockList(items: state.block.items),
            const TodoBlockAddTaskButton(),
            if (state.block.showCompleteTasks)
              TodoBlockHiddenItemsList(items: state.block.items),
          ],
        );
      },
    );
  }

  Widget _blockTitle(BuildContext context, TodoBlockState state) {
    if (state.block.hasTitle) {
      return NoteBlockTitle(
        initValue: state.block.title,
        hintText: context.l10n.todo_block_title_hint_text,
        onChanged: (title) =>
            context.read<TodoBlockCubit>().changeBlockTitle(title),
      );
    } else {
      return const SizedBox(height: Insets.s);
    }
  }
}
