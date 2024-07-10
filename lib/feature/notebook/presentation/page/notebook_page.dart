import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';
import 'package:quick_note/core/extension/string.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/note_block_builder.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/l10n/l10n.dart';

class NotebookPage extends StatefulWidget {
  NotebookPage({super.key, Note? note})
      : note = note ??
            Note(
              id: 1,
              created: DateTime.now(),
              modified: DateTime.now(),
              title: "",
            );

  final Note note;

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.note.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex(widget.note.colorHex),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: HexColor.fromHex(widget.note.colorHex),
          ),
          SliverToBoxAdapter(
            child: _titleTextField(context),
          ),
          ...(widget.note.content ?? []).map((block) => SliverToBoxAdapter(
                  child: NoteBlockBuilder(
                noteBlock: block,
              )))
        ],
      ),
    );
  }

  Widget _titleTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Insets.s),
      child: TextField(
        controller: _controller,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: context.l10n.input_title.capitalize(),
          hintStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
