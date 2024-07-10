import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/core/extension/color/color.dart';
import 'package:quick_note/core/extension/color/hex_color.dart';
import 'package:quick_note/feature/home/presentation/widget/note_tile_preview/note_tile_preview_builder.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/router/app_routes.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.notebook.path, extra: note),
      child: Container(
        decoration: _noteTailDecoratioon(),
        padding: const EdgeInsets.all(Insets.s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _noteTitle(),
            _noteContent(),
          ],
        ),
      ),
    );
  }

  BoxDecoration _noteTailDecoratioon() {
    final Color noteColor = HexColor.fromHex(note.colorHex);

    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          noteColor.changeBrightness(0.07),
          noteColor,
          noteColor,
          noteColor.changeBrightness(-0.12),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: const [
        BoxShadow(
          blurRadius: 3,
          color: Colors.black54,
          offset: Offset(2, 2),
        )
      ],
      borderRadius: const BorderRadius.all(
        Radius.circular(Insets.xxs),
      ),
      border: Border.all(
        color: Colors.black.withAlpha(150),
      ),
    );
  }

  Widget _noteTitle() => Text(
        note.title,
        maxLines: 2,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
        ),
      );

  Widget _noteContent() {
    if ((note.content ?? []).isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: Insets.xs),
      child: NoteTilePreviewBuilder(noteBlock: note.content?.first),
    );
  }
}
