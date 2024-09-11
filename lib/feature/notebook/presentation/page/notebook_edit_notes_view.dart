import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_header/Notebook_desktop_icons_menu/notebook_desktop_icons_menu.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_add_note_block/notebook_add_note_block_button/add_note_block_button.dart';
import 'package:quick_note/feature/notebook/presentation/widget/note_block/note_block_builder.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_bottom_navigation_bar/notebook_bottom_navigation_bar.dart';
import 'package:quick_note/feature/notebook/presentation/widget/notebook_leyout/notebook_header/notebook_popup_menu/notebook_popup_menu.dart';
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
  late ScrollController _scrollController;

  bool get _hasTitle => widget.note?.title.isNotEmpty ?? false;
  bool get _setFocus => !_hasTitle && widget.note != null;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
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
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteColor = _getNoteColor(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = PlatformHelper.isMobile();

    return BlocListener<NotebookBloc, NotebookState>(
      listener: (context, state) {
        if (state is NotebookNoteBlockAdded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToEnd();
          });
        }
      },
      listenWhen: (previous, current) => current is NotebookNoteBlockAdded,
      child: Scaffold(
        backgroundColor: noteColor,
        resizeToAvoidBottomInset: true,
        bottomSheet:
            isMobile ? NotebookBottomNavigationBar(noteColor: noteColor) : null,
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _buildAppBar(noteColor, width, isMobile),
            _buildTitleTextField(),
            ..._buildNoteBlocks(),
            !isMobile
                ? _buildAddNoteButton()
                : const SliverToBoxAdapter(child: SizedBox(height: 65)),
          ],
        ),
      ),
    );
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  Color _getNoteColor(BuildContext context) {
    final theme = context.read<PreferencesBloc>().state.theme;
    return (widget.note?.color ?? NoteColors.color1).color(theme);
  }

  Widget _buildAppBar(Color noteColor, double width, bool isMobile) {
    final isWideScreen = AppConstans.mobileSize > width;

    return SliverAppBar(
      centerTitle: true,
      backgroundColor: noteColor,
      pinned: !isMobile,
      floating: isMobile,
      shadowColor: noteColor,
      actions: isMobile
          ? []
          : [
              if (isWideScreen) NotebookPopupMenu(context),
              if (!isWideScreen) const NotebookDesktopIconsMenu(),
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
