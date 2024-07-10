import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/feature/home/presentation/page/home_page.dart';
import 'package:quick_note/feature/notebook/presentation/page/notebook_page.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/router/app_routes.dart';

class AppRouter extends Equatable {
  static final GoRouter router = GoRouter(
    routes: _routes,
  );

  static final List<RouteBase> _routes = [
    _buildRoute(AppRoutes.homePage, const HomePage()),
    GoRoute(
      path: AppRoutes.notebook.path,
      name: AppRoutes.notebook.name,
      builder: (context, state) => NotebookPage(
        note: state.extra as Note?,
      ),
    )
  ];

  static GoRoute _buildRoute(AppRoutes appRoute, Widget screen) {
    return GoRoute(
      path: appRoute.path,
      name: appRoute.routeName,
      builder: (context, state) => screen,
    );
  }

  @override
  List<Object?> get props => [];
}
