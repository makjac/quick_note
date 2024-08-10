import 'package:flutter/material.dart';

class NotebookNoNoteBlockFound extends StatelessWidget {
  const NotebookNoNoteBlockFound({super.key, required this.noteColor});

  final Color noteColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note is null'),
        backgroundColor: noteColor,
      ),
      backgroundColor: noteColor,
      body: const Center(child: Text('No note to display')),
    );
  }
}
