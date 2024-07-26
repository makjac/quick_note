part of '../note_tile_preview_builder.dart';

class TodoBlockPreview extends StatelessWidget {
  const TodoBlockPreview({super.key, required this.content});

  final TodoBlock content;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TodoItemsPreview(items: content.items),
        _RemainingItemsCount(items: content.items),
      ],
    );
  }
}

class _TodoItemsPreview extends StatelessWidget {
  const _TodoItemsPreview({required this.items});

  final List<ChecklistItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .take(4)
          .map((item) => _CheckListItemPreview(item: item))
          .toList(),
    );
  }
}

class _RemainingItemsCount extends StatelessWidget {
  const _RemainingItemsCount({required this.items});

  final List<ChecklistItem> items;

  int countOfRemainingElements() => items.length - 4;

  @override
  Widget build(BuildContext context) {
    return items.length > 4
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: Insets.xxs),
            child: Text(
              "+ ${countOfRemainingElements()} items",
              style: TextStyle(color: Theme.of(context).noteTilecontentColor),
            ),
          )
        : const SizedBox.shrink();
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
        _checkBox(context, item.isChecked),
        const SizedBox(width: Insets.xs),
        Flexible(
          child: Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Theme.of(context).noteTilecontentColor),
          ),
        ),
      ],
    );
  }

  Widget _checkBox(BuildContext context, bool isChecked) => Icon(
        isChecked ? Icons.check_box : Icons.check_box_outline_blank,
        color: Theme.of(context).noteTilecontentColor,
        size: 20,
      );
}
