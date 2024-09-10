import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_header/Notebook_desktop_icons_menu/notebook_desktop_icons_menu.dart';
import 'package:quick_note/feature/notebook/presentation/widget/add_note_block_button/add_note_block_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/note_block_builder.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_bottom_navigation_bar/notebook_bottom_navigation_bar.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_title_text_field.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';

class NotebookEditNotesView extends StatefulWidget {
  const NotebookEditNotesView({super.key, this.note});

  final Note? note;

  @override
  State<NotebookEditNotesView> createState() => _NotebookEditNotesViewState();
}

class _NotebookEditNotesViewState extends State<NotebookEditNotesView> {
  late FocusNode _focusNode;

  bool get _hasTitle => widget.note?.title.isNotEmpty ?? false;
  bool get _setFocus => !_hasTitle && widget.note != null;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(covariant NotebookEditNotesView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.note == null) {
      _setFocus ? _focusNode.requestFocus() : _focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteColor = _getNoteColor(context);
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: noteColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(noteColor, width),
          _buildTitleTextField(),
          ..._buildNoteBlocks(),
          _buildAddNoteButton(),
        ],
      ),
    );
  }

  Color _getNoteColor(BuildContext context) {
    final theme = context.read<PreferencesBloc>().state.theme;
    return (widget.note?.color ?? NoteColors.color1).color(theme);
  }

  Widget _buildAppBar(Color noteColor, double width) {
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: noteColor,
      pinned: true,
      shadowColor: noteColor,
      actions: [
        if (AppConstans.mobileSize > width) NotebookPopupMenu(context),
        if (AppConstans.mobileSize < width) const NotebookDesktopIconsMenu(),
      ],
    );
  }

  Widget _buildTitleTextField() {
    return SliverToBoxAdapter(
      child: NotebookTitleTextField(
        focusNode: _focusNode,
      ),
    );
  }

  List<Widget> _buildNoteBlocks() {
    return widget.note?.content
            .map(
              (block) => SliverToBoxAdapter(
                key: ValueKey(block.id),
                child: NoteBlockBuilder(
                  noteBlock: block,
                ),
              ),
            )
            .toList() ??
        [];
  }

  Widget _buildAddNoteButton() {
    return const SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(Insets.s),
          child: AddNoteBlockButton(),
        ),
      ),
    );
  }
}
