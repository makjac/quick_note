import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/color.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile/note_tile_popup_menu.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile/note_tile_preview/note_tile_preview_builder.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';
import 'package:quick_note/router/app_routes.dart';

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
                .add(AppSelectNote(noteId: widget.note.id)),
            onHover: (value) => setState(() => _showMenuIcon = value),
            child: Container(
              decoration: _noteTailDecoratioon(state),
              padding: const EdgeInsets.all(Insets.s),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlatformHelper.isMobile()
                      ? _mobileNoteTitle()
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
      BlocProvider.of<AppBloc>(context)
          .add(AppSelectNote(noteId: widget.note.id));
    } else {
      context.pushNamed(
        AppRoutes.notebook.name,
        pathParameters: {"id": widget.note.id.toString()},
      );
    }
  }

  bool _isSelected(AppState state) {
    return state.selectedNoteIds.contains(widget.note.id);
  }

  BoxDecoration _borderDecoration(AppState state) {
    final Color noteColor =
        widget.note.color.color(context.read<PreferencesBloc>().state.theme);

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
    final Color noteColor =
        widget.note.color.color(context.read<PreferencesBloc>().state.theme);
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

  Widget _mobileNoteTitle() => Text(
        widget.note.title.isNotEmpty ? widget.note.title : "...",
        maxLines: 2,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color:
                  Theme.of(context).textTheme.titleSmall?.color?.withAlpha(220),
            ),
      );

  Widget _desktopNoteTitle(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              widget.note.title.isNotEmpty ? widget.note.title : "...",
              maxLines: 1,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.color
                        ?.withAlpha(220),
                  ),
            ),
          ),
          if (_showMenuIcon)
            NoteTilePopupMenu(
              note: widget.note,
              context: context,
            ),
        ],
      );

  Widget _noteContent() {
    if (widget.note.content.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: Insets.xs),
      child: NoteTilePreviewBuilder(noteBlock: widget.note.content.first),
    );
  }
}
