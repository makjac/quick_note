import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/color.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile/note_tile_preview/note_tile_preview_builder.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/router/app_routes.dart';

enum _Menu { select, color, star, delete }

class NoteTile extends StatefulWidget {
  const NoteTile({super.key, required this.note});

  final Note note;

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  bool _showMenuIcon = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Container(
          decoration: _borderDecoration(state),
          child: InkWell(
            onTap: () => _onTap(context),
            onLongPress: () => BlocProvider.of<AppBloc>(context)
                .add(SelectNote(noteId: widget.note.id)),
            onHover: (value) => setState(() => _showMenuIcon = value),
            child: Container(
              decoration: _noteTailDecoratioon(state),
              padding: const EdgeInsets.all(Insets.s),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlatformHelper.isMobile()
                      ? _noteTitle()
                      : _desktopNoteTitle(context),
                  _noteContent(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTap(BuildContext context) {
    bool isSelecting = BlocProvider.of<AppBloc>(context).state.isSelecting;

    if (isSelecting) {
      BlocProvider.of<AppBloc>(context).add(SelectNote(noteId: widget.note.id));
    } else {
      context.push(AppRoutes.notebook.path, extra: widget.note);
    }
  }

  bool _isSelected(AppState state) {
    return state.selectedNoteIds.contains(widget.note.id);
  }

  BoxDecoration _borderDecoration(AppState state) {
    final Color noteColor = HexColor.fromHex(widget.note.colorHex);

    final bool isSelected = _isSelected(state) && state.isSelecting;

    return BoxDecoration(
      border: Border.all(
        color:
            isSelected ? noteColor.changeBrightness(0.3) : Colors.transparent,
        width: 4,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(Insets.xs),
      ),
    );
  }

  BoxDecoration _noteTailDecoratioon(AppState state) {
    final Color noteColor = HexColor.fromHex(widget.note.colorHex);
    final bool isSelected = _isSelected(state);
    final bool isSelecting = state.isSelecting;

    final Color adjustedColor = isSelecting
        ? isSelected
            ? noteColor.changeBrightness(0.05)
            : noteColor.withAlpha(150)
        : noteColor;

    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          adjustedColor.changeBrightness(0.07),
          adjustedColor,
          adjustedColor,
          adjustedColor.changeBrightness(-0.12),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
          blurRadius: 3,
          color: Colors.black54,
          offset: Offset(2, 2),
        )
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(Insets.xxs),
      ),
    );
  }

  Widget _noteTitle() => Text(
        widget.note.title.isNotEmpty ? widget.note.title : "...",
        maxLines: 2,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _desktopNoteTitle(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              widget.note.title.isNotEmpty ? widget.note.title : "...",
              maxLines: 1,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          ..._showMenuIcon ? [_popupmenu(context)] : [],
        ],
      );

  Widget _popupmenu(BuildContext context) {
    return PopupMenuButton<_Menu>(
      color: Colors.grey[850],
      popUpAnimationStyle: AnimationStyle.noAnimation,
      iconSize: 20,
      splashRadius: 20,
      itemBuilder: (_) => <PopupMenuEntry<_Menu>>[
        _buildSelectMenuItem(context),
        _buildColorMenuItem(context),
        _buildStarMenuItem(context),
        _buildArchiveMenuItem(context),
        const PopupMenuDivider(),
        _buildDeleteMenuItem(context),
      ],
      child: const Icon(
        Icons.more_vert_sharp,
        size: 20,
      ),
    );
  }

  PopupMenuItem<_Menu> _buildSelectMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.select,
      onTap: () => appBloc.add(SelectNote(noteId: widget.note.id)),
      child: const ListTile(
        iconColor: Colors.white70,
        textColor: Colors.white70,
        leading: Icon(Icons.check_box_outlined),
        title: Text('Select'),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildColorMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.color,
      onTap: () async {
        final color = await NoteHelper.showNoteColorPickerDialog(context);
        if (color != null) {
          appBloc.add(UpdateSingleNote(
            note: widget.note,
            updates: NoteUpdates(colorHex: color.toHex()),
          ));
        }
      },
      child: const ListTile(
        iconColor: Colors.white70,
        textColor: Colors.white70,
        leading: Icon(
          Icons.color_lens_outlined,
        ),
        title: Text('Change Color'),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildStarMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.star,
      onTap: () => appBloc.add(UpdateSingleNote(
        note: widget.note,
        updates: NoteUpdates(isStarred: !widget.note.isStarred),
      )),
      child: const ListTile(
        iconColor: Colors.white70,
        textColor: Colors.white70,
        leading: Icon(Icons.star_border),
        title: Text('Star'),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildArchiveMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuItem<_Menu>(
      value: _Menu.star,
      onTap: () => appBloc.add(UpdateSingleNote(
        note: widget.note,
        updates: NoteUpdates(archived: !widget.note.archived),
      )),
      child: const ListTile(
        iconColor: Colors.white70,
        textColor: Colors.white70,
        leading: Icon(Icons.archive_outlined),
        title: Text('Archive'),
      ),
    );
  }

  PopupMenuItem<_Menu> _buildDeleteMenuItem(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final redColor = Colors.red.withAlpha(200);
    return PopupMenuItem<_Menu>(
      value: _Menu.delete,
      onTap: () => appBloc.add(DeleteSingleNote(id: widget.note.id)),
      child: ListTile(
        iconColor: redColor,
        textColor: redColor,
        leading: const Icon(Icons.delete_outline),
        title: const Text('delete'),
      ),
    );
  }

  Widget _noteContent() {
    if (widget.note.content.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: Insets.xs),
      child: NoteTilePreviewBuilder(noteBlock: widget.note.content.first),
    );
  }
}
