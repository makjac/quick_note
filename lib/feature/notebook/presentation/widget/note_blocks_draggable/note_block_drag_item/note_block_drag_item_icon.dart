import 'package:flutter/material.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';

class NoteBlockDragItemIcon extends StatelessWidget {
  const NoteBlockDragItemIcon({super.key, required this.type});

  final NoteBlockType type;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case NoteBlockType.text:
        return const Icon(Icons.text_fields);
      case NoteBlockType.todo:
        return const Icon(Icons.check_box_outlined);
      default:
        return const Icon(Icons.text_fields);
    }
  }
}
