import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeShellPage extends StatelessWidget {
  const HomeShellPage({super.key, required this.child});

  final Widget child;

  static const _tabs = [
    (path: '/', label: 'Overview', icon: Icons.insights_outlined),
    (path: '/moderation', label: 'Moderation', icon: Icons.gavel_outlined),
  ];

  int _indexForLocation(String location) {
    if (location.startsWith('/moderation')) return 1;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _indexForLocation(location);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: index,
            onDestinationSelected: (i) => context.go(_tabs[i].path),
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (final tab in _tabs)
                NavigationRailDestination(
                  icon: Icon(tab.icon),
                  label: Text(tab.label),
                ),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}
