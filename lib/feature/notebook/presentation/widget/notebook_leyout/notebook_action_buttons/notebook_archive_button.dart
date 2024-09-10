import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NotebookArchiveButton extends StatelessWidget {
  const NotebookArchiveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotebookBloc, NotebookState>(
      builder: (context, state) {
        final isArchived = state.note?.archived ?? false;
        return IconButton(
          onPressed: () {
            BlocProvider.of<NotebookBloc>(context).add(NotebookToggleArchive());
          },
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
