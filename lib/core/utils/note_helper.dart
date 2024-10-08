import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/color.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note_colors.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class NoteHelper {
  static Future<NoteColors?> showNoteColorPickerDialog(BuildContext context) {
    return showDialog<NoteColors>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Theme.of(context).changeNoteColorPopupBacgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(Insets.s),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              child: AspectRatio(
                aspectRatio: 4 / 3.1,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: Insets.xs,
                    mainAxisSpacing: Insets.xs,
                  ),
                  itemCount: NoteColors.values.length,
                  itemBuilder: (context, index) {
                    return _buildColorTile(NoteColors.values[index], context);
                  },
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

    Color setupBorderColor() {
      final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

      if (isDarkTheme) {
        return displayColor.changeBrightness(.22);
      } else {
        return displayColor.changeBrightness(-.35).withAlpha(150);
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.pop(context, color);
      },
      child: Container(
        decoration: BoxDecoration(
          color: displayColor,
          borderRadius: const BorderRadius.all(Radius.circular(1000)),
          border: Border.all(
            color: setupBorderColor(),
            width: 3,
          ),
        ),
      ),
    );
  }
}
