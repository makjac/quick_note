import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NotebookTitleTextField extends StatefulWidget {
  const NotebookTitleTextField({super.key, this.focusNode});

  final FocusNode? focusNode;

  @override
  State<NotebookTitleTextField> createState() => _NotebookTitleTextFieldState();
}

class _NotebookTitleTextFieldState extends State<NotebookTitleTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotebookBloc, NotebookState>(
      listener: (context, state) {
        _controller.text = state.note?.title ?? "";
      },
      listenWhen: (previous, current) {
        return _controller.text.isEmpty;
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.s),
        child: TextField(
          controller: _controller,
          focusNode: widget.focusNode,
          onChanged: (value) {
            BlocProvider.of<NotebookBloc>(context)
                .add(NotebookUpdateNote(updates: NoteUpdates(title: value)));
          },
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: Theme.of(context).textTheme.titleMedium,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: context.l10n.notebook_title_hint_text,
            hintStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).noteTitleTextFieldColor,
            ),
          ),
        ),
      ),
    );
  }
}
