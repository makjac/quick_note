import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NotebookDesktopIconsMenu extends StatelessWidget {
  const NotebookDesktopIconsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final notebookBloc = BlocProvider.of<NotebookBloc>(context);
    return BlocBuilder<NotebookBloc, NotebookState>(
      builder: (context, state) {
        final isNotArchived = !(state.note?.archived ?? false);

        return Row(
          children: [
            _ColorPickerButton(notebookBloc: notebookBloc),
            const SizedBox(width: Insets.xxs),
            if (isNotArchived)
              Padding(
                padding: const EdgeInsets.only(right: Insets.xxs),
                child: _StarButton(notebookBloc: notebookBloc),
              ),
            _ArchivedButton(notebookBloc: notebookBloc),
            const SizedBox(width: Insets.xxs),
            _DeleteButton(notebookBloc: notebookBloc),
            const SizedBox(width: Insets.s),
          ],
        );
      },
    );
  }
}

class _ColorPickerButton extends StatelessWidget {
  const _ColorPickerButton({required this.notebookBloc});

  final NotebookBloc notebookBloc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final color = await NoteHelper.showNoteColorPickerDialog(context);
        if (color != null) {
          notebookBloc.add(
            NotebookUpdateNote(
              updates: NoteUpdates(color: color),
            ),
          );
        }
      },
      icon: Tooltip(
        message: context.l10n.note_settings_color,
        child: Icon(
          Icons.color_lens_outlined,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}

class _StarButton extends StatelessWidget {
  const _StarButton({required this.notebookBloc});

  final NotebookBloc notebookBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotebookBloc, NotebookState>(
      bloc: notebookBloc,
      builder: (context, state) {
        final isStarred = state.note?.isStarred ?? false;
        return IconButton(
          onPressed: () => notebookBloc.add(NotebookToggleStar()),
          icon: Tooltip(
            message: context.l10n.note_settings_star,
            child: Icon(
              isStarred ? Icons.star_outlined : Icons.star_border,
              color:
                  Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
            ),
          ),
        );
      },
    );
  }
}

class _ArchivedButton extends StatelessWidget {
  const _ArchivedButton({required this.notebookBloc});

  final NotebookBloc notebookBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotebookBloc, NotebookState>(
      bloc: notebookBloc,
      builder: (context, state) {
        final isArchived = state.note?.archived ?? false;
        return IconButton(
          onPressed: () => notebookBloc.add(NotebookToggleArchive()),
          icon: Tooltip(
            message: context.l10n.note_settings_archive,
            child: Icon(
              isArchived ? Icons.archive : Icons.archive_outlined,
              color:
                  Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
            ),
          ),
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({required this.notebookBloc});

  final NotebookBloc notebookBloc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        notebookBloc.add(NotebookMoveToTrash());
        context.pop();
      },
      icon: Tooltip(
        message: context.l10n.note_settings_delete,
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}
