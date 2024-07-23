import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';

class NoteBlockSettings extends StatefulWidget {
  const NoteBlockSettings({
    super.key,
    required this.blockId,
    this.onMorePressed,
  });

  final num blockId;
  final void Function()? onMorePressed;

  @override
  State<NoteBlockSettings> createState() => _NoteBlockSettingsState();
}

class _NoteBlockSettingsState extends State<NoteBlockSettings> {
  bool isShowned = false;

  void setShowSettings(bool value) {
    setState(() {
      isShowned = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setShowSettings(true),
      onExit: (event) => setShowSettings(false),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200),
        curve: Curves.fastEaseInToSlowEaseOut,
        alignment: Alignment.topRight,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Insets.xs),
            ),
          ),
          padding: const EdgeInsets.only(
            top: Insets.xxs,
            bottom: Insets.xs,
            left: Insets.s,
            right: Insets.s,
          ),
          child: isShowned ? _settingsOptions() : _settingsIcon(),
        ),
      ),
    );
  }

  Widget _settingsIcon() {
    return Icon(
      Icons.settings,
      color: Colors.grey[800],
    );
  }

  Widget _settingsOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Tooltip(
          message: context.l10n.tooltip_move_note_block,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.drag_handle),
            padding: EdgeInsets.zero,
            color: Colors.grey[800],
          ),
        ),
        Tooltip(
          message: context.l10n.tooltip_delete_note_block,
          child: IconButton(
            onPressed: () => BlocProvider.of<NotebookBloc>(context)
                .add(NotebookDeleteBlock(blockId: widget.blockId)),
            icon: const Icon(Icons.delete),
            padding: EdgeInsets.zero,
            color: Colors.grey[800],
          ),
        ),
        Tooltip(
          message: context.l10n.tooltip_more,
          child: IconButton(
            onPressed: widget.onMorePressed,
            icon: const Icon(Icons.more_vert),
            padding: EdgeInsets.zero,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
}
