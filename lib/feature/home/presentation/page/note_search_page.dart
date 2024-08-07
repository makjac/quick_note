import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/cubit/note_search_cubit.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile/note_tile.dart';
import 'package:quick_note/feature/home/presentation/widget/notes_segent_header.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/l10n/l10n.dart';

class NoteSearchPage extends StatelessWidget {
  const NoteSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<NoteSearchCubit, NoteSearchState>(
      builder: (context, state) {
        final notes = BlocProvider.of<AppBloc>(context).state.notes;

        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: Insets.s),
            ),
            ..._buildNotesSection(context, notes, state.searchTerm, width),
          ],
        );
      },
    );
  }

  List<Widget> _buildNotesSection(
      BuildContext context, List<Note> notes, String searchTerm, double width) {
    final filteredNotes = notes
        .where((note) =>
            (note.title.toLowerCase()).contains(searchTerm.toLowerCase()))
        .where((note) => note.expiryDate == null)
        .toList();

    if (filteredNotes.isEmpty) {
      return [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off,
                size: 35,
              ),
              const SizedBox(height: Insets.xs),
              Text(
                context.l10n.note_search_empty,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ];
    }

    return [
      NotesSegentHeader(
        title: context.l10n.header_search_results(filteredNotes.length),
      ),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(Insets.s),
          child: StaggeredGrid.count(
            crossAxisCount: _axisCount(width),
            crossAxisSpacing: Insets.xs,
            mainAxisSpacing: Insets.xs,
            children:
                filteredNotes.map((note) => NoteTile(note: note)).toList(),
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
}
