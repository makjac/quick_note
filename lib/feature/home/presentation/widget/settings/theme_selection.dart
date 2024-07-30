import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.settings_theme_title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: Insets.xs),
            Text(
              context.l10n.settings_theme_subtitle,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        DropdownButtonHideUnderline(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(Insets.xs),
            ),
            child: DropdownButton<AppTheme>(
              value: context.read<PreferencesBloc>().state.theme,
              items: AppTheme.values
                  .map(
                    (theme) => DropdownMenuItem<AppTheme>(
                      value: theme,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Insets.s),
                        child: Text(
                          _getThemeName(context, theme),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) => context.read<PreferencesBloc>().add(
                    PreferencesSetTheme(theme: value ?? AppTheme.dark),
                  ),
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ],
    );
  }

  String _getThemeName(BuildContext context, AppTheme theme) {
    switch (theme) {
      case AppTheme.dark:
        return context.l10n.theme_dark;
      case AppTheme.light:
        return context.l10n.theme_light;
      default:
        return "";
    }
  }
}
