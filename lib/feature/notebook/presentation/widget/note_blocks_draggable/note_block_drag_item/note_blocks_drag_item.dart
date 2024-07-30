import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_blocks_draggable/note_block_drag_item/note_block_drag_item_icon.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NoteBlocksDragItem extends StatelessWidget {
  const NoteBlocksDragItem({
    super.key,
    required this.index,
    required this.blockTitle,
    required this.type,
  });

  final String blockTitle;
  final NoteBlockType type;
  final int index;

  @override
  Widget build(BuildContext context) {
    return _buildDragHandle(
      context,
      child: Container(
        padding: const EdgeInsets.all(Insets.xs),
        margin: const EdgeInsets.all(Insets.xs),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white24),
          borderRadius: BorderRadius.circular(Insets.xs),
        ),
        child: Row(
          children: [
            NoteBlockDragItemIcon(
              type: type,
            ),
            const SizedBox(width: Insets.s),
            Text(blockTitle),
            const Spacer(),
            Icon(
              Icons.drag_indicator,
              color: Theme.of(context).todoTaskDragIconColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context, {required Widget child}) {
    return ReorderableDragStartListener(
      index: index,
      child: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: child,
      ),
    );
  }
}
