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

class _CheckListItemWidget extends StatelessWidget {
  const _CheckListItemWidget({required this.item});

  final ChecklistItem item;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      value: item.isChecked,
      onChanged: (value) {},
      title: Text(item.title),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
