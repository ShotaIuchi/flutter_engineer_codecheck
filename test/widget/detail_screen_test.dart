import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/detail_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'util/mock.dart';

void main() {
  testWidgets('DetailScreen', (WidgetTester tester) async {
    final mock = MockNavigationHandler();
    await tester.pumpWidget(
      MaterialApp(
        home: DetailScreen(
          naviHandler: mock,
          path: '',
        ),
      ),
    );

    // 表示内容確認
    expect(find.text('詳細画面:'), findsOneWidget);
    expect(find.text('a'), findsOneWidget);
    expect(find.text('b'), findsOneWidget);
    expect(find.text('c'), findsOneWidget);

    // ボタン確認
    await tester.tap(find.text('a'));

    // ボタンタップ時に、navigate('/detail?path=/a')が呼ばれることを確認
    verify(mock.navigate('/detail?path=/a')).called(1);
  });
}
