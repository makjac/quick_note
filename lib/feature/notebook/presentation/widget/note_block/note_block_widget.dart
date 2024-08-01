part of 'note_block_builder.dart';

class NoteBlockWidget extends StatefulWidget {
  const NoteBlockWidget({
    super.key,
    required this.block,
    required this.blockId,
    this.onMorePressed,
  });

  final Widget block;
  final num blockId;
  final void Function()? onMorePressed;

  @override
  State<NoteBlockWidget> createState() => _NoteBlockWidgetState();
}

class _NoteBlockWidgetState extends State<NoteBlockWidget> {
  bool _isHovered = false;

  void _setHover(bool hoverValue) {
    final isMobile = PlatformHelper.isMobile();
    if (isMobile) return;

    setState(() {
      _isHovered = hoverValue;
    });
  }

  bool _showSettings() {
    final isMobile = PlatformHelper.isMobile();

    return isMobile || _isHovered;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _setHover(true),
      onExit: (_) => _setHover(false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Insets.xs),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Theme.of(context).noteBlockBorderColor),
            bottom: BorderSide(color: Theme.of(context).noteBlockBorderColor),
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(Insets.s),
              child: widget.block,
            ),
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _showSettings() ? 1 : 0,
                child: NoteBlockSettings(
                  blockId: widget.blockId,
                  onMorePressed: widget.onMorePressed,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
