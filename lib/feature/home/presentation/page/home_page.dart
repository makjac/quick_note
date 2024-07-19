import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/app_constans.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/cubit/note_search_cubit.dart';
import 'package:quick_note/feature/home/presentation/page/archive_page.dart';
import 'package:quick_note/feature/home/presentation/page/help_page.dart';
import 'package:quick_note/feature/home/presentation/page/note_page.dart';
import 'package:quick_note/feature/home/presentation/page/note_search_page.dart';
import 'package:quick_note/feature/home/presentation/page/reminders_page.dart';
import 'package:quick_note/feature/home/presentation/page/settings_page.dart';
import 'package:quick_note/feature/home/presentation/page/trash_page.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_darwer.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_layout.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';
import 'package:quick_note/injection_container.dart';
import 'package:quick_note/router/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocProvider<NoteSearchCubit>(
      create: (context) => locator<NoteSearchCubit>(),
      child: Scaffold(
        backgroundColor: Colors.grey[850],
        drawer: const HomePageDarwer(),
        body: const SafeArea(
          child: HomePageLayout(
            child: _HomePageBuilder(),
          ),
        ),
        floatingActionButton: width < AppConstans.mobileSize
            ? FloatingActionButton.extended(
                onPressed: () => _addNote(context),
                backgroundColor: Colors.grey[900],
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add),
                label: const Text("Add note"),
              )
            : null,
      ),
    );
  }

  void _addNote(BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(
      AppCreateNote(
        note: Note(
          id: DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF,
          created: DateTime.now(),
          modified: DateTime.now(),
          colorHex: "fe653a",
          title:
              (DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF).toString(),
        ),
      ),
    );
  }
}

class _HomePageBuilder extends StatelessWidget {
  const _HomePageBuilder();

  @override
  Widget build(BuildContext context) {
    final currentRouteName = GoRouterState.of(context).topRoute?.path;
    final currentRoute = AppRoutes.values.firstWhere(
      (value) => value.path == currentRouteName,
      orElse: () => AppRoutes.notesPage,
    );

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
