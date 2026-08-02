import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:owner_flutter/app/app.dart';
import 'package:owner_flutter/core/env/app_env.dart';

void main() {
  testWidgets('owner shell routes to Dashboard placeholder', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appEnvProvider.overrideWithValue(
            const AppEnv(
              flavor: AppFlavor.local,
              apiBaseUrl: 'http://localhost:8080',
            ),
          ),
        ],
        child: const OwnerApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Dashboard'), findsWidgets);
    expect(find.textContaining('Phase 1 routing OK'), findsOneWidget);

    await tester.tap(find.text('Venues'));
    await tester.pumpAndSettle();
    expect(find.text('Venues'), findsWidgets);
  });
}
