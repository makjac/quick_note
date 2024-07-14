import 'package:flutter/material.dart';
import 'package:quick_note/core/constans/app_assets.dart';
import 'package:quick_note/core/constans/insets.dart';
import 'package:quick_note/l10n/l10n.dart';

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

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _widthAnimation = Tween<double>(begin: 92, end: 270).animate(_controller);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
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
            decoration: BoxDecoration(
              color: Colors.grey[900],
              boxShadow: const [BoxShadow(blurRadius: 2, spreadRadius: .5)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: Insets.xs),
                ..._buildMenuItems(context),
                const Spacer(),
                _buildFooter(context),
                const SizedBox(height: Insets.s),
              ],
            ),
          ),
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
                  color: Colors.white,
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

  List<Widget> _buildMenuItems(BuildContext context) {
    final menuItems = [
      {'icon': Icons.notes_rounded, 'label': context.l10n.menu_notes},
      {'icon': Icons.notifications, 'label': context.l10n.menu_reminders},
      {'icon': Icons.archive, 'label': context.l10n.menu_archive},
      {'icon': Icons.delete, 'label': context.l10n.menu_bin},
    ];

    return menuItems.map((item) {
      return SideMenuElement(
        icon: item['icon'] as IconData,
        label: item['label'] as String,
        onTap: () {},
        expanded: _controller.isCompleted,
      );
    }).toList();
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        SideMenuElement(
          icon: Icons.settings,
          label: context.l10n.menu_settings,
          onTap: () {},
          expanded: _controller.isCompleted,
        ),
        SideMenuElement(
          icon: Icons.help,
          label: context.l10n.menu_help,
          onTap: () {},
          expanded: _controller.isCompleted,
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
  });

  final IconData icon;
  final String label;
  final void Function() onTap;
  final bool expanded;

  @override
  State<SideMenuElement> createState() => _SideMenuElementState();
}

class _SideMenuElementState extends State<SideMenuElement> {
  bool highlight = false;

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
          color: highlight ? Colors.white10 : Colors.transparent,
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
                color: Colors.white,
              ),
            ),
            if (widget.expanded)
              Padding(
                padding: const EdgeInsets.only(left: Insets.xs),
                child: Text(
                  widget.label,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
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
