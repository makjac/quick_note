import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/l10n/l10n.dart';

enum _Menu { select, color, star, delete }

class NoteTilePopupMenu extends StatelessWidget {
  const NoteTilePopupMenu(this.context, {super.key, required this.note});

  final Note note;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_Menu>(
      popUpAnimationStyle: AnimationStyle.noAnimation,
      iconSize: 20,
      splashRadius: 20,
      itemBuilder: (_) => <PopupMenuEntry<_Menu>>[
        _buildSelectMenuItem(context),
        _buildColorMenuItem(context),
        _buildStarMenuItem(context),
        _buildArchiveMenuItem(context),
        const PopupMenuDivider(),
        _buildDeleteMenuItem(context),
      ],
      child: const Icon(
        Icons.more_vert_sharp,
        size: 20,
      ),
    );
  }

  PopupMenuItem<_Menu> _buildSelectMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.select,
      onTap: () => appBloc.add(AppSelectNote(noteId: note.id)),
      child: ListTile(
        leading: const Icon(Icons.check_box_outlined),
        title: Text(context.l10n.note_settings_select),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildColorMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.color,
      onTap: () async {
        final color = await NoteHelper.showNoteColorPickerDialog(context);
        if (color != null) {
          appBloc.add(AppUpdateSingleNote(
            note: note,
            updates: NoteUpdates(color: color),
          ));
        }
      },
      child: ListTile(
        leading: const Icon(
          Icons.color_lens_outlined,
        ),
        title: Text(context.l10n.note_settings_color),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildStarMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.star,
      onTap: () => appBloc.add(AppUpdateSingleNote(
        note: note,
        updates: NoteUpdates(isStarred: !note.isStarred),
      )),
      child: ListTile(
        leading: const Icon(Icons.star_border),
        title: Text(context.l10n.note_settings_star),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildArchiveMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.star,
      onTap: () => appBloc.add(AppUpdateSingleNote(
        note: note,
        updates: NoteUpdates(archived: !note.archived, isStarred: false),
      )),
      child: ListTile(
        leading: const Icon(Icons.archive_outlined),
        title: Text(context.l10n.note_settings_archive),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildDeleteMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    const redColor = Colors.red;
    return PopupMenuItem<_Menu>(
      value: _Menu.delete,
      onTap: () => appBloc.add(AppMoveToTrashSingleNote(note: note)),
      child: ListTile(
        iconColor: redColor,
        textColor: redColor,
        leading: const Icon(Icons.delete_outline),
        title: Text(context.l10n.note_settings_delete),
      ),
    );
  }
}
