import 'package:customer_flutter/app/app.dart';
import 'package:customer_flutter/core/env/app_env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final env = AppEnv.fromDartDefines();
  runApp(
    ProviderScope(
      overrides: [
        appEnvProvider.overrideWithValue(env),
      ],
      child: const CustomerApp(),
    ),
  );
}
