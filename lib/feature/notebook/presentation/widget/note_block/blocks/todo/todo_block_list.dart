part of '../../note_block_builder.dart';

class TodoBlockList extends StatelessWidget {
  const TodoBlockList({super.key, required this.items});

  final List<ChecklistItem> items;

  List<ChecklistItem> _filteredItems(BuildContext context) {
    final showCompletedItems =
        context.read<TodoBlockCubit>().state.block.showCompleteTasks;

    if (showCompletedItems) {
      return items.where((item) => !item.isChecked).toList();
    } else {
      return items;
    }
  }

  int getTaskIndex(ChecklistItem task) {
    return items.indexOf(task);
  }

  @override
  Widget build(BuildContext context) {
    final tasks = _filteredItems(context);
    return ReorderableListView.builder(
      itemBuilder: (context, index) => TodoBlockCheckListItem(
        key: ValueKey("${tasks[index].id}"),
        cubit: context.read<TodoBlockCubit>(),
        item: tasks[index],
        index: index,
      ),
      itemCount: tasks.length,
      onReorder: (oldIndex, newIndex) {
        if (oldIndex < newIndex) {
          newIndex -= 1;
        }
        context.read<TodoBlockCubit>().changeCheckboxOrder(
              getTaskIndex(tasks[oldIndex]),
              getTaskIndex(
                tasks[newIndex],
              ),
            );
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
