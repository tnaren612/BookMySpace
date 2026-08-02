import 'package:customer_flutter/app/app.dart';
import 'package:customer_flutter/core/env/app_env.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppEnv defaults to local from defines', () {
    final env = AppEnv.fromDartDefines();
    expect(env.flavor, AppFlavor.local);
    expect(env.apiBaseUrl, 'http://localhost:8080');
  });

  testWidgets('home shell routes to Discover placeholder', (tester) async {
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
        child: const CustomerApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('BookMySpace'), findsWidgets);
    expect(find.text('Discover'), findsWidgets);
    expect(find.textContaining('Phase 1 routing OK'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('Profile'), findsWidgets);
  });
}
