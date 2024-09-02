import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/page/notebook_edit_note_blocks_order.dart';
import 'package:quick_note/feature/notebook/presentation/page/notebook_edit_notes_view.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/router/app_routes.dart';

class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key, this.noteId});

  final num? noteId;

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<NotebookBloc>()..add(NotebookGetNote(noteId: widget.noteId)),
      child: BlocBuilder<NotebookBloc, NotebookState>(
        builder: (context, state) {
          return _buildPage(state);
        },
      ),
    );
  }

  Widget _buildPage(NotebookState state) {
    final currentRouteName = GoRouterState.of(context).topRoute?.path;
    final currentRoute = AppRoutes.values.firstWhere(
      (value) => value.path == currentRouteName,
      orElse: () => AppRoutes.notebook,
    );

    final pageMap = {
      AppRoutes.notebook: NotebookEditNotesView(note: state.note),
      AppRoutes.notebookReorderBlocks:
          NotebookEditNoteBlocksOrder(note: state.note),
    };

    return pageMap[currentRoute] ?? NotebookEditNotesView(note: state.note);
  }
}
