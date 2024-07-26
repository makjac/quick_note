import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/color.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';

class NoteHelper {
  static Future<NoteColors?> showNoteColorPickerDialog(BuildContext context) {
    return showDialog<NoteColors>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[800],
          child: Padding(
            padding: const EdgeInsets.all(Insets.s),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3.1,
                child: GridView.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: Insets.xs,
                  mainAxisSpacing: Insets.xs,
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  children: [
                    _buildColorTile(NoteColors.color1, context),
                    _buildColorTile(NoteColors.color2, context),
                    _buildColorTile(NoteColors.color3, context),
                    _buildColorTile(NoteColors.color4, context),
                    _buildColorTile(NoteColors.color5, context),
                    _buildColorTile(NoteColors.color6, context),
                    _buildColorTile(NoteColors.color7, context),
                    _buildColorTile(NoteColors.color8, context),
                    _buildColorTile(NoteColors.color9, context),
                    _buildColorTile(NoteColors.color10, context),
                    _buildColorTile(NoteColors.color11, context),
                    _buildColorTile(NoteColors.color12, context),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildColorTile(NoteColors color, BuildContext context) {
    final displayColor =
        color.color(context.read<PreferencesBloc>().state.theme);

    return GestureDetector(
      onTap: () {
        Navigator.pop(context, color);
      },
      child: Container(
        decoration: BoxDecoration(
          color: displayColor,
          borderRadius: const BorderRadius.all(Radius.circular(1000)),
          border:
              Border.all(color: displayColor.changeBrightness(.22), width: 3),
        ),
      ),
    );
  }
}
