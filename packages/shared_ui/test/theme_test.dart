import 'package:flutter_test/flutter_test.dart';
import 'package:shared_ui/shared_ui.dart';

void main() {
  test('light and dark themes use Material 3', () {
    expect(AppTheme.light().useMaterial3, isTrue);
    expect(AppTheme.dark().useMaterial3, isTrue);
    expect(AppTheme.light().colorScheme.primary, AppColors.brandPrimary);
  });

  testWidgets('spacing tokens are positive', (tester) async {
    expect(AppSpacing.md, greaterThan(0));
  });
}
