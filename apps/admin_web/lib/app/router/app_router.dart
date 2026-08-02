import 'package:admin_web/features/home/presentation/home_shell_page.dart';
import 'package:admin_web/features/placeholder/presentation/placeholder_page.dart';
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
            name: 'overview',
            builder: (context, state) => const PlaceholderPage(
              title: 'Overview',
              subtitle: 'Admin shell — Phase 1 routing OK',
            ),
          ),
          GoRoute(
            path: '/moderation',
            name: 'moderation',
            builder: (context, state) => const PlaceholderPage(
              title: 'Moderation',
              subtitle: 'Placeholder — admin console arrives in Phase 14',
            ),
          ),
        ],
      ),
    ],
  );
});
