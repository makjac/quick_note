part of '../note_block_builder.dart';

class NoteBlockSettings extends StatefulWidget {
  const NoteBlockSettings({
    super.key,
    required this.blockId,
    this.onMorePressed,
  });

  final num blockId;
  final void Function()? onMorePressed;

  @override
  State<NoteBlockSettings> createState() => _NoteBlockSettingsState();
}

class _NoteBlockSettingsState extends State<NoteBlockSettings> {
  bool isShowned = false;

  void _setShowSettings(bool value) {
    setState(() {
      isShowned = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _setShowSettings(true),
      onExit: (event) => _setShowSettings(false),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        reverseDuration: const Duration(milliseconds: 200),
        curve: Curves.fastEaseInToSlowEaseOut,
        alignment: Alignment.topRight,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Insets.xs),
            ),
          ),
          padding: const EdgeInsets.only(
            top: Insets.xxs,
            bottom: Insets.xs,
            left: Insets.s,
            right: Insets.s,
          ),
          child: isShowned ? _settingsOptions() : _settingsIcon(),
        ),
      ),
    );
  }

  Widget _settingsIcon() {
    return GestureDetector(
      onTap: () => _setShowSettings(true),
      child: Icon(
        Icons.settings,
        color: Colors.grey[800],
      ),
    );
  }

  void _openReorderNoteBlocksRoute() {
    final goRouterState = GoRouterState.of(context);
    final noteId = goRouterState.pathParameters['id'];

    if (noteId == null) return;

    context.pushNamed(
      AppRoutes.notebookReorderBlocks.name,
      pathParameters: {
        "id": noteId,
      },
    );
  }

  Widget _settingsOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Tooltip(
          message: context.l10n.tooltip_move_note_block,
          child: IconButton(
            onPressed: _openReorderNoteBlocksRoute,
            icon: const Icon(Icons.drag_handle),
            padding: EdgeInsets.zero,
            color: Colors.grey[800],
          ),
        ),
        Tooltip(
          message: context.l10n.tooltip_delete_note_block,
          child: IconButton(
            onPressed: () => BlocProvider.of<NotebookBloc>(context)
                .add(NotebookDeleteBlock(blockId: widget.blockId)),
            icon: const Icon(Icons.delete),
            padding: EdgeInsets.zero,
            color: Colors.grey[800],
          ),
        ),
        Tooltip(
          message: context.l10n.tooltip_more,
          child: IconButton(
            onPressed: widget.onMorePressed,
            icon: const Icon(Icons.more_vert),
            padding: EdgeInsets.zero,
            color: Colors.grey[800],
          ),
        ),
        _hideSettingsIcon(),
      ],
    );
  }

  Widget _hideSettingsIcon() {
    final isMobile = PlatformHelper.isMobile();
    if (!isMobile) return const SizedBox.shrink();

    return Tooltip(
      message: "hide Setting",
      child: IconButton(
        onPressed: () => _setShowSettings(false),
        icon: const Icon(Icons.close),
        padding: EdgeInsets.zero,
        color: Colors.grey[800],
      ),
    );
  }
}
