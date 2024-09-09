import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/bookmarks_block_cubit/bookmarks_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/blocks/bookmarks/add_bookmark_widget.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/blocks/bookmarks/bookmarks_grid_widget.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/note_block_builder.dart';
import 'package:quick_note/feature/shared/domain/entity/note/blocks/bookmarks/bookmarks_block.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/l10n/l10n.dart';

class BookmarksBlockWidget extends StatelessWidget {
  const BookmarksBlockWidget({super.key, required this.block});

  final BookmarksBlock block;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<BookmarksBlockCubit>(
        param1: block,
        param2: context.read<NotebookBloc>(),
      ),
      child: Builder(builder: (context) {
        return NoteBlockWidget(
          block: const _BookmarksBlockBody(),
          blockId: block.id,
          onMorePressed: () => showBookmarksBlockSettings(context),
        );
      }),
    );
  }
}

class _BookmarksBlockBody extends StatefulWidget {
  const _BookmarksBlockBody();

  @override
  State<_BookmarksBlockBody> createState() => _BookmarksBlockBodyState();
}

class _BookmarksBlockBodyState extends State<_BookmarksBlockBody> {
  late TextEditingController _titleController;

  @override
  void initState() {
    _titleController = TextEditingController()
      ..text = BlocProvider.of<BookmarksBlockCubit>(context).state.block.title;
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarksBlockCubit, BookmarksBlockState>(
      listenWhen: (previous, current) => previous.block != current.block,
      listener: (context, state) {
        BlocProvider.of<NotebookBloc>(context).add(
          NotebookUpdateNoteBlock(
            block: state.block,
            command: state.command,
          ),
        );
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _blockTitle(context, state),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.xs),
              child: BookmarksGridWidget(
                block: state.block,
              ),
            ),
            const SizedBox(height: Insets.xs),
            AddBookmarkWidget(blockId: state.block.id),
          ],
        );
      },
    );
  }

  Widget _blockTitle(BuildContext context, BookmarksBlockState state) {
    if (state.block.hasTitle) {
      return BlocListener<BookmarksBlockCubit, BookmarksBlockState>(
        listener: (context, state) {
          _titleController.text = state.block.title;
        },
        listenWhen: (previous, current) =>
            current is BookmarksBlockUndoRedoState,
        child: NoteBlockTitle(
          controller: _titleController,
          initValue: state.block.title,
          hintText: context.l10n.bookmark_block_title_hint_text,
          onChanged: (title) =>
              context.read<BookmarksBlockCubit>().changeBlockTitle(title),
        ),
      );
    } else {
      return const SizedBox(height: Insets.s);
    }
  }
}
