import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';

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
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white30,
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
      color: Colors.grey[900],
      itemBuilder: (context) {
        return [
          PopupMenuItem<_EditOption>(
            value: _EditOption.color,
            child:
                _buildPopupMenuItem("Change color", Icons.color_lens_outlined),
            onTap: () async {
              final color = await NoteHelper.showNoteColorPickerDialog(context);
              if (color != null) {
                appBloc.add(AppUpdateSelectedNotes(
                    updates: NoteUpdates(colorHex: color.toHex())));
              }
            },
          ),
          PopupMenuItem<_EditOption>(
            value: _EditOption.star,
            child: _buildPopupMenuItem("Star", Icons.star_border_outlined),
            onTap: () => appBloc.add(AppStarSelectedNotes()),
          ),
          PopupMenuItem<_EditOption>(
            value: _EditOption.archive,
            child: _buildPopupMenuItem("Archive", Icons.archive_outlined),
            onTap: () => appBloc.add(AppArchiveSelectedNotes()),
          ),
          PopupMenuItem<_EditOption>(
            value: _EditOption.delete,
            child: _buildPopupMenuItem("Delete", Icons.delete_outline),
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
      hoverColor: Colors.white12,
      onPressed: () => appBloc.add(AppUnselectAllNotes()),
      icon: const Icon(
        Icons.close,
        color: Colors.white70,
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
        style: const TextStyle(
          color: Colors.white,
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
          appBloc.add(AppUpdateSelectedNotes(
              updates: NoteUpdates(colorHex: color.toHex())));
        }
      },
      icon: Icon(
        Icons.color_lens_outlined,
        color: Colors.white.withAlpha(200),
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
      icon: Icon(
        Icons.star_border,
        color: Colors.white.withAlpha(200),
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
      icon: Icon(
        Icons.archive_outlined,
        color: Colors.white.withAlpha(200),
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
      icon: Icon(
        Icons.delete_outline,
        color: Colors.white.withAlpha(200),
      ),
    );
  }
}
