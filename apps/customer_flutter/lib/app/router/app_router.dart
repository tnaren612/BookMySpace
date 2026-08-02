import 'package:customer_flutter/features/home/presentation/home_shell_page.dart';
import 'package:customer_flutter/features/placeholder/presentation/placeholder_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => HomeShellPage(child: child),
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const PlaceholderPage(
              title: 'Discover',
              subtitle: 'Customer shell — Phase 1 routing OK',
            ),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const PlaceholderPage(
              title: 'Profile',
              subtitle: 'Placeholder — auth arrives in Phase 3/4',
            ),
          ),
        ],
      ),
    ],
  );
});
