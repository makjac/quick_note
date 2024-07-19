part of '../../note_block_builder.dart';

class TodoBlockList extends StatelessWidget {
  const TodoBlockList({super.key, required this.items});

  final List<ChecklistItem> items;

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemBuilder: (context, index) => TodoBlockCheckListItem(
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
