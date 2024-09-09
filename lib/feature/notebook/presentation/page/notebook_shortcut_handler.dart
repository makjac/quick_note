import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/feature/notebook/presentation/bloc/notebook_bloc.dart';

class UndoIntent extends Intent {
  const UndoIntent();
}

class RedoIntent extends Intent {
  const RedoIntent();
}

class NotebookShotcutHandler extends StatefulWidget {
  const NotebookShotcutHandler({super.key, required this.child});

  final Widget child;

  @override
  State<NotebookShotcutHandler> createState() => _NotebookShotcutHandlerState();
}

class _NotebookShotcutHandlerState extends State<NotebookShotcutHandler> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: {
        LogicalKeySet(
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.keyZ,
        ): const UndoIntent(),
        LogicalKeySet(
          LogicalKeyboardKey.control,
          LogicalKeyboardKey.shift,
          LogicalKeyboardKey.keyZ,
        ): const RedoIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          UndoIntent: CallbackAction<UndoIntent>(
            onInvoke: (UndoIntent intent) =>
                BlocProvider.of<NotebookBloc>(context).add(NotebookUndo()),
          ),
          RedoIntent: CallbackAction<RedoIntent>(
            onInvoke: (RedoIntent intent) =>
                BlocProvider.of<NotebookBloc>(context).add(NotebookRedo()),
          ),
        },
        child: Focus(
          focusNode: _focusNode,
          autofocus: true,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
