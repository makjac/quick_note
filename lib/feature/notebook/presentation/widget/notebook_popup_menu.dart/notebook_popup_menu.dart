import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';

enum _EditOption { color, star, archive, delete }

class NotebookPopupMenu extends StatelessWidget {
  const NotebookPopupMenu(this.context, {super.key});

  final BuildContext context;

  @override
  Widget build(context) {
    final notebookBloc = BlocProvider.of<NotebookBloc>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.s),
      child: PopupMenuButton<_EditOption>(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (context) {
          return [
            PopupMenuItem<_EditOption>(
              value: _EditOption.color,
              child: _buildPopupMenuItem(
                  context.l10n.note_settings_color, Icons.color_lens_outlined),
              onTap: () async {
                final color =
                    await NoteHelper.showNoteColorPickerDialog(context);
                if (color != null) {
                  notebookBloc.add(
                    NotebookUpdateNote(
                      updates: NoteUpdates(color: color),
                    ),
                  );
                }
              },
            ),
            PopupMenuItem<_EditOption>(
              value: _EditOption.star,
              child: _buildPopupMenuItem(
                  context.l10n.note_settings_star, Icons.star_border_outlined),
              onTap: () => notebookBloc.add(NotebookToggleStar()),
            ),
            PopupMenuItem<_EditOption>(
              value: _EditOption.archive,
              child: _buildPopupMenuItem(
                  context.l10n.note_settings_archive, Icons.archive_outlined),
              onTap: () => notebookBloc.add(NotebookToggleArchive()),
            ),
            PopupMenuItem<_EditOption>(
              value: _EditOption.delete,
              child: _buildPopupMenuItem(
                  context.l10n.note_settings_delete, Icons.delete_outline),
              onTap: () {
                notebookBloc.add(NotebookDeleteNote());
              },
            ),
          ];
        },
      ),
    );
  }

  Widget _buildPopupMenuItem(String title, IconData iconData) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: Insets.xs),
        Text(title),
      ],
    );
  }
}
