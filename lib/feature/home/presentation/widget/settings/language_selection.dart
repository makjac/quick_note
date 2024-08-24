import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/app_language.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';

class LanguageSelection extends StatelessWidget {
  const LanguageSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.settings_language_title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: Insets.xs),
              Text(
                context.l10n.settings_language_subtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        DropdownButtonHideUnderline(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(Insets.xs),
            ),
            child: DropdownButton<AppLanguage>(
              value: context.read<PreferencesBloc>().state.language,
              items: AppLanguage.values
                  .map(
                    (language) => DropdownMenuItem<AppLanguage>(
                      value: language,
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: Insets.s),
                        child: Text(
                          _getLanguageName(context, language),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) => context.read<PreferencesBloc>().add(
                    PreferencesSetLanguage(
                        language: value ?? AppLanguage.english),
                  ),
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ],
    );
  }

  String _getLanguageName(BuildContext context, AppLanguage langauage) {
    switch (langauage) {
      case AppLanguage.english:
        return "🇬🇧 ${context.l10n.language_english}";
      case AppLanguage.polish:
        return "🇵🇱 ${context.l10n.language_polish}";
      case AppLanguage.german:
        return "🇩🇪 ${context.l10n.language_german}";
      case AppLanguage.spanish:
        return "🇪🇸 ${context.l10n.language_spanish}";
      case AppLanguage.portuguese:
        return "🇵🇹 ${context.l10n.language_portuguese}";
      case AppLanguage.french:
        return "🇫🇷 ${context.l10n.language_french}";
      case AppLanguage.russian:
        return "🇷🇺 ${context.l10n.language_russian}";
      case AppLanguage.hindi:
        return "🇮🇳 ${context.l10n.language_hindi}";
      case AppLanguage.chinese:
        return "🇨🇳 ${context.l10n.language_chinese}";
      case AppLanguage.arabic:
        return "🇸🇦 ${context.l10n.language_arabic}";
      case AppLanguage.czech:
        return "🇨🇿 ${context.l10n.language_czech}";
      case AppLanguage.hungarian:
        return "🇭🇺 ${context.l10n.language_hungarian}";
      case AppLanguage.indonesian:
        return "🇮🇩 ${context.l10n.language_indonesian}";
      case AppLanguage.italian:
        return "🇮🇹 ${context.l10n.language_italian}";
      case AppLanguage.japanese:
        return "🇯🇵 ${context.l10n.language_japanese}";
      case AppLanguage.korean:
        return "🇰🇷 ${context.l10n.language_korean}";
      case AppLanguage.ukrainian:
        return "🇺🇦 ${context.l10n.language_ukrainian}";
      case AppLanguage.vietnamese:
        return "🇻🇳 ${context.l10n.language_vietnamese}";
      default:
        return "🏳️";
    }
  }
}
