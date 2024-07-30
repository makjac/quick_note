import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile/note_tile.dart';
import 'package:quick_note/feature/home/presentation/widget/notes_segent_header.dart';
import 'package:quick_note/l10n/l10n.dart';

class TrashPage extends StatelessWidget {
  const TrashPage({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(AppCheckDeleteNotes());
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(Insets.s),
              sliver: SliverToBoxAdapter(child: _trashInfo(context)),
            ),
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

  Widget _trashInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Insets.s),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white60),
        borderRadius: BorderRadius.circular(Insets.s),
      ),
      child: Row(
        children: [
          const Icon(Icons.info),
          const SizedBox(width: Insets.s),
          Flexible(
            child: Text(
              context.l10n.trash_info,
              maxLines: 10,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () =>
                BlocProvider.of<AppBloc>(context).add(AppEmptyRecycleBin()),
            child: Text(context.l10n.trash_empty),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNotesSection(
      BuildContext context, AppState state, double width, String header) {
    final notes = state.notes.where((note) => note.expiryDate != null).toList();

    if (notes.isEmpty) {
      return [
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.delete_outline,
                size: 35,
              ),
              const SizedBox(height: Insets.xs),
              Text(
                context.l10n.trash_page_empty,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ];
    }

    return [
      NotesSegentHeader(title: context.l10n.header_deleted),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(Insets.s),
          child: StaggeredGrid.count(
            crossAxisCount: _axisCount(width),
            crossAxisSpacing: Insets.xs,
            mainAxisSpacing: Insets.xs,
            children: notes
                .map(
                  (note) => NoteTile(
                    note: note,
                    isTrash: true,
                  ),
                )
                .toList(),
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
