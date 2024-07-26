part of '../../note_block_builder.dart';

class TodoBlockAddTaskButton extends StatelessWidget {
  const TodoBlockAddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Insets.xxs),
      child: TextButton(
        onPressed: () => context.read<TodoBlockCubit>().addCheckbox(),
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).todoAddTaskForegroundButtonColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Insets.s,
            vertical: Insets.xxs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.add),
              const SizedBox(width: Insets.xs),
              Text(
                context.l10n.todo_block_add_task,
                style: const TextStyle(letterSpacing: .8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
