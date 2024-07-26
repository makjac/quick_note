part of '../../note_block_builder.dart';

class TodoBlockProgressBar extends StatelessWidget {
  const TodoBlockProgressBar({super.key, required this.items});

  final List<ChecklistItem> items;

  double _calculateProgress() {
    if (items.isEmpty) return 0;

    final totalTasks = items.length;
    final completeTasks = items.where((task) => task.isChecked).length;

    return completeTasks / totalTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Insets.s, horizontal: Insets.xs),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          tween: Tween<double>(
            begin: _calculateProgress(),
            end: _calculateProgress(),
          ),
          builder: (context, value, child) => Stack(
            children: [
              LinearProgressIndicator(
                value: value,
                minHeight: Insets.m,
                borderRadius: BorderRadius.circular(Insets.xs),
              ),
              Positioned(
                bottom: 3,
                left: Insets.s,
                child: Text(
                  "${(value * 100).floor()} %${(value == 1) ? " 🥳" : ""}",
                  style: TextStyle(
                    color: Theme.of(context).todoProgressBarTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
