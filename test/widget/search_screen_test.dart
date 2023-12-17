import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'util/mock.dart';

void main() {
  testWidgets('SearchScreen', (WidgetTester tester) async {
    final mock = MockNavigationHandler();
    await tester.pumpWidget(MaterialApp(home: SearchScreen(naviHandler: mock)));

    // 表示内容確認
    expect(find.text('検索画面'), findsOneWidget);
    expect(find.text('詳細画面へ遷移'), findsOneWidget);

    // ボタン確認
    await tester.tap(find.text('詳細画面へ遷移'));

    // ボタンタップ時に、navigate('/detail')が呼ばれることを確認
    verify(mock.navigate('/detail')).called(1);
  });
}
