import 'package:admin_web/app/app.dart';
import 'package:admin_web/core/env/app_env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('admin shell routes to Overview placeholder', (tester) async {
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
        child: const AdminApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Overview'), findsWidgets);
    expect(find.textContaining('Phase 1 routing OK'), findsOneWidget);

    await tester.tap(find.text('Moderation'));
    await tester.pumpAndSettle();
    expect(find.text('Moderation'), findsWidgets);
  });
}
