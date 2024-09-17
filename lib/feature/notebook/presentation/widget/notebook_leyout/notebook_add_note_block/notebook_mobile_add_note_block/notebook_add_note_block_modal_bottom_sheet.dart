import 'package:flutter/material.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_add_note_block/notebook_mobile_add_note_block/show_add_note_block_bottom_sheet.dart';

class NotebookAddNoteBlockModalBottomSheet extends StatelessWidget {
  const NotebookAddNoteBlockModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => ShowAddNoteBlockBottomSheet.show(context),
      icon: const Icon(Icons.add_box_outlined),
    );
  }
}
