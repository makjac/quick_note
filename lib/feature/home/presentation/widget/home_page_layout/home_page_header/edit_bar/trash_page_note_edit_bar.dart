import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

enum _EditOption { restore, deleteForever }

class TrashPageNoteEditBar extends StatelessWidget {
  const TrashPageNoteEditBar({super.key});

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
            value: _EditOption.restore,
            child: _buildPopupMenuItem(
                context.l10n.note_settings_restore, Icons.arrow_upward),
            onTap: () => appBloc.add(AppRestoreSelectedNotes()),
          ),
          PopupMenuItem<_EditOption>(
            value: _EditOption.deleteForever,
            child: _buildPopupMenuItem(
                context.l10n.note_settings_delete_forever,
                Icons.delete_forever),
            onTap: () => appBloc.add(AppDeleteSelectedNotes()),
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
        _RestoreButton(appBloc: appBloc),
        const SizedBox(width: Insets.xxs),
        _DeleteButton(appBloc: appBloc),
      ],
    );
  }
}

class _CloseButton extends StatelessWidget {
  const _CloseButton({required this.appBloc});

  final AppBloc appBloc;

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

class _RestoreButton extends StatelessWidget {
  const _RestoreButton({required this.appBloc});

  final AppBloc appBloc;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => appBloc.add(AppRestoreSelectedNotes()),
      icon: Tooltip(
        message: context.l10n.note_settings_restore,
        child: Icon(
          Icons.arrow_upward,
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
      onPressed: () => appBloc.add(AppDeleteSelectedNotes()),
      icon: Tooltip(
        message: context.l10n.note_settings_delete_forever,
        child: Icon(
          Icons.delete_forever_outlined,
          color: Theme.of(context).editHeaderForegroundColor?.withAlpha(200),
        ),
      ),
    );
  }
}
