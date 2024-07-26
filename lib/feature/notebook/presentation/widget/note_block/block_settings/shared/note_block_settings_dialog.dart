part of '../../note_block_builder.dart';

class NoteBlockSettingsDialog extends StatelessWidget {
  const NoteBlockSettingsDialog({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      scrollable: true,
      content: AnimatedSize(
        duration: const Duration(milliseconds: 200),
        child: SizedBox(
          width: 500,
          child: child,
        ),
      ),
    );
  }
}
