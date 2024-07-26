import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/app_language.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';
import 'package:quick_note/preferences/theme/app_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.s),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Settings",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: Insets.xs),
              Text(
                "Manage app preferences",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          const Divider(height: Insets.xxl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Language",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: Insets.xs),
                  Text(
                    "Select app Language",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              DropdownButton<AppLanguage>(
                value: context.read<PreferencesBloc>().state.language,
                items: AppLanguage.values
                    .map(
                      (language) => DropdownMenuItem<AppLanguage>(
                        value: language,
                        child: Text(language.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) => context.read<PreferencesBloc>().add(
                      PreferencesSetLanguage(
                          language: value ?? AppLanguage.english),
                    ),
              ),
            ],
          ),
          const Divider(height: Insets.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Theme",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: Insets.xs),
                  Text(
                    "Select app theme",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              DropdownButton<AppTheme>(
                value: context.read<PreferencesBloc>().state.theme,
                items: AppTheme.values
                    .map(
                      (theme) => DropdownMenuItem<AppTheme>(
                        value: theme,
                        child: Text(theme.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) => context.read<PreferencesBloc>().add(
                      PreferencesSetTheme(theme: value ?? AppTheme.dark),
                    ),
              ),
            ],
          ),
          const Divider(height: Insets.xl),
        ],
      ),
    );
  }
}
