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
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: Insets.xs),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white10),
            bottom: BorderSide(color: Colors.white10),
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
                opacity: isHovered ? 1 : 0,
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
