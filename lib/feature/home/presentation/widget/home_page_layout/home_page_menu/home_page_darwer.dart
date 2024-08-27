import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/app_assets.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/router/app_routes.dart';

class HomePageDarwer extends StatelessWidget {
  const HomePageDarwer({super.key});

  bool _isSelected(BuildContext context, AppRoutes route) {
    final currentRouteName = GoRouterState.of(context).topRoute?.path;
    final currentRoute = AppRoutes.values.firstWhere(
      (value) => value.path == currentRouteName,
      orElse: () => AppRoutes.notesPage,
    );

    return currentRoute == route;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                _drawerHeader(context),
                _menuOption(
                  leading: const Icon(Icons.notes_rounded),
                  title: Text(context.l10n.menu_notes),
                  selected: _isSelected(context, AppRoutes.notesPage),
                  onTap: () => context.pushNamed(AppRoutes.notesPage.name),
                ),
                _menuOption(
                  leading: const Icon(Icons.archive),
                  title: Text(context.l10n.menu_archive),
                  selected: _isSelected(context, AppRoutes.archivePage),
                  onTap: () => context.pushNamed(AppRoutes.archivePage.name),
                ),
                _menuOption(
                  leading: const Icon(Icons.delete),
                  title: Text(context.l10n.menu_trash),
                  selected: _isSelected(context, AppRoutes.trashPage),
                  onTap: () => context.pushNamed(AppRoutes.trashPage.name),
                ),
                const Divider(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Divider(),
                  _menuOption(
                    leading: const Icon(Icons.settings),
                    title: Text(context.l10n.menu_settings),
                    selected: _isSelected(context, AppRoutes.settingsPage),
                    onTap: () => context.pushNamed(AppRoutes.settingsPage.name),
                  ),
                  _menuOption(
                    leading: const Icon(Icons.help),
                    title: Text(context.l10n.menu_help),
                    selected: _isSelected(context, AppRoutes.helpPage),
                    onTap: () => context.pushNamed(AppRoutes.helpPage.name),
                  ),
                  const SizedBox(height: Insets.s)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuOption({
    Widget? leading,
    Widget? title,
    bool selected = false,
    void Function()? onTap,
  }) {
    return Ink(
      color: selected ? Colors.white10 : Colors.transparent,
      child: ListTile(
        leading: leading,
        title: title,
        onTap: onTap,
      ),
    );
  }

  Widget _drawerHeader(BuildContext context) {
    return SizedBox(
      height: 120,
      child: DrawerHeader(
        padding: const EdgeInsets.all(Insets.s),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.logoBoxSVG,
              width: 65,
            ),
            const SizedBox(width: Insets.s),
            Text(
              context.l10n.appName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
