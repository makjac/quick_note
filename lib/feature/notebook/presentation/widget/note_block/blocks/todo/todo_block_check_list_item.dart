part of '../../note_block_builder.dart';

class TodoBlockCheckListItem extends StatefulWidget {
  const TodoBlockCheckListItem({
    super.key,
    required this.item,
    required this.index,
    this.draggable = true,
    required this.cubit,
  });

  final ChecklistItem item;
  final int index;
  final bool draggable;
  final TodoBlockCubit cubit;

  @override
  State<TodoBlockCheckListItem> createState() => _TodoBlockCheckListItem();
}

class _TodoBlockCheckListItem extends State<TodoBlockCheckListItem> {
  bool _isHovered = false;

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

  void _handleMouseEnter() {
    setState(() => _isHovered = true);
  }

  void _handleMouseExit() {
    setState(() => _isHovered = false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _handleMouseEnter(),
      onExit: (_) => _handleMouseExit(),
      child: _buildContainer(context),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Container(
      decoration: _buildContainerDecoration(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _buildRowChildren(context),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration(BuildContext context) {
    return BoxDecoration(
      color: _isHovered ? Theme.of(context).hoverColor : Colors.transparent,
      borderRadius: BorderRadius.circular(Insets.xs),
    );
  }

  List<Widget> _buildRowChildren(BuildContext context) {
    return [
      if (widget.draggable) _buildDragHandle(),
      if (!widget.draggable) const SizedBox(width: Insets.m),
      _buildCheckbox(context),
      const SizedBox(width: Insets.xxs),
      _buildTextField(context),
      _buildDeleteButton(context),
    ];
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
      child: BlocListener<TodoBlockCubit, TodoBlockState>(
        bloc: widget.cubit,
        listener: (context, state) {
          if (state.block.items
              .any((element) => element.id == widget.item.id)) {
            final item = state.block.items.firstWhere(
              (element) => element.id == widget.item.id,
            );
            _controller.text = item.title;
          }
        },
        listenWhen: (previous, current) {
          return current is TodoBlockUndoRedoState;
        },
        child: DebounceTextField(
          controller: _controller,
          focusNode: _focusNode,
          style: TextStyle(
            color: widget.item.isChecked
                ? Theme.of(context).todoCheckedTextColor
                : null,
            decoration:
                widget.item.isChecked ? TextDecoration.lineThrough : null,
            decorationColor: Theme.of(context).todoCheckedTextColor,
          ),
          maxLines: null,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: Insets.xxs),
            hintText: context.l10n.todo_block_item_hint_text,
            border: InputBorder.none,
          ),
          onDebounceChange: (value) => context
              .read<TodoBlockCubit>()
              .changeCheckboxName(widget.item.id, value),
        ),
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
