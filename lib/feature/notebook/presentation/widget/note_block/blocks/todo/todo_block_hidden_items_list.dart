part of '../../note_block_builder.dart';

class TodoBlockHiddenItemsList extends StatefulWidget {
  const TodoBlockHiddenItemsList({super.key, required this.items});

  final List<ChecklistItem> items;

  @override
  State<TodoBlockHiddenItemsList> createState() =>
      _TodoBlockHiddenItemsListState();
}

class _TodoBlockHiddenItemsListState extends State<TodoBlockHiddenItemsList>
    with SingleTickerProviderStateMixin {
  bool expanded = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<ChecklistItem> _filteredItems(BuildContext context) {
    final showCompletedItems =
        context.read<TodoBlockCubit>().state.block.showCompleteTasks;

    if (showCompletedItems) {
      return widget.items.where((item) => item.isChecked).toList();
    } else {
      return [];
    }
  }

  void toggleExpand() {
    setState(() {
      expanded = !expanded;
      if (expanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _filteredItems(context);

    if (tasks.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        const Divider(),
        _expandedHeader(),
        SizeTransition(
          sizeFactor: _heightFactor,
          child: _expandedBody(tasks),
        ),
      ],
    );
  }

  String _expandedHeaderTitle() {
    final completedTasks = _filteredItems(context).length;

    if (completedTasks == 1) return context.l10n.todo_block_complete_one_task;
    return context.l10n.todo_block_complete_tasks(completedTasks);
  }

  Widget _expandedHeader() {
    return InkWell(
      onTap: toggleExpand,
      child: Row(
        children: [
          const SizedBox(width: Insets.m + 4),
          AnimatedRotation(
            turns: expanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: const Icon(Icons.keyboard_arrow_up_outlined),
          ),
          Padding(
            padding: const EdgeInsets.all(Insets.xs),
            child: Text(
              _expandedHeaderTitle(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _expandedBody(List<ChecklistItem> tasks) {
    return ListView.builder(
      itemBuilder: (context, index) => TodoBlockCheckListItem(
        key: ValueKey("${tasks[index].id}_hidden"),
        cubit: context.read<TodoBlockCubit>(),
        item: tasks[index],
        draggable: false,
        index: index,
      ),
      itemCount: tasks.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
