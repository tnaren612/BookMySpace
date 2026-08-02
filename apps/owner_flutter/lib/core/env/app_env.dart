import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppFlavor { local, staging, production }

class AppEnv {
  const AppEnv({
    required this.flavor,
    required this.apiBaseUrl,
  });

  final AppFlavor flavor;
  final String apiBaseUrl;

  bool get isLocal => flavor == AppFlavor.local;

  factory AppEnv.fromDartDefines() {
    const flavorName = String.fromEnvironment('APP_FLAVOR', defaultValue: 'local');
    const apiBaseUrl = String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'http://localhost:8080',
    );

    final flavor = switch (flavorName) {
      'staging' => AppFlavor.staging,
      'production' => AppFlavor.production,
      _ => AppFlavor.local,
    };

    return AppEnv(flavor: flavor, apiBaseUrl: apiBaseUrl);
  }

  @override
  String toString() => 'AppEnv(flavor: $flavor, apiBaseUrl: $apiBaseUrl, debug: $kDebugMode)';
}

final appEnvProvider = Provider<AppEnv>((ref) {
  throw UnimplementedError('appEnvProvider must be overridden in main()');
});
