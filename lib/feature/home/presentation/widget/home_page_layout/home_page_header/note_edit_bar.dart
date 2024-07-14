import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';
import 'package:quick_note/core/utils/note_helper.dart';
import 'package:quick_note/feature/home/domain/usecase/update_multiple_notes_usecase.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';

class NoteEditBar extends StatelessWidget {
  const NoteEditBar({super.key});

  @override
  Widget build(BuildContext context) {
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
              const SizedBox(width: Insets.s),
              _SelectedNotesCount(count: state.selectedNoteIds.length),
              const Spacer(),
              _ColorPickerButton(appBloc: appBloc),
              const SizedBox(width: Insets.xxs),
              _StarButton(appBloc: appBloc),
              const SizedBox(width: Insets.xxs),
              _ArchivedButton(appBloc: appBloc),
              const SizedBox(width: Insets.xxs),
              _DeleteButton(appBloc: appBloc),
            ],
          ),
        );
      },
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
      onPressed: () => appBloc.add(UnselectAllNotes()),
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
          appBloc.add(UpdateSelectedNotes(
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
      onPressed: () => appBloc.add(StarSelectedNotes()),
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
      onPressed: () => appBloc.add(ArchiveSelectedNotes()),
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
      onPressed: () => appBloc.add(DeleteSelectedNotes()),
      icon: Icon(
        Icons.delete_outline,
        color: Colors.white.withAlpha(200),
      ),
    );
  }
}
