import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_archive_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_color_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_delete_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_redo_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_star_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_action_buttons/notebook_undo_button.dart';

class NotebookDesktopIconsMenu extends StatelessWidget {
  const NotebookDesktopIconsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotebookBloc, NotebookState>(
      builder: (context, state) {
        final isNotArchived = !(state.note?.archived ?? false);

        return Row(
          children: [
            const NotebookUndoButton(),
            const SizedBox(width: Insets.xxs),
            const NotebookRedoButton(),
            const SizedBox(width: Insets.s),
            const NotebookColorButton(),
            const SizedBox(width: Insets.xxs),
            if (isNotArchived)
              const Padding(
                padding: EdgeInsets.only(right: Insets.xxs),
                child: NotebookStarButton(),
              ),
            const NotebookArchiveButton(),
            const SizedBox(width: Insets.xxs),
            const NotebookDeleteButton(),
            const SizedBox(width: Insets.s),
          ],
        );
      },
    );
  }
}
