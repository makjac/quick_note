import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';

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
                  "Change color", Icons.color_lens_outlined),
              onTap: () async {
                final color =
                    await NoteHelper.showNoteColorPickerDialog(context);
                if (color != null) {
                  notebookBloc.add(
                    NotebookUpdateNote(
                      updates: NoteUpdates(colorHex: color.toHex()),
                    ),
                  );
                }
              },
            ),
            PopupMenuItem<_EditOption>(
              value: _EditOption.star,
              child: _buildPopupMenuItem("Star", Icons.star_border_outlined),
              onTap: () => notebookBloc.add(NotebookToggleStar()),
            ),
            PopupMenuItem<_EditOption>(
              value: _EditOption.archive,
              child: _buildPopupMenuItem("Archive", Icons.archive_outlined),
              onTap: () => notebookBloc.add(NotebookToggleArchive()),
            ),
            PopupMenuItem<_EditOption>(
              value: _EditOption.delete,
              child: _buildPopupMenuItem("Delete", Icons.delete_outline),
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