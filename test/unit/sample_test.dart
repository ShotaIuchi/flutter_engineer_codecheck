import 'package:flutter_test/flutter_test.dart';

// TEST TARGET
int add(int a, int b) {
  return a + b;
}

void main() {
  test('[sample] unit test', () {
    final result = add(2, 3);
    expect(result, 5);
  });
}
