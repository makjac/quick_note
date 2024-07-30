import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/page/home_page.dart';
import 'package:quick_note/feature/home/presentation/widget/settings/licence_info_view.dart';
import 'package:quick_note/feature/notebook/presentation/page/notebook_page.dart';
import 'package:quick_note/router/app_routes.dart';

class AppRouter extends Equatable {
  static final GoRouter router = GoRouter(
      routes: _routes, initialLocation: '/${AppRoutes.notesPage.path}');

  static final List<RouteBase> _routes = [
    GoRoute(
      path: AppRoutes.homePage.path,
      name: AppRoutes.homePage.name,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomePage()),
      builder: (context, state) {
        BlocProvider.of<AppBloc>(context).add(AppLoadCachedNotes());
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: AppRoutes.notesPage.path,
          name: AppRoutes.notesPage.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
          builder: (context, state) {
            BlocProvider.of<AppBloc>(context).add(AppLoadCachedNotes());
            return const HomePage();
          },
        ),
        GoRoute(
          path: AppRoutes.remindersPage.path,
          name: AppRoutes.remindersPage.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
          builder: (context, state) {
            BlocProvider.of<AppBloc>(context).add(AppLoadCachedNotes());
            return const HomePage();
          },
        ),
        GoRoute(
          path: AppRoutes.archivePage.path,
          name: AppRoutes.archivePage.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
          builder: (context, state) {
            BlocProvider.of<AppBloc>(context).add(AppLoadCachedNotes());
            return const HomePage();
          },
        ),
        GoRoute(
          path: AppRoutes.trashPage.path,
          name: AppRoutes.trashPage.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
          builder: (context, state) {
            BlocProvider.of<AppBloc>(context).add(AppLoadCachedNotes());
            return const HomePage();
          },
        ),
        GoRoute(
          path: AppRoutes.settingsPage.path,
          name: AppRoutes.settingsPage.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: AppRoutes.helpPage.path,
          name: AppRoutes.helpPage.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: HomePage()),
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: AppRoutes.license.path,
              name: AppRoutes.license.name,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: LicenceInfoView()),
              builder: (context, state) => const LicenceInfoView(),
            )
          ],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.notebook.path,
      name: AppRoutes.notebook.name,
      onExit: (context, state) {
        BlocProvider.of<AppBloc>(context).add(AppLoadCachedNotes());
        return true;
      },
      pageBuilder: (context, state) => MaterialPage<void>(
        key: UniqueKey(),
        child: NotebookPage(
          noteId: num.tryParse(state.pathParameters["id"] ?? ""),
        ),
      ),
      routes: [
        GoRoute(
          path: AppRoutes.notebookReorderBlocks.path,
          name: AppRoutes.notebookReorderBlocks.name,
          builder: (context, state) => NotebookPage(
            noteId: num.tryParse(state.pathParameters["id"] ?? ""),
          ),
        )
      ],
    ),
  ];

  @override
  List<Object?> get props => [];
}
