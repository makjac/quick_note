import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile/note_tile.dart';
import 'package:quick_note/feature/home/presentation/widget/notes_segent_header.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/l10n/l10n.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: Insets.s),
            ),
            ..._setup(context, state, width),
          ],
        );
      },
    );
  }

  List<Widget> _setup(BuildContext context, AppState state, double width) {
    final notes = state.notes;
    final staredNotes = notes
        .where((note) => (note.isStarred))
        .where((note) => !note.archived)
        .toList();
    final otherNotes = notes
        .where((note) => (!note.isStarred))
        .where((note) => !note.archived)
        .toList();

    bool hasNotes = staredNotes.isNotEmpty || otherNotes.isNotEmpty;
    if (!hasNotes) return [_emptyScreen(context)];

    return [
      if (staredNotes.isNotEmpty)
        ..._buildNotesSection(staredNotes, width, context.l10n.header_stared),
      if (otherNotes.isNotEmpty)
        ..._buildNotesSection(otherNotes, width, context.l10n.header_others)
    ];
  }

  List<Widget> _buildNotesSection(
      List<Note> notes, double width, String header) {
    return [
      NotesSegentHeader(title: header),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(Insets.s),
          child: StaggeredGrid.count(
            crossAxisCount: _axisCount(width),
            crossAxisSpacing: Insets.xs,
            mainAxisSpacing: Insets.xs,
            children: notes.map((note) => NoteTile(note: note)).toList(),
          ),
        ),
      ),
    ];
  }

  int _axisCount(double width) {
    if (PlatformHelper.isMobile()) {
      return width > 200 ? width ~/ 200 : 1;
    }
    return width > 350 ? width ~/ 350 : 1;
  }

  Widget _emptyScreen(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.folder_off_outlined,
            size: 35,
          ),
          const SizedBox(height: Insets.s),
          Text(
            context.l10n.note_page_empty,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: Insets.xxs),
          TextButton(
            onPressed: () {},
            child: Text(
              context.l10n.note_page_create_first_note,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
