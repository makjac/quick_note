part of '../../note_block_builder.dart';

class TodoBlockCheckListItem extends StatefulWidget {
  const TodoBlockCheckListItem({
    super.key,
    required this.item,
    required this.index,
    this.draggable = true,
  });

  final ChecklistItem item;
  final int index;
  final bool draggable;

  @override
  State<TodoBlockCheckListItem> createState() => _TodoBlockCheckListItem();
}

class _TodoBlockCheckListItem extends State<TodoBlockCheckListItem> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.item.title);
    _focusNode = FocusNode();

    final todoState = context.read<TodoBlockCubit>().state;

    if (todoState is TodoBlockAddedNewTaskItem) {
      if (todoState.item.id == widget.item.id) {
        _focusNode.requestFocus();
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.draggable) _buildDragHandle(),
        if (!widget.draggable) const SizedBox(width: Insets.m),
        _buildCheckbox(context),
        const SizedBox(width: Insets.xxs),
        _buildTextField(context),
        _buildDeleteButton(context),
      ],
    );
  }

  Widget _buildDragHandle() {
    return ReorderableDragStartListener(
      index: widget.index,
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Icon(
          Icons.drag_indicator,
          color: Theme.of(context).todoTaskDragIconColor,
        ),
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Insets.xxs),
      child: Checkbox(
        value: widget.item.isChecked,
        onChanged: (_) =>
            context.read<TodoBlockCubit>().toggleCheckbox(widget.item.id),
        activeColor: Colors.white,
      ),
    );
  }

  Widget _buildTextField(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        style: TextStyle(
          color: widget.item.isChecked
              ? Theme.of(context).todoCheckedTextColor
              : null,
          decoration: widget.item.isChecked ? TextDecoration.lineThrough : null,
          decorationColor: Theme.of(context).todoCheckedTextColor,
        ),
        maxLines: null,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: Insets.xxs),
          hintText: context.l10n.todo_block_item_hint_text,
          border: InputBorder.none,
        ),
        onChanged: (value) => context
            .read<TodoBlockCubit>()
            .changeCheckboxName(widget.item.id, value),
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.close),
      color: Theme.of(context).todoTaskDeleteIconColor,
      onPressed: () =>
          context.read<TodoBlockCubit>().removeCheckbox(widget.item.id),
    );
  }
}
