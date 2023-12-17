import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_engineer_codecheck/main.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/detail_screen.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ナビゲーションテスト', (tester) async {
    await tester.pumpWidget(const MyApp());

    // 初期表示は、検索画面
    expect(find.byType(SearchScreen), findsOneWidget);
    expect(find.text('検索画面'), findsOneWidget);
    expect(find.text('詳細画面へ遷移'), findsOneWidget);

    // 遷移前は、遷移先の画面は存在しない
    expect(find.byType(DetailScreen), findsNothing);

    // 詳細画面へ遷移
    await tester.tap(find.text('詳細画面へ遷移'));
    await tester.pumpAndSettle();

    // 遷移後は、詳細画面が表示される
    expect(find.byType(DetailScreen), findsOneWidget);
    expect(find.text('詳細画面:'), findsOneWidget);
    expect(find.text('a'), findsOneWidget);
    expect(find.text('b'), findsOneWidget);
    expect(find.text('c'), findsOneWidget);

    // push で遷移した場合は、遷移元の画面は残る
    expect(find.byType(SearchScreen), findsOneWidget);

    // a ボタンをタップ
    // スタックに積まれた最前面の画面のボタンをタップする(.hitTestable())
    await tester.tap(find.text('a').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('詳細画面:/a'), findsOneWidget);

    // b ボタンをタップ
    // スタックに積まれた最前面の画面のボタンをタップする(.hitTestable())
    await tester.tap(find.text('b').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('詳細画面:/a/b'), findsOneWidget);

    // c ボタンをタップ
    // スタックに積まれた最前面の画面のボタンをタップする(.hitTestable())
    await tester.tap(find.text('c').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('詳細画面:/a/b/c'), findsOneWidget);

    // バックボタンをタップ
    // スタックに積まれた最前面の画面のボタンをタップする(.hitTestable())
    await tester.tap(find.byIcon(Icons.arrow_back).hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('詳細画面:/a/b'), findsOneWidget);

    // バックキーを押下
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    expect(find.text('詳細画面:/a'), findsOneWidget);
  });
}
