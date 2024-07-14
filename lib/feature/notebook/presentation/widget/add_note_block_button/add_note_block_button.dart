import 'package:flutter/material.dart';
import 'package:popup_menu/popup_menu.dart';
import 'package:quick_note/core/constans/insets.dart';

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
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add),
          SizedBox(width: Insets.xs),
          Text("Add note block"),
        ],
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    PopupMenu menu = PopupMenu(
      context: context,
      config: const MenuConfig(maxColumn: 3),
      items: [
        MenuItem(
          title: 'Text',
          image: const Icon(Icons.text_fields, color: Colors.white),
        ),
        MenuItem(
          title: 'Todo',
          image: const Icon(Icons.check_box_outlined, color: Colors.white),
        ),
        MenuItem(
          title: 'other',
          image: const Icon(Icons.more_horiz, color: Colors.white),
        ),
      ],
    );

    menu.show(widgetKey: _key);
  }
}
