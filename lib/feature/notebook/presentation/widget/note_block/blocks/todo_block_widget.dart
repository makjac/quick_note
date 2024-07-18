part of '../note_block_builder.dart';

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
              TodoList(items: state.block.items),
              const AddCheckOptionButton(),
            ],
          ),
        );
      },
    );
  }
}

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

class TodoList extends StatelessWidget {
  const TodoList({super.key, required this.items});

  final List<ChecklistItem> items;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemBuilder: (context, index) => CheckListItemWidget(
        key: ValueKey("${items[index].id}"),
        item: items[index],
        index: index,
      ),
      itemCount: items.length,
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        context.read<TodoBlockCubit>().changeCheckboxOrder(oldIndex, newIndex);
      },
      proxyDecorator: proxyDecorator,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      buildDefaultDragHandles: false,
    );
  }

  Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        final double animValue = Curves.easeInOut.transform(animation.value);
        final double scale = lerpDouble(1, 1.02, animValue)!;
        return Transform.scale(
          scale: scale,
          child: Card(
            color: Colors.white24,
            shadowColor: Colors.transparent,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class CheckListItemWidget extends StatefulWidget {
  const CheckListItemWidget(
      {super.key, required this.item, required this.index});

  final ChecklistItem item;
  final int index;

  @override
  State<CheckListItemWidget> createState() => _CheckListItemWidgetState();
}

class _CheckListItemWidgetState extends State<CheckListItemWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.item.title);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ReorderableDragStartListener(
          index: widget.index,
          child: const Icon(Icons.drag_indicator, color: Colors.white30),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            checkboxTheme: const CheckboxThemeData(
              side: BorderSide(
                color: Colors.white38,
                width: 2,
              ),
            ),
          ),
          child: Checkbox(
            value: widget.item.isChecked,
            onChanged: (_) =>
                context.read<TodoBlockCubit>().toggleCheckbox(widget.item.id),
            checkColor: Colors.black,
            activeColor: Colors.white,
          ),
        ),
        const SizedBox(width: Insets.xxs),
        Expanded(
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white30,
            decoration: InputDecoration(
              hintText: context.l10n.todo_block_item_hint_text,
              border: InputBorder.none,
            ),
            onChanged: (value) => context
                .read<TodoBlockCubit>()
                .changeCheckboxName(widget.item.id, value),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          color: Colors.white70,
          onPressed: () =>
              context.read<TodoBlockCubit>().removeCheckbox(widget.item.id),
        ),
      ],
    );
  }
}

class AddCheckOptionButton extends StatelessWidget {
  const AddCheckOptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.xxs),
      child: TextButton(
        onPressed: () => context.read<TodoBlockCubit>().addCheckbox(),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white60,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.s,
            vertical: Insets.xxs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.add),
              const SizedBox(width: Insets.xs),
              Text(
                context.l10n.todo_block_add_task,
                style: const TextStyle(letterSpacing: .8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
