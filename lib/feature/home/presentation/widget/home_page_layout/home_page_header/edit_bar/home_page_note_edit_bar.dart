import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

enum _EditOption { color, star, archive, delete }

class HomePageNoteEditBar extends StatelessWidget {
  const HomePageNoteEditBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final appBloc = BlocProvider.of<AppBloc>(context);

        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).editHeaderDividerColor,
              ),
            ),
          ),
          padding: const EdgeInsets.all(Insets.s),
          margin: const EdgeInsets.only(bottom: 15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _CloseButton(appBloc: appBloc),
              if (AppConstans.mobileSize < width)
                const SizedBox(width: Insets.s),
              _SelectedNotesCount(count: state.selectedNoteIds.length),
              const Spacer(),
              if (AppConstans.mobileSize < width) const _DesktopEditButtons(),
              if (width < AppConstans.mobileSize) _MobileEditButtons(context),
            ],
          ),
        );
      },
    );
  }
}

class _MobileEditButtons extends StatelessWidget {
  const _MobileEditButtons(this.context);

  final BuildContext context;

  @override
  Widget build(context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return PopupMenuButton<_EditOption>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) {
        return [
          PopupMenuItem<_EditOption>(
            value: _EditOption.color,
            child: _buildPopupMenuItem(
                context.l10n.note_settings_color, Icons.color_lens_outlined),
            onTap: () async {
              final color = await NoteHelper.showNoteColorPickerDialog(context);
              if (color != null) {
                appBloc.add(
                    AppUpdateSelectedNotes(updates: NoteUpdates(color: color)));
              }
            },
          ),
          PopupMenuItem<_EditOption>(
            value: _EditOption.star,
            child: _buildPopupMenuItem(
                context.l10n.note_settings_star, Icons.star_border_outlined),
            onTap: () => appBloc.add(AppStarSelectedNotes()),
          ),
          PopupMenuItem<_EditOption>(
            value: _EditOption.archive,
            child: _buildPopupMenuItem(
                context.l10n.note_settings_archive, Icons.archive_outlined),
            onTap: () => appBloc.add(AppArchiveSelectedNotes()),
          ),
          PopupMenuItem<_EditOption>(
            value: _EditOption.delete,
            child: _buildPopupMenuItem(
                context.l10n.note_settings_delete, Icons.delete_outline),
            onTap: () => appBloc.add(AppMoveSelectedNotesToTrash()),
          ),
        ];
      },
    );
  }

  Widget _buildPopupMenuItem(String title, IconData iconData) {
    return Row(
      children: [
        Icon(iconData),
        const SizedBox(width: Insets.xs),
        Text(title),
      ],
    );
  }
}

class _DesktopEditButtons extends StatelessWidget {
  const _DesktopEditButtons();

  @override
  Widget build(BuildContext context) {
    final appBloc = BlocProvider.of<AppBloc>(context);
    return Row(
      children: [
        _ColorPickerButton(appBloc: appBloc),
        const SizedBox(width: Insets.xxs),
        _StarButton(appBloc: appBloc),
        const SizedBox(width: Insets.xxs),
        _ArchivedButton(appBloc: appBloc),
        const SizedBox(width: Insets.xxs),
        _DeleteButton(appBloc: appBloc),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  final AppBloc appBloc;

  const _CloseButton({required this.appBloc});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => appBloc.add(AppUnselectAllNotes()),
      icon: Icon(
        Icons.close,
        color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
      ),
    );
  }
}

class _SelectedNotesCount extends StatelessWidget {
  final int count;

  const _SelectedNotesCount({required this.count});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Insets.xxs),
      child: Text(
        "$count Selected",
        style: TextStyle(
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(255),
          fontWeight: FontWeight.w400,
          letterSpacing: .4,
          fontSize: 20,
        ),
      ),
    );
  }
}

class _ColorPickerButton extends StatelessWidget {
  final AppBloc appBloc;

  const _ColorPickerButton({required this.appBloc});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final color = await NoteHelper.showNoteColorPickerDialog(context);
        if (color != null) {
          appBloc
              .add(AppUpdateSelectedNotes(updates: NoteUpdates(color: color)));
        }
      },
      icon: Tooltip(
        message: context.l10n.note_settings_color,
        child: Icon(
          Icons.color_lens_outlined,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}

class _StarButton extends StatelessWidget {
  final AppBloc appBloc;

  const _StarButton({required this.appBloc});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => appBloc.add(AppStarSelectedNotes()),
      icon: Tooltip(
        message: context.l10n.note_settings_star,
        child: Icon(
          Icons.star_border,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}

class _ArchivedButton extends StatelessWidget {
  const _ArchivedButton({required this.appBloc});

  final AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => appBloc.add(AppArchiveSelectedNotes()),
      icon: Tooltip(
        message: context.l10n.note_settings_archive,
        child: Icon(
          Icons.archive_outlined,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final AppBloc appBloc;

  const _DeleteButton({required this.appBloc});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => appBloc.add(AppMoveSelectedNotesToTrash()),
      icon: Tooltip(
        message: context.l10n.note_settings_delete,
        child: Icon(
          Icons.delete_outline,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}
