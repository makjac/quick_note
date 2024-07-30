import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/l10n/l10n.dart';

enum _Menu { select, restore, deleteForever }

class NoteTileTrashPopupMenu extends StatelessWidget {
  const NoteTileTrashPopupMenu(this.context, {super.key, required this.note});

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
        _buildRestoreMenuItem(context),
        const PopupMenuDivider(),
        _buildDeleteForeverMenuItem(context),
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

  PopupMenuItem<_Menu> _buildRestoreMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.restore,
      onTap: () => appBloc.add(AppRestoreSingleNote(note: note)),
      child: ListTile(
        leading: const Icon(Icons.arrow_upward),
        title: Text(context.l10n.note_settings_restore),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildDeleteForeverMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    const redColor = Colors.red;
    return PopupMenuItem<_Menu>(
      value: _Menu.deleteForever,
      onTap: () => appBloc.add(AppDeleteSingleNote(id: note.id)),
      child: ListTile(
        iconColor: redColor,
        textColor: redColor,
        leading: const Icon(Icons.delete_outline),
        title: Text(context.l10n.note_settings_delete_forever),
      ),
    );
  }
}
