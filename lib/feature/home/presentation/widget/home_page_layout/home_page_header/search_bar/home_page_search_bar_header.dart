import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/feature/home/presentation/bloc/app_bloc.dart';
import 'package:quick_note/feature/home/presentation/widget/home_page_layout/home_page_header/search_bar/home_page_note_search_text_field.dart';
import 'package:quick_note/feature/shared/domain/entity/note/note.dart';

class HomePageSearchBarHeader extends StatelessWidget {
  const HomePageSearchBarHeader({super.key, required this.mobileSize});

  final double mobileSize;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileSize) {
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
        color: Colors.grey[900],
        child: Padding(
          padding: const EdgeInsets.all(Insets.xxs),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Icons.menu,
                  color: Colors.white.withAlpha(180),
                ),
              ),
              const Expanded(child: HomePageNoteSearchTextField()),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.white70,
                child: FittedBox(
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[900],
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

  void _addNote(BuildContext context) {
    BlocProvider.of<AppBloc>(context).add(AppCreateNote(
        note: Note(
      id: DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF,
      created: DateTime.now(),
      modified: DateTime.now(),
      colorHex: "fe653a",
      title: (DateTime.now().millisecondsSinceEpoch % 0xFFFFFFFF).toString(),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Insets.s),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              color: Colors.grey[900],
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
                        color: Colors.white.withAlpha(180),
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
            onTap: () => _addNote(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(Insets.xxl),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: Insets.s,
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white70,
                  ),
                  SizedBox(width: Insets.xs),
                  Text(
                    "Add note",
                    style: TextStyle(
                      color: Colors.white70,
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
            backgroundColor: Colors.grey[900],
            child: const Icon(
              Icons.person,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
