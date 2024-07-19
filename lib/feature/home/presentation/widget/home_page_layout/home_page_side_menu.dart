import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_note/core/constans/app_assets.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/l10n.dart';
import 'package:quick_note/preferences/bloc/preferences.bloc.dart';
import 'package:quick_note/router/app_routes.dart';

class HomePageSideMenu extends StatefulWidget {
  const HomePageSideMenu({super.key});

  @override
  State<HomePageSideMenu> createState() => _HomePageSideMenuState();
}

class _HomePageSideMenuState extends State<HomePageSideMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _slideAnimation;
  late bool isCollapsed;

  @override
  void initState() {
    super.initState();
    isCollapsed =
        BlocProvider.of<PreferencesBloc>(context).state.sideMenuCollapsed;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _widthAnimation = Tween<double>(begin: 92, end: 270).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    if (isCollapsed) {
      _controller.value = 1.0;
    } else {
      _controller.value = 0.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      isCollapsed = !isCollapsed;
      BlocProvider.of<PreferencesBloc>(context)
          .add(PreferencesSetSideMenuCollapse(collapsed: isCollapsed));

      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SizedBox(
          width: _widthAnimation.value,
          child: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                boxShadow: const [BoxShadow(blurRadius: 2, spreadRadius: .5)],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxHeight > 416.0) {
                    return Column(
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: Insets.xs),
                        ..._buildMenuItems(context),
                        const Spacer(),
                        _buildFooter(context),
                        const SizedBox(height: Insets.s),
                      ],
                    );
                  }
                  return ListView(
                    children: [
                      _buildHeader(context),
                      const SizedBox(height: Insets.xs),
                      ..._buildMenuItems(context),
                      _buildFooter(context),
                      const SizedBox(height: Insets.s),
                    ],
                  );
                },
              )),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return InkWell(
      onTap: _toggleExpand,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.all(Radius.circular(Insets.xs)),
            ),
            height: 60,
            width: 60,
            margin: const EdgeInsets.symmetric(
              horizontal: Insets.s,
              vertical: Insets.s,
            ),
            padding: const EdgeInsets.all(Insets.xxs),
            child: Image.asset(
              AppAssets.logo,
              fit: BoxFit.contain,
            ),
          ),
          AnimatedOpacity(
            opacity: _opacityAnimation.value,
            duration: const Duration(milliseconds: 150),
            child: SizeTransition(
              sizeFactor: _slideAnimation,
              axis: Axis.horizontal,
              axisAlignment: 1,
              child: Text(
                context.l10n.appName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 1,
                  shadows: [BoxShadow(blurRadius: .5)],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSelected(AppRoutes route) {
    final currentRouteName = GoRouterState.of(context).topRoute?.path;
    final currentRoute = AppRoutes.values.firstWhere(
      (value) => value.path == currentRouteName,
      orElse: () => AppRoutes.notesPage,
    );

    return currentRoute == route;
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    final menuItems = [
      {
        'icon': Icons.notes_rounded,
        'label': context.l10n.menu_notes,
        'route': AppRoutes.notesPage,
      },
      {
        'icon': Icons.notifications,
        'label': context.l10n.menu_reminders,
        'route': AppRoutes.remindersPage,
      },
      {
        'icon': Icons.archive,
        'label': context.l10n.menu_archive,
        'route': AppRoutes.archivePage,
      },
      {
        'icon': Icons.delete,
        'label': context.l10n.menu_trash,
        'route': AppRoutes.trashPage,
      },
    ];

    return menuItems.map((item) {
      return SideMenuElement(
        icon: item['icon'] as IconData,
        label: item['label'] as String,
        onTap: () => context.pushNamed((item['route'] as AppRoutes).name),
        expanded: _controller.isCompleted,
        selected: _isSelected(item['route'] as AppRoutes),
      );
    }).toList();
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        SideMenuElement(
          icon: Icons.settings,
          label: context.l10n.menu_settings,
          onTap: () => context.pushNamed(AppRoutes.settingsPage.name),
          expanded: _controller.isCompleted,
          selected: _isSelected(AppRoutes.settingsPage),
        ),
        SideMenuElement(
          icon: Icons.help,
          label: context.l10n.menu_help,
          onTap: () => context.pushNamed(AppRoutes.helpPage.name),
          expanded: _controller.isCompleted,
          selected: _isSelected(AppRoutes.helpPage),
        ),
      ],
    );
  }
}

class SideMenuElement extends StatefulWidget {
  const SideMenuElement({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    required this.expanded,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final void Function() onTap;
  final bool expanded;
  final bool selected;

  @override
  State<SideMenuElement> createState() => _SideMenuElementState();
}

class _SideMenuElementState extends State<SideMenuElement> {
  bool highlight = false;

  Color _elementColor() {
    if (widget.selected) {
      return Colors.white24;
    } else {
      return highlight ? Colors.white10 : Colors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) => setState(() => highlight = value),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Insets.m,
          vertical: Insets.xs,
        ),
        margin: EdgeInsets.only(
          right: widget.expanded ? Insets.s : 0.0,
          top: Insets.xxs,
        ),
        decoration: BoxDecoration(
          color: _elementColor(),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(Insets.s),
            topRight: Radius.circular(Insets.xxs),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 30,
              padding: const EdgeInsets.only(left: Insets.xs),
              child: Icon(
                widget.icon,
                size: 27,
              ),
            ),
            if (widget.expanded)
              Padding(
                padding: const EdgeInsets.only(left: Insets.xs),
                child: Text(
                  widget.label,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
