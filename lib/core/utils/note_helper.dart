import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/color.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';

class NoteHelper {
  static Future<Color?> showNoteColorPickerDialog(BuildContext context) {
    return showDialog<Color>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[800],
          child: GridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: Insets.xs,
            mainAxisSpacing: Insets.xs,
            padding: const EdgeInsets.all(8.0),
            shrinkWrap: true,
            children: [
              _buildColorTile(HexColor.fromHex("#262626"), context),
              _buildColorTile(HexColor.fromHex("#595959"), context),
              _buildColorTile(HexColor.fromHex("#663535"), context),
              _buildColorTile(HexColor.fromHex("#665135"), context),
              _buildColorTile(HexColor.fromHex("#646635"), context),
              _buildColorTile(HexColor.fromHex("#3c6635"), context),
              _buildColorTile(HexColor.fromHex("#35664e"), context),
              _buildColorTile(HexColor.fromHex("#355f66"), context),
              _buildColorTile(HexColor.fromHex("#354566"), context),
              _buildColorTile(HexColor.fromHex("#403566"), context),
              _buildColorTile(HexColor.fromHex("#5f3566"), context),
              _buildColorTile(HexColor.fromHex("#663547"), context),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildColorTile(Color color, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, color);
      },
      child: SizedBox(
        child: CircleAvatar(
          backgroundColor: color.changeBrightness(.22),
          maxRadius: 30,
          child: CircleAvatar(
            radius: 28.5,
            backgroundColor: Colors.grey[800],
            child: CircleAvatar(
              backgroundColor: color,
              radius: 25,
            ),
          ),
        ),
      ),
    );
  }
}