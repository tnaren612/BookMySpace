import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:owner_flutter/app/router/app_router.dart';
import 'package:owner_flutter/core/env/app_env.dart';
import 'package:shared_ui/shared_ui.dart';

class OwnerApp extends ConsumerWidget {
  const OwnerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final env = ref.watch(appEnvProvider);

    return MaterialApp.router(
      title: 'BookMySpace Owner',
      debugShowCheckedModeBanner: env.isLocal,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
