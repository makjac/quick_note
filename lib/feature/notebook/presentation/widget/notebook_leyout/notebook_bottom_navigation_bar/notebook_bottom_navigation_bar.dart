import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_color_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_redo_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_undo_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_add_note_block/notebook_mobile_add_note_block/notebook_add_note_block_modal_bottom_sheet.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_bottom_navigation_bar/notebook_more_note_option_button.dart';

class NotebookBottomNavigationBar extends StatelessWidget {
  const NotebookBottomNavigationBar({super.key, required this.noteColor});

  final Color noteColor;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BottomAppBar(
      color: noteColor,
      padding: const EdgeInsets.all(Insets.none),
      height: 60,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Insets.s),
        decoration: BoxDecoration(
          color: noteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildAddNoteBlockRow(width),
            ),
            _buildActionButtons(),
            _buildMoreOptionsButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddNoteBlockRow(double width) {
    return Row(
      children: [
        const NotebookAddNoteBlockModalBottomSheet(),
        if (width > 300) const SizedBox(width: Insets.xs),
        if (width > 300) const NotebookColorButton(),
      ],
    );
  }

  Widget _buildActionButtons() {
    return const Row(
      children: [
        NotebookUndoButton(),
        NotebookRedoButton(),
      ],
    );
  }

  Widget _buildMoreOptionsButton() {
    return const Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: NotebookMoreNoteOptionButton(),
      ),
    );
  }
}
