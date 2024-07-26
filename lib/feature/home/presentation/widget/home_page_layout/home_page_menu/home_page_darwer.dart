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
            title: const Text('Notes'),
            onTap: () => context.pushNamed(AppRoutes.notesPage.name),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.notifications),
            title: const Text('Reminders'),
            onTap: () => context.pushNamed(AppRoutes.remindersPage.name),
          ),
          const Divider(),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.archive),
            title: const Text('Archive'),
            onTap: () => context.pushNamed(AppRoutes.archivePage.name),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.delete),
            title: const Text('Bin'),
            onTap: () => context.pushNamed(AppRoutes.trashPage.name),
          ),
          const Divider(),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => context.pushNamed(AppRoutes.settingsPage.name),
          ),
          ListTile(
            iconColor: Colors.white,
            textColor: Colors.white,
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () => context.pushNamed(AppRoutes.helpPage.name),
          ),
          const SizedBox(height: Insets.s)
        ],
      ),
    );
  }
}
