import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/l10n.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.settings_preferences_title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: Insets.xs),
        Text(
          context.l10n.settings_preferences_subtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
