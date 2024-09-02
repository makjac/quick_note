part of '../../note_block_builder.dart';

Future<void> showBookmarksBlockSettings(BuildContext context) async {
  final width = MediaQuery.of(context).size.width;
  final showAlertDialog = AppConstans.mobileSize < width;

  if (showAlertDialog) {
    await _showBookmarksBlockSettingsDialog(context);
  } else {
    await _showBookmarksBlockModalBottomSheet(context);
  }
}

Future<void> _showBookmarksBlockSettingsDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (_) {
      return NoteBlockSettingsDialog(
        title: context.l10n.block_settings_bookmark_title,
        child: _BookmarksBlockSettings(context),
      );
    },
  );
}

Future<void> _showBookmarksBlockModalBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    useSafeArea: true,
    builder: (_) => NoteBlockModalBottomSheet(
      title: context.l10n.block_settings_bookmark_title,
      child: _BookmarksBlockSettings(context),
    ),
  );
}

class _BookmarksBlockSettings extends StatelessWidget {
  const _BookmarksBlockSettings(this.context);

  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return BlocBuilder<BookmarksBlockCubit, BookmarksBlockState>(
      bloc: BlocProvider.of<BookmarksBlockCubit>(context),
      builder: (_, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile.adaptive(
              value: state.block.hasTitle,
              activeColor: Colors.white,
              onChanged: (value) =>
                  BlocProvider.of<BookmarksBlockCubit>(context)
                      .changeBlockTitleVisibility(value),
              title: Text(context.l10n.block_settings_bookmark_show_header),
            ),
            CheckboxListTile.adaptive(
              value: state.block.visibleFavicons,
              activeColor: Colors.white,
              onChanged: (value) =>
                  BlocProvider.of<BookmarksBlockCubit>(context)
                      .changeFaviconsVisibility(value),
              title: Text(context.l10n.block_settings_bookmark_show_favicons),
            ),
            const SizedBox(height: Insets.xs),
            _buildViewModeOption(),
          ],
        );
      },
    );
  }

  Widget _buildViewModeOption() {
    return Row(
      children: [
        const SizedBox(width: Insets.s),
        Text(context.l10n.block_settings_bookmark_block_view_mode,
            style: const TextStyle(fontSize: 16)),
        const Spacer(),
        _buildViewModeDrpodown(),
      ],
    );
  }

  Widget _buildViewModeDrpodown() {
    return DropdownButtonHideUnderline(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(Insets.xs),
        ),
        child: DropdownButton<BookmarkViewMode>(
          value: context.read<BookmarksBlockCubit>().state.block.viewMode,
          items: BookmarkViewMode.values
              .map(
                (viewMode) => DropdownMenuItem<BookmarkViewMode>(
                  value: viewMode,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Insets.s),
                    child: Text(
                      viewMode.translatedName(context),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) => context
              .read<BookmarksBlockCubit>()
              .changeBookmarksViewMode(value),
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }
}
