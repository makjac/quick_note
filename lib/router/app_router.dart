import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/page/home_page.dart';
import 'package:quick_note/feature/notebook/presentation/page/notebook_page.dart';
import 'package:quick_note/router/app_routes.dart';

class AppRouter extends Equatable {
  static final GoRouter router = GoRouter(
    routes: _routes,
  );

  static final List<RouteBase> _routes = [
    GoRoute(
      path: AppRoutes.homePage.path,
      name: AppRoutes.homePage.name,
      builder: (context, state) {
        BlocProvider.of<AppBloc>(context).add(LoadCachedNotes());
        return const HomePage();
      },
    ),
    GoRoute(
      path: AppRoutes.notebook.path,
      name: AppRoutes.notebook.name,
      builder: (context, state) => NotebookPage(
        noteId: num.tryParse(state.pathParameters["id"] ?? ""),
      ),
    )
  ];

  @override
  List<Object?> get props => [];
}
