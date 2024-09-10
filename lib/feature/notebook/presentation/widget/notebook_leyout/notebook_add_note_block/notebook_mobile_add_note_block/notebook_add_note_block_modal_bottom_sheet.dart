import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/l10n/l10n.dart';

class NotebookAddNoteBlockModalBottomSheet extends StatelessWidget {
  const NotebookAddNoteBlockModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _showAddNoteBlockModalBottomSheet(context),
      icon: const Icon(Icons.add_box_outlined),
    );
  }

  void _showAddNoteBlockModalBottomSheet(BuildContext context) {
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
