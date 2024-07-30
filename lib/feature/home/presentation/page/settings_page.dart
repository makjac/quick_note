import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/widget/settings/header_section.dart';
import 'package:quick_note/feature/home/presentation/widget/settings/language_selection.dart';
import 'package:quick_note/feature/home/presentation/widget/settings/theme_selection.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(Insets.s),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderSection(),
          Divider(height: Insets.xxl),
          LanguageSelection(),
          Divider(height: Insets.xl),
          ThemeSelection(),
          Divider(height: Insets.xl),
        ],
      ),
    );
  }
}
