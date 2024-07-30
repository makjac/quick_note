import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/app_assets.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/router/app_routes.dart';

class HomePageDarwer extends StatelessWidget {
  const HomePageDarwer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              padding: const EdgeInsets.all(Insets.s),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppAssets.logoRectangle,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: Insets.s),
                  Text(
                    context.l10n.appName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                      letterSpacing: 1,
                      shadows: [BoxShadow(blurRadius: .5)],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.notes_rounded),
            title: Text(context.l10n.menu_notes),
            onTap: () => context.pushNamed(AppRoutes.notesPage.name),
          ),
          // ListTile(
          //   iconColor: Colors.white,
          //   textColor: Colors.white,
          //   leading: const Icon(Icons.notifications),
          //   title: Text(context.l10n.menu_reminders),
          //   onTap: () => context.pushNamed(AppRoutes.remindersPage.name),
          // ),
          // const Divider(),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.archive),
            title: Text(context.l10n.menu_archive),
            onTap: () => context.pushNamed(AppRoutes.archivePage.name),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.delete),
            title: Text(context.l10n.menu_trash),
            onTap: () => context.pushNamed(AppRoutes.trashPage.name),
          ),
          const Divider(),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.settings),
            title: Text(context.l10n.menu_settings),
            onTap: () => context.pushNamed(AppRoutes.settingsPage.name),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.help),
            title: Text(context.l10n.menu_help),
            onTap: () => context.pushNamed(AppRoutes.helpPage.name),
          ),
          const SizedBox(height: Insets.s)
        ],
      ),
    );
  }
}
