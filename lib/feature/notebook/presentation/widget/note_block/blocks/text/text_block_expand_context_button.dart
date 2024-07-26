part of '../../note_block_builder.dart';

class TextBlockExpandContextButton extends StatefulWidget {
  const TextBlockExpandContextButton({super.key, required this.onChanged});

  final void Function(bool expanded) onChanged;

  @override
  State<TextBlockExpandContextButton> createState() =>
      _TextBlockExpandContextButtonState();
}

class _TextBlockExpandContextButtonState
    extends State<TextBlockExpandContextButton> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  String _setupButtonTextI() {
    return _isExpanded ? "Show less" : "Show more";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Insets.s),
      child: InkWell(
        onTap: () {
          _toggleExpand();
          widget.onChanged(_isExpanded);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedRotation(
              turns: _isExpanded ? 0 : 0.5,
              duration: const Duration(milliseconds: 200),
              child: const Icon(Icons.keyboard_arrow_up_outlined),
            ),
            Padding(
              padding: const EdgeInsets.all(Insets.xs),
              child: Text(_setupButtonTextI()),
            ),
          ],
        ),
      ),
    );
  }
}
