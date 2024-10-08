import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/utils/url_helper.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/cubit/bookmarks_block_cubit/bookmarks_block_cubit.dart';
import 'package:quick_note/l10n/l10n.dart';

class AddBookmarkWidget extends StatefulWidget {
  const AddBookmarkWidget({super.key, required this.blockId});

  final num blockId;

  @override
  AddBookmarkWidgetState createState() => AddBookmarkWidgetState();
}

class AddBookmarkWidgetState extends State<AddBookmarkWidget>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;
  late FocusNode _focusNode;
  Timer? _debounce;
  bool _enableFocus = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _focusNode = FocusNode();

    final notebookState = context.read<NotebookBloc>().state;

    if (notebookState is NotebookNoteBlockAdded) {
      if (notebookState.block.id == widget.blockId) {
        _focusNode.requestFocus();
      }
    }

    _controller.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    if (_controller.text.isEmpty) return;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _animationController.forward(from: 0);
    });
  }

  void _addBookmark() {
    final String url = _controller.text;

    final isurlValid = UrlHelper.isValidUrl(url);
    if (!isurlValid) {
      _focusNode.requestFocus();
      return;
    }

    final String completedUrl = UrlHelper.completeUrl(url);

    if (UrlHelper.isValidUrl(completedUrl)) {
      context.read<BookmarksBlockCubit>().addBookmark(completedUrl);
      _controller.clear();
    } else {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookmarksBlockCubit, BookmarksBlockState>(
      listener: (context, state) {
        if (state.addingStatus == AddBookmarkStatus.success) {
          _controller.clear();
        }

        if (state.addingStatus == AddBookmarkStatus.loading) {
          _enableFocus = true;
        }

        if (!_enableFocus) return;

        if (state.addingStatus == AddBookmarkStatus.success ||
            state.addingStatus == AddBookmarkStatus.error) {
          _animationController.reverse().then((value) {
            _focusNode.requestFocus();
            _enableFocus = false;
          });
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  autocorrect: false,
                  enabled: state.addingStatus != AddBookmarkStatus.loading,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: context.l10n.bookmark_add_url_field_hint_text,
                  ),
                  onSubmitted: (value) {
                    _addBookmark();
                  },
                ),
              ),
              const SizedBox(width: 8),
              state.addingStatus == AddBookmarkStatus.loading
                  ? _loading()
                  : _animatedButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _animatedButton() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * 0.5 * 3.14159, // 1/4 rotation
          child: _addButtion(),
        );
      },
    );
  }

  Widget _addButtion() {
    return Tooltip(
      message: context.l10n.bookmark_add_bookmark_tooltip,
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: _addBookmark,
      ),
    );
  }

  Widget _loading() {
    return const CircularProgressIndicator();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    _debounce?.cancel();
    _focusNode.dispose();
    super.dispose();
  }
}
