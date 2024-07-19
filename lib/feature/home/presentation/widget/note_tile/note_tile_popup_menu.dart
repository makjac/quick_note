import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

enum _Menu { select, color, star, delete }

class NoteTilePopupMenu extends StatelessWidget {
  const NoteTilePopupMenu(
      {super.key, required this.note, required this.context});

  final Note note;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_Menu>(
      color: Colors.grey[850],
      popUpAnimationStyle: AnimationStyle.noAnimation,
      iconSize: 20,
      splashRadius: 20,
      itemBuilder: (_) => <PopupMenuEntry<_Menu>>[
        _buildSelectMenuItem(this.context),
        _buildColorMenuItem(this.context),
        _buildStarMenuItem(this.context),
        _buildArchiveMenuItem(this.context),
        const PopupMenuDivider(),
        _buildDeleteMenuItem(this.context),
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
      child: const ListTile(
        iconColor: Colors.white70,
        textColor: Colors.white70,
        leading: Icon(Icons.check_box_outlined),
        title: Text('Select'),
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
            updates: NoteUpdates(colorHex: color.toHex()),
          ));
        }
      },
      child: const ListTile(
        iconColor: Colors.white70,
        textColor: Colors.white70,
        leading: Icon(
          Icons.color_lens_outlined,
        ),
        title: Text('Change Color'),
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
      child: const ListTile(
        iconColor: Colors.white70,
        textColor: Colors.white70,
        leading: Icon(Icons.star_border),
        title: Text('Star'),
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
      child: const ListTile(
        iconColor: Colors.white70,
        textColor: Colors.white70,
        leading: Icon(Icons.archive_outlined),
        title: Text('Archive'),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildDeleteMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final redColor = Colors.red.withAlpha(200);
    return PopupMenuItem<_Menu>(
      value: _Menu.delete,
      onTap: () => appBloc.add(AppDeleteSingleNote(id: note.id)),
      child: ListTile(
        iconColor: redColor,
        textColor: redColor,
        leading: const Icon(Icons.delete_outline),
        title: const Text('delete'),
      ),
    );
  }
}
