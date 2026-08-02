import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:owner_flutter/features/home/presentation/home_shell_page.dart';
import 'package:owner_flutter/features/placeholder/presentation/placeholder_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => HomeShellPage(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'dashboard',
            builder: (context, state) => const PlaceholderPage(
              title: 'Dashboard',
              subtitle: 'Owner shell — Phase 1 routing OK',
            ),
          ),
          GoRoute(
            path: '/venues',
            name: 'venues',
            builder: (context, state) => const PlaceholderPage(
              title: 'Venues',
              subtitle: 'Placeholder — venue catalog arrives in Phase 5',
            ),
          ),
        ],
      ),
    ],
  );
});
