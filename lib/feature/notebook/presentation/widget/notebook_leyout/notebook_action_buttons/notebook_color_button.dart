import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/service/analytics/service/analytics_service.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NotebookColorButton extends StatelessWidget {
  const NotebookColorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final color = await NoteHelper.showNoteColorPickerDialog(context);
        if (color != null) {
          if (!context.mounted) return;
          BlocProvider.of<NotebookBloc>(context).add(
            NotebookChangeColor(color: color),
          );
          if (PlatformHelper.isMobile()) {
            locator<AnalyticsService>().logChangeNoteColorEvent();
          }
        }
      },
      icon: Tooltip(
        message: context.l10n.note_settings_color,
        child: Icon(
          Icons.color_lens_outlined,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}
