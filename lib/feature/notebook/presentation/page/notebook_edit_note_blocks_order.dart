import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/reorder_note_block/reorder_note_block_cubit.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_blocks_draggable/empty_note/notebook_empty_note_block.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_blocks_draggable/note_block_drag_item/note_blocks_drag_item.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_block_type.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';

class NotebookEditNoteBlocksOrder extends StatelessWidget {
  const NotebookEditNoteBlocksOrder({super.key, this.note});

  final Note? note;

  @override
  Widget build(BuildContext context) {
    final noteColor = (note?.color ?? NoteColors.color1)
        .color(context.read<PreferencesBloc>().state.theme);

    if (note?.content == null) {
      return NotebookNoNoteBlockFound(noteColor: noteColor);
    }

    return BlocProvider(
      create: (context) => ReorderNoteBlockCubit(blocks: note?.content),
      child: _NotebookNoteBlocksOrder(
        noteColor: noteColor,
      ),
    );
  }
}

class _NotebookNoteBlocksOrder extends StatelessWidget {
  const _NotebookNoteBlocksOrder({required this.noteColor});

  final Color noteColor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReorderNoteBlockCubit, ReorderNoteBlockState>(
      listenWhen: (previous, current) => previous.blocks != current.blocks,
      listener: (context, state) {
        BlocProvider.of<NotebookBloc>(context).add(
          NotebookUpdateNote(
            updates: NoteUpdates(
              content: state.blocks,
              modified: DateTime.now(),
            ),
          ),
        );
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: noteColor,
            titleTextStyle: const TextStyle(
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          backgroundColor: noteColor,
          body: Padding(
            padding: const EdgeInsets.all(Insets.s),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: AppConstans.mobileSize),
                child: ReorderableListView.builder(
                  itemCount: state.blocks.length,
                  buildDefaultDragHandles: false,
                  header: Container(
                    padding: const EdgeInsets.all(Insets.s),
                    margin: const EdgeInsets.only(bottom: Insets.m),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white60),
                      borderRadius: BorderRadius.circular(Insets.s),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.info),
                        const SizedBox(width: Insets.s),
                        Expanded(
                          child: Text(
                            context.l10n.reorder_block_info,
                            maxLines: 10,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      key: ValueKey(index),
                      child: NoteBlocksDragItem(
                        blockTitle: _getBlockTitle(
                            context, state.blocks[index], state.initialBlocks),
                        type: state.blocks[index].type,
                        index: index,
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    if (oldIndex < newIndex) {
                      newIndex -= 1;
                    }

                    context
                        .read<ReorderNoteBlockCubit>()
                        .reorderNoteBlocks(oldIndex, newIndex);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getBlockTitle(
      BuildContext context, NoteBlock block, List<NoteBlock> listBlocks) {
    if (block.title.isNotEmpty) return block.title;

    final typeBlocksList =
        listBlocks.where((b) => b.type == block.type).toList();
    final blockIndex = typeBlocksList.indexOf(block) + 1;

    if (blockIndex == -1) return "block";

    switch (block.type) {
      case NoteBlockType.text:
        return "${context.l10n.block_type_text} $blockIndex";
      case NoteBlockType.todo:
        return "${context.l10n.block_type_todo} $blockIndex";
      case NoteBlockType.bookmarks:
        return "${context.l10n.block_bookmark_todo} $blockIndex";
      default:
        return "Block $blockIndex";
    }
  }
}
