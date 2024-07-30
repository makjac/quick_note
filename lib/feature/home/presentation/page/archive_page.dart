import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile/note_tile.dart';
import 'package:quick_note/feature/home/presentation/widget/notes_segent_header.dart';
import 'package:quick_note/l10n/l10n.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

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
            ..._buildNotesSection(
                context, state, width, context.l10n.header_others),
          ],
        );
      },
    );
  }

  List<Widget> _buildNotesSection(
      BuildContext context, AppState state, double width, String header) {
    final notes = state.notes
        .where((note) => note.archived)
        .where((note) => note.expiryDate == null)
        .toList();

    if (notes.isEmpty) {
      return [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.folder_off_outlined,
                size: 35,
              ),
              const SizedBox(height: Insets.xs),
              Text(
                context.l10n.archive_page_empty,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ];
    }

    return [
      NotesSegentHeader(title: context.l10n.header_archived),
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
}
