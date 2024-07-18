import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/widget/add_note_block_button/add_note_block_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/note_block_builder.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/l10n/l10n.dart';

class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key, this.noteId});

  final num? noteId;

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  late TextEditingController _controller;

  final Note note =
      Note(id: 1, created: DateTime.now(), modified: DateTime.now());

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: note.title);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<NotebookBloc>()..add(NotebookGetNote(noteId: widget.noteId)),
      child: BlocConsumer<NotebookBloc, NotebookState>(
        listener: (context, state) {
          _controller.text = state.note?.title ?? "";
        },
        builder: (context, state) {
          final noteColor = HexColor.fromHex(state.note?.colorHex ?? "");

          return Scaffold(
            backgroundColor: noteColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  centerTitle: true,
                  backgroundColor: noteColor,
                  pinned: true,
                  shadowColor: noteColor,
                ),
                SliverToBoxAdapter(
                  child: _titleTextField(context),
                ),
                ...(state.note?.content)?.map(
                      (block) => SliverToBoxAdapter(
                        child: NoteBlockBuilder(
                          noteBlock: block,
                        ),
                      ),
                    ) ??
                    [],
                const SliverToBoxAdapter(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(Insets.s),
                      child: AddNoteBlockButton(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _titleTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.s),
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          BlocProvider.of<NotebookBloc>(context)
              .add(NotebookUpdateNote(updates: NoteUpdates(title: value)));
        },
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: context.l10n.notebook_title_hint_text,
          hintStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
