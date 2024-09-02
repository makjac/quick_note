part of '../../note_block_builder.dart';

Future<void> showTodoBlockSettings(BuildContext context) async {
  final width = MediaQuery.of(context).size.width;
  final showAlertDialog = AppConstans.mobileSize < width;

  if (showAlertDialog) {
    await _showTodoBlockSettingsDialog(context);
  } else {
    await _showTodoBlockModalBottomSheet(context);
  }
}

Future<void> _showTodoBlockSettingsDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (_) {
      return NoteBlockSettingsDialog(
        title: context.l10n.block_settings_todo_title,
        child: _TodoBlockSettings(context),
      );
    },
  );
}

Future<void> _showTodoBlockModalBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    builder: (_) => NoteBlockModalBottomSheet(
      title: context.l10n.block_settings_todo_title,
      child: _TodoBlockSettings(context),
    ),
  );
}

class _TodoBlockSettings extends StatelessWidget {
  const _TodoBlockSettings(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return BlocBuilder<TodoBlockCubit, TodoBlockState>(
      bloc: BlocProvider.of<TodoBlockCubit>(context),
      builder: (_, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile.adaptive(
              value: state.block.hasTitle,
              activeColor: Colors.white,
              onChanged: (value) => BlocProvider.of<TodoBlockCubit>(context)
                  .changeBlockTitleVisibility(value),
              title: Text(context.l10n.block_settings_todo_show_header),
            ),
            CheckboxListTile.adaptive(
              value: state.block.showCompleteTasks,
              activeColor: Colors.white,
              onChanged: (value) => BlocProvider.of<TodoBlockCubit>(context)
                  .changeBlockCompleteTasksVisibility(value),
              title: Text(context.l10n.block_settings_todo_hide_complete_tasks),
            ),
            CheckboxListTile.adaptive(
              value: state.block.showProgressBar,
              activeColor: Colors.white,
              onChanged: (value) => BlocProvider.of<TodoBlockCubit>(context)
                  .changeBlockProgressBarVisibility(value),
              title: Text(context.l10n.block_settings_todo_progress_bar),
            ),
          ],
        );
      },
    );
  }
}
