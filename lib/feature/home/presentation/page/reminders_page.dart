import 'package:flutter/material.dart';
import 'package:quick_note/l10n/l10n.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(context.l10n.menu_reminders),
    );
  }
}
