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

class _TodoBlockBody extends StatefulWidget {
  const _TodoBlockBody();

  @override
  State<_TodoBlockBody> createState() => _TodoBlockBodyState();
}

class _TodoBlockBodyState extends State<_TodoBlockBody> {
  late TextEditingController _titleController;

  @override
  void initState() {
    _titleController = TextEditingController()
      ..text = BlocProvider.of<TodoBlockCubit>(context).state.block.title;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBlockCubit, TodoBlockState>(
      listenWhen: (previous, current) => previous.block != current.block,
      listener: (context, state) {
        BlocProvider.of<NotebookBloc>(context)            .add(
NotebookUpdateNoteBlock(
block: state.block,
            command: state.command,
          ),
);
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
