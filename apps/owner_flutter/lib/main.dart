import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:owner_flutter/app/app.dart';
import 'package:owner_flutter/core/env/app_env.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final env = AppEnv.fromDartDefines();
  runApp(
    ProviderScope(
      overrides: [
        appEnvProvider.overrideWithValue(env),
      ],
      child: const OwnerApp(),
    ),
  );
}
