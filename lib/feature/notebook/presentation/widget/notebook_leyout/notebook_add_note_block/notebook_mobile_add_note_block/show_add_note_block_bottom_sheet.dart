import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/service/analytics/service/analytics_service.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/l10n/l10n.dart';

class ShowAddNoteBlockBottomSheet {
  static void show(BuildContext context) {
    if (!context.mounted) return;

    final notebookBloc = BlocProvider.of<NotebookBloc>(context);

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(Insets.s),
          child: Wrap(
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: Insets.s, bottom: Insets.xs),
                child: Text(
                  "${context.l10n.add_note_block}:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: Text(context.l10n.block_type_text),
                onTap: () {
                  notebookBloc.add(
                    const NotebookAddNoteBlock(type: NoteBlockType.text),
                  );
                  _logCreateNoteEvent(NoteBlockType.text);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_box_outlined),
                title: Text(context.l10n.block_type_todo),
                onTap: () {
                  notebookBloc.add(
                    const NotebookAddNoteBlock(type: NoteBlockType.todo),
                  );
                  _logCreateNoteEvent(NoteBlockType.todo);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.bookmark_border),
                title: Text(context.l10n.block_bookmark_todo),
                onTap: () {
                  notebookBloc.add(
                    const NotebookAddNoteBlock(type: NoteBlockType.bookmarks),
                  );
                  _logCreateNoteEvent(NoteBlockType.bookmarks);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  static void _logCreateNoteEvent(NoteBlockType blockType) {
    if (PlatformHelper.isMobile()) {
      locator<AnalyticsService>().logAddBlockEvent(blockType);
    }
  }
}
