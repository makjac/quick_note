part of '../../note_block_builder.dart';

class TodoBlockWidget extends StatelessWidget {
  const TodoBlockWidget({super.key, required this.block});

  final TodoBlock block;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBlockCubit(block: block),
      child: Builder(
        builder: (context) => NoteBlockWidget(
          block: const TodoBlockBody(),
          blockId: block.id,
          onMorePressed: () => showTodoBlockSettingsDialog(context, block),
        ),
      ),
    );
  }
}

class TodoBlockBody extends StatelessWidget {
  const TodoBlockBody({super.key});

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
            if (state.block.hasTitle) const TodoBlockTitle(),
            TodoBlockList(items: state.block.items),
            const TodoBlockAddTaskButton(),
          ],
        );
      },
    );
  }
}
