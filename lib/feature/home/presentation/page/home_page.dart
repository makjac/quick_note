import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_darwer.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_layout.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile/note_tile.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/l10n/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return SafeArea(
            child: HomePageLayout(
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(height: Insets.s),
                  ),
                  ..._buildNotesSection(
                      state, width, true, context.l10n.header_stared),
                  ..._buildNotesSection(
                      state, width, false, context.l10n.header_others),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNote(context),
        child: const Icon(Icons.add),
      ),
      drawer: const HomePageDarwer(),
    );
  }

  void _addNote(BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(CreateNote(
        note: Note(
      id: DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF,
      created: DateTime.now(),
      modified: DateTime.now(),
      colorHex: "fe653a",
      title: (DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF).toString(),
    )));
  }

  List<Widget> _buildNotesSection(
      AppState state, double width, bool isStarred, String header) {
    final notes =
        state.notes.where((note) => note.isStarred == isStarred).toList();

    if (notes.isEmpty) return [];

    return [
      _header(header),
      SliverPadding(
        padding: const EdgeInsets.all(Insets.s),
        sliver: SliverMasonryGrid.count(
          crossAxisCount: width > 200 ? width ~/ 200 : 1,
          childCount: notes.length,
          crossAxisSpacing: Insets.xs,
          mainAxisSpacing: Insets.xs,
          itemBuilder: (context, index) => NoteTile(note: notes[index]),
        ),
      ),
    ];
  }

  Widget _header(String label) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.s),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
            letterSpacing: .8,
          ),
        ),
      ),
    );
  }
}
