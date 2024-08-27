import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/notebook/presentation/widget/Notebook_desktop__icons_menu/notebook_desktop_icons_menu.dart';
import 'package:quick_note/feature/notebook/presentation/widget/add_note_block_button/add_note_block_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/note_block_builder.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_popup_menu.dart/notebook_popup_menu.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_title_text_field.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';

class NotebookEditNotesView extends StatelessWidget {
  const NotebookEditNotesView({super.key, this.note});

  final Note? note;

  bool get _hasTitle => note?.title.isNotEmpty ?? false;

  bool get _setFocus => !_hasTitle && note != null;

  @override
  Widget build(BuildContext context) {
    final focusNode = FocusNode();
    final noteColor = (note?.color ?? NoteColors.color1)
        .color(context.read<PreferencesBloc>().state.theme);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: noteColor,
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            backgroundColor: noteColor,
            pinned: true,
            shadowColor: noteColor,
            actions: [
              if (AppConstans.mobileSize > width) NotebookPopupMenu(context),
              if (AppConstans.mobileSize < width)
                const NotebookDesktopIconsMenu(),
            ],
          ),
          SliverToBoxAdapter(
            child: NotebookTitleTextField(
              focusNode: _setFocus
                  ? (focusNode..requestFocus())
                  : (focusNode..unfocus()),
            ),
          ),
          ...(note?.content ?? []).map(
            (block) => SliverToBoxAdapter(
              child: NoteBlockBuilder(
                noteBlock: block,
              ),
            ),
          ),
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
  }
}
