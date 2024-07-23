// ignore_for_file: type_literal_in_constant_pattern

part of 'note_block_builder.dart';

class NoteBlockBuilder extends StatelessWidget {
  const NoteBlockBuilder({super.key, this.noteBlock});

  final NoteBlock? noteBlock;

  @override
  Widget build(BuildContext context) {
    switch (noteBlock?.type) {
      case NoteBlockType.text:
        return TextBlockWidget(block: noteBlock! as TextBlock);
      case NoteBlockType.todo:
        return TodoBlockWidget(block: noteBlock! as TodoBlock);
      default:
        return const SizedBox.shrink();
    }
  }
}
