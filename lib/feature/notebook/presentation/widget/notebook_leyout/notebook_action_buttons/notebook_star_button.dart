import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NotebookStarButton extends StatelessWidget {
  const NotebookStarButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotebookBloc, NotebookState>(
      builder: (context, state) {
        final isStarred = state.note?.isStarred ?? false;
        return IconButton(
          onPressed: () {
            BlocProvider.of<NotebookBloc>(context).add(NotebookToggleStar());
          },
          icon: Tooltip(
            message: context.l10n.note_settings_star,
            child: Icon(
              isStarred ? Icons.star_outlined : Icons.star_border,
              color:
                  Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
            ),
          ),
        );
      },
    );
  }
}
