import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';

class NotebookMoreNoteOptionButton extends StatelessWidget {
  const NotebookMoreNoteOptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showAddNoteBlockModalBottomSheet(context),
      icon: const Icon(Icons.more_vert),
    );
  }

  void _showAddNoteBlockModalBottomSheet(BuildContext context) {
    if (!context.mounted) return;

    final notebookBloc = BlocProvider.of<NotebookBloc>(context);
    final width = MediaQuery.of(context).size.width;

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocBuilder<NotebookBloc, NotebookState>(
          bloc: notebookBloc,
          builder: (context, state) {
            final isStarred = notebookBloc.state.note?.isStarred ?? false;
            final isArchived = notebookBloc.state.note?.archived ?? false;
            return Padding(
              padding: const EdgeInsets.all(Insets.s),
              child: Wrap(
                children: [
                  if (width < 300)
                    ListTile(
                      leading: const Icon(Icons.color_lens_outlined),
                      title: Text(context.l10n.note_settings_color),
                      onTap: () async {
                        final color =
                            await NoteHelper.showNoteColorPickerDialog(context);
                        if (color != null) {
                          if (!context.mounted) return;
                          notebookBloc.add(
                            NotebookChangeColor(color: color),
                          );
                        }
                        if (!context.mounted) return;
                        Navigator.pop(context);
                      },
                    ),
                  ListTile(
                    leading: Icon(
                        isStarred ? Icons.star_outlined : Icons.star_border),
                    title: Text(
                      isStarred
                          ? context.l10n.note_settings_unstar
                          : context.l10n.note_settings_star,
                    ),
                    onTap: () {
                      notebookBloc.add(NotebookToggleStar());
                    },
                  ),
                  ListTile(
                    leading: Icon(
                        isArchived ? Icons.archive : Icons.archive_outlined),
                    title: Text(
                      isArchived
                          ? context.l10n.note_settings_unarchived
                          : context.l10n.note_settings_archive,
                    ),
                    onTap: () {
                      notebookBloc.add(NotebookToggleArchive());
                    },
                  ),
                  ListTile(
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    leading: const Icon(Icons.delete),
                    title: Text(context.l10n.note_settings_delete),
                    onTap: () {
                      notebookBloc.add(NotebookMoveToTrash());
                      Navigator.pop(context);
                      context.pop();
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
