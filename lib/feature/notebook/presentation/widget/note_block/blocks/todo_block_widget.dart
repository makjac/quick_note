part of '../note_block_builder.dart';

class TodoBlockWidget extends StatelessWidget {
  const TodoBlockWidget({super.key, required this.content});

  final TodoBlock content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: content.items
          .map((item) => _CheckListItemWidget(item: item))
          .toList(),
    );
  }
}

class _CheckListItemWidget extends StatefulWidget {
  const _CheckListItemWidget({required this.item});

  final ChecklistItem item;

  @override
  State<_CheckListItemWidget> createState() => _CheckListItemWidgetState();
}

class _CheckListItemWidgetState extends State<_CheckListItemWidget> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.item.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.drag_indicator, color: Colors.black.withAlpha(140)),
        Checkbox(
          value: widget.item.isChecked,
          onChanged: (value) {},
        ),
        const SizedBox(width: Insets.xxs),
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          color: Colors.black.withAlpha(180),
          onPressed: () {},
        ),
      ],
    );
  }
}
