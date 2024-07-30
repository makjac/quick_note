import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';

class NotesSegentHeader extends StatelessWidget {
  const NotesSegentHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.m),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            letterSpacing: .8,
          ),
        ),
      ),
    );
  }
}
