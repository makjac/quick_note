import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NotebookUndoButton extends StatelessWidget {
  const NotebookUndoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<NotebookBloc>(context).add(NotebookUndo());
      },
      icon: Tooltip(
        message: context.l10n.note_settings_undo,
        child: Icon(
          Icons.undo,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}
