import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_redo_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_undo_button.dart';
import 'package:quick_note/l10n/l10n.dart';

enum _EditOption { color, star, archive, delete }

class NotebookPopupMenu extends StatelessWidget {
  const NotebookPopupMenu(this.context, {super.key});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    final notebookBloc = BlocProvider.of<NotebookBloc>(context);
    final note = notebookBloc.state.note;
    final isStarred = note?.isStarred ?? false;
    final isArchived = note?.archived ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.s),
      child: Row(
        children: [
          if (_shouldShowUndoRedoButtons(context))
            const Row(
              children: [
                NotebookUndoButton(),
                NotebookRedoButton(),
                SizedBox(width: Insets.s),
              ],
            ),
          _buildPopupMenu(context, notebookBloc, isStarred, isArchived),
        ],
      ),
    );
  }

  bool _shouldShowUndoRedoButtons(BuildContext context) {
    return MediaQuery.of(context).size.width > 210;
  }

  Widget _buildPopupMenu(BuildContext context, NotebookBloc notebookBloc,
      bool isStarred, bool isArchived) {
    return PopupMenuButton<_EditOption>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          _buildPopupMenuItem(
            context.l10n.note_settings_color,
            Icons.color_lens_outlined,
            _EditOption.color,
            () async {
              final color = await NoteHelper.showNoteColorPickerDialog(context);
              if (color != null) {
                notebookBloc.add(NotebookChangeColor(color: color));
              }
            },
          ),
          _buildPopupMenuItem(
            context.l10n.note_settings_star,
            isStarred ? Icons.star : Icons.star_border_outlined,
            _EditOption.star,
            () => notebookBloc.add(NotebookToggleStar()),
          ),
          _buildPopupMenuItem(
            context.l10n.note_settings_archive,
            isArchived ? Icons.archive : Icons.archive_outlined,
            _EditOption.archive,
            () => notebookBloc.add(NotebookToggleArchive()),
          ),
          _buildPopupMenuItem(
            context.l10n.note_settings_delete,
            Icons.delete_outline,
            _EditOption.delete,
            () {
              notebookBloc.add(NotebookMoveToTrash());
              context.pop();
            },
          ),
        ];
      },
    );
  }

  PopupMenuItem<_EditOption> _buildPopupMenuItem(
    String title,
    IconData iconData,
    _EditOption value,
    VoidCallback onTap,
  ) {
    return PopupMenuItem<_EditOption>(
      value: value,
      onTap: onTap,
      child: Row(
        children: [
          Icon(iconData),
          const SizedBox(width: Insets.xs),
          Text(title),
        ],
      ),
    );
  }
}
