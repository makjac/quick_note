import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/core/service/analytics/service/analytics_service.dart';
import 'package:quick_note/core/utils/platform_helper.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/cubit/note_search_cubit.dart';
import 'package:quick_note/feature/home/presentation/page/archive_page.dart';
import 'package:quick_note/feature/home/presentation/page/help_page.dart';
import 'package:quick_note/feature/home/presentation/page/note_page.dart';
import 'package:quick_note/feature/home/presentation/page/note_search_page.dart';
import 'package:quick_note/feature/home/presentation/page/reminders_page.dart';
import 'package:quick_note/feature/home/presentation/page/settings_page.dart';
import 'package:quick_note/feature/home/presentation/page/trash_page.dart';
import 'package:quick_note/feature/home/presentation/widget/bottom_navigation_bar/home_page_ad_banner.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_menu/home_page_darwer.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_layout.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/preferences/theme/app_custom_colors.dart';
import 'package:quick_note/router/app_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFabVisible = true;
  Timer? _fabVisibilityTimer;

  @override
  void initState() {
    _fabVisibilityTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider<NoteSearchCubit>(
      create: (context) => locator<NoteSearchCubit>(),
      child: Scaffold(
        drawer: const HomePageDarwer(),
        body: SafeArea(
          child: NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is UserScrollNotification) {
                setState(() {
                  if (scrollNotification.direction == ScrollDirection.forward) {
                    _isFabVisible = true;
                  } else if (scrollNotification.direction ==
                      ScrollDirection.reverse) {
                    _isFabVisible = false;
                    _fabVisibilityTimer?.cancel();
                    _fabVisibilityTimer = Timer(const Duration(seconds: 1), () {
                      if (mounted) {
                        setState(() {
                          _isFabVisible = true;
                        });
                      }
                    });
                  }
                });
              }
              return true;
            },
            child: HomePageLayout(
              isTrash: _isTrashPage(context),
              child: _HomePageBuilder(
                currentRoute: _getCurrentRoute(context),
              ),
            ),
          ),
        ),
        floatingActionButton: width < AppConstans.mobileSize && _isFabVisible
            ? FloatingActionButton(
                onPressed: () {
                  if (PlatformHelper.isMobile()) {
                    locator<AnalyticsService>().logCreateNoteEvent();
                  }
                  BlocProvider.of<AppBloc>(context).add(AppCreateNote());
                },
                backgroundColor:
                    Theme.of(context).floatingAcrionButtonBackgroundColor,
                foregroundColor:
                    Theme.of(context).floatingAcrionButtonForegroundColor,
                child: const Icon(Icons.add),
              )
            : null,
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  AppRoutes _getCurrentRoute(BuildContext context) {
    final currentRouteName = GoRouterState.of(context).topRoute?.path;
    final currentRoute = AppRoutes.values.firstWhere(
      (value) => value.path == currentRouteName,
      orElse: () => AppRoutes.notesPage,
    );

    return currentRoute;
  }

  bool _isTrashPage(BuildContext context) {
    final currentRoute = _getCurrentRoute(context);

    return currentRoute == AppRoutes.trashPage;
  }

  Widget? _buildBottomNavigationBar() {
    if (PlatformHelper.isMobile()) {
      return const HomePageAdBanner();
    }
    return null;
  }
}

class _HomePageBuilder extends StatelessWidget {
  const _HomePageBuilder({required this.currentRoute});

  final AppRoutes currentRoute;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteSearchCubit, NoteSearchState>(
      builder: (context, state) {
        if (state.searchTerm.isNotEmpty) return const NoteSearchPage();
        return _buildPage(currentRoute);
      },
    );
  }

  Widget _buildPage(AppRoutes route) {
    final pageMap = {
      AppRoutes.notesPage: const NotePage(),
      AppRoutes.remindersPage: const RemindersPage(),
      AppRoutes.archivePage: const ArchivePage(),
      AppRoutes.trashPage: const TrashPage(),
      AppRoutes.settingsPage: const SettingsPage(),
      AppRoutes.helpPage: const HelpPage(),
    };

    return pageMap[route] ?? const NotePage();
  }
}
