import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class AddNoteBlockButton extends StatefulWidget {
  const AddNoteBlockButton({super.key});

  @override
  State<AddNoteBlockButton> createState() => _AddNoteBlockButtonState();
}

class _AddNoteBlockButtonState extends State<AddNoteBlockButton> {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      key: _key,
      onPressed: () => _showContextMenu(context),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Theme.of(context).addBlockButtonBorderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.add),
          const SizedBox(width: Insets.xs),
          Text(context.l10n.add_note_block),
        ],
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    final PopupMenu menu = PopupMenu(
      context: context,
      config: const MenuConfig(maxColumn: 3),
      items: [
        MenuItem(
          title: context.l10n.text,
          image: const Icon(Icons.text_fields, color: Colors.white),
          userInfo: NoteBlockType.text,
        ),
        MenuItem(
          title: context.l10n.todo,
          image: const Icon(Icons.check_box_outlined, color: Colors.white),
          userInfo: NoteBlockType.todo,
        ),
        MenuItem(
          title: context.l10n.bookmarks,
          image: const Icon(Icons.link, color: Colors.white),
          userInfo: NoteBlockType.bookmarks,
        ),
      ],
      onClickMenu: (item) {
        if (item.menuUserInfo == null) return;
        BlocProvider.of<NotebookBloc>(context)
            .add(NotebookAddNoteBlock(type: item.menuUserInfo));
      },
    );

    menu.show(widgetKey: _key);
  }
}
