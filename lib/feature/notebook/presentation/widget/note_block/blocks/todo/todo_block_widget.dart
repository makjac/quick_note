part of '../../note_block_builder.dart';

class TodoBlockWidget extends StatelessWidget {
  const TodoBlockWidget({super.key, required this.content});

  final TodoBlock content;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBlockCubit(block: content),
      child: const TodoBlockBody(),
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
              const TodoBlockTitle(),
              TodoBlockList(items: state.block.items),
              const TodoBlockAddTaskButton(),
            ],
          ),
        );
      },
    );
  }
}
