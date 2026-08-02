import 'package:common_utils/common_utils.dart';
import 'package:test/test.dart';

void main() {
  test('isBlank detects empty values', () {
    expect(isBlank(null), isTrue);
    expect(isBlank('  '), isTrue);
    expect(isBlank('ok'), isFalse);
  });
}
