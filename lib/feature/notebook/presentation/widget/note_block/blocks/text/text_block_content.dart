part of '../../note_block_builder.dart';

class TextBlockContent extends StatefulWidget {
  const TextBlockContent({super.key, required this.block});

  final TextBlock block;

  @override
  State<TextBlockContent> createState() => _TextBlockContentState();
}

class _TextBlockContentState extends State<TextBlockContent> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  int _displayedLineCount = 0;
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.block.text);
    _focusNode = FocusNode();

    final notebookState = context.read<NotebookBloc>().state;

    if (notebookState is NotebookNoteBlockAdded) {
      if (notebookState.block.id == widget.block.id) {
        _focusNode.requestFocus();
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateDisplayedLineCount() {
    final text = _controller.text;
    final textPainter = TextPainter(
      text: TextSpan(
          text: text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            letterSpacing: .6,
          )),
      textDirection: TextDirection.ltr,
      maxLines: null,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width - Insets.l);

    setState(() {
      final metrics = textPainter.computeLineMetrics();
      _displayedLineCount = metrics.length;
    });
  }

  int? _maxLinesLimit() {
    final hasLimit = widget.block.hasMaxLineLimit;
    if (!hasLimit || _isExpanded) return null;

    final limit = widget.block.maxLines;
    return limit;
  }

  bool _showExpandButton() {
    final bool hasLimit = widget.block.hasMaxLineLimit;
    if (!hasLimit) return false;

    _updateDisplayedLineCount();
    final int limit = widget.block.maxLines;
    return limit < _displayedLineCount;
  }

  ScrollPhysics? _setScroll() {
    final hasLimit = widget.block.hasMaxLineLimit;
    if (hasLimit) return const NeverScrollableScrollPhysics();

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.topCenter,
          child: BlocListener<TextBlockCubit, TextBlockState>(
            listener: (context, state) {
              _controller.text = state.block.text;
            },
            listenWhen: (previous, current) =>
                current is TextBlockUndoRedoState,
            child: DebounceTextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLines: _maxLinesLimit(),
              minLines: 1,
              keyboardType: TextInputType.multiline,
              textCapitalization: TextCapitalization.sentences,
              scrollPhysics: _setScroll(),
              decoration: InputDecoration(
                hintText: context.l10n.text_block_note_hint_text,
                border: InputBorder.none,
              ),
              style: const TextStyle(
                letterSpacing: .6,
              ),
              onDebounceChange: (value) {
                context.read<TextBlockCubit>().changeNoteText(value);
                if (widget.block.hasMaxLineLimit) _updateDisplayedLineCount();
              },
            ),
          ),
        ),
        if (_showExpandButton())
          TextBlockExpandContextButton(
            onChanged: (expanded) => setState(() {
              _isExpanded = expanded;
            }),
          ),
      ],
    );
  }
}
