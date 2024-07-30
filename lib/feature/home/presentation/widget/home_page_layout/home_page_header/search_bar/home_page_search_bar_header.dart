import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_header/search_bar/home_page_note_search_text_field.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';

class HomePageSearchBarHeader extends StatelessWidget {
  const HomePageSearchBarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppConstans.mobileSize) {
      return const _MobileSearchBar();
    }
    return const _DesktopSearchbar();
  }
}

class _MobileSearchBar extends StatelessWidget {
  const _MobileSearchBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.s),
      child: Card(
        color: Theme.of(context).searchBarBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(Insets.xxs),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).searchBarForegroundColor,
                ),
              ),
              const Expanded(child: HomePageNoteSearchTextField()),
              CircleAvatar(
                radius: 15,
                backgroundColor:
                    Theme.of(context).mSearchBarUserBackgroundColor,
                child: FittedBox(
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).mSearchBarUserForegroundColor,
                  ),
                ),
              ),
              const SizedBox(width: Insets.xs),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopSearchbar extends StatelessWidget {
  const _DesktopSearchbar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.s),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              color: Theme.of(context).searchBarBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.xxs),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Insets.xl,
                      width: Insets.xl,
                      child: Icon(
                        Icons.search,
                        color: Theme.of(context).searchBarForegroundColor,
                      ),
                    ),
                    const Expanded(child: HomePageNoteSearchTextField()),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () => BlocProvider.of<AppBloc>(context).add(AppCreateNote()),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).searchBarBackgroundColor,
                borderRadius: BorderRadius.circular(Insets.xxl),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: Insets.s,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Theme.of(context).searchBarForegroundColor,
                  ),
                  const SizedBox(width: Insets.xs),
                  Text(
                    context.l10n.add_note,
                    style: TextStyle(
                      color: Theme.of(context).searchBarForegroundColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: .7,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: Insets.s),
          CircleAvatar(
            backgroundColor: Theme.of(context).searchBarBackgroundColor,
            child: Icon(
              Icons.person,
              color: Theme.of(context).searchBarForegroundColor,
            ),
          ),
        ],
      ),
    );
  }
}
