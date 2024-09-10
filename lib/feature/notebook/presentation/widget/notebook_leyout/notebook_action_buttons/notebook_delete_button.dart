import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NotebookDeleteButton extends StatelessWidget {
  const NotebookDeleteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        BlocProvider.of<NotebookBloc>(context).add(NotebookMoveToTrash());
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
