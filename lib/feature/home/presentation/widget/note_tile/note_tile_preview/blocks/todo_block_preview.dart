part of '../note_tile_preview_builder.dart';

class TodoBlockPreview extends StatelessWidget {
  const TodoBlockPreview({super.key, required this.content});

  final TodoBlock content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: content.items
          .map((item) => _CheckListItemPreview(item: item))
          .toList(),
    );
  }
}

class _CheckListItemPreview extends StatelessWidget {
  const _CheckListItemPreview({required this.item});

  final ChecklistItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _checkBox(item.isChecked),
        const SizedBox(width: Insets.xxs),
        Flexible(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _checkBox(bool isChecked) => Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: Colors.black.withAlpha(200),
        size: 20,
      );
}
