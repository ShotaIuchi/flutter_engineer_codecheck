import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/main.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/detail_screen.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_screen.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_loading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('ナビゲーションテスト', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // 初期表示は、検索画面
    expect(find.byType(SearchScreen), findsOneWidget);

    // 検索ボタンをタップ
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // 遷移前は、遷移先の画面は存在しない
    expect(find.byType(DetailScreen), findsNothing);

     // 'test'を入力
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.pumpAndSettle();

    // IMEの検索ボタンを押下
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    // ローディング表示
    expect(find.byType(AppLoading), findsOneWidget);
    await tester.pumpAndSettle();

    // 詳細画面へ遷移
    await tester.tap(find.byType(ListTile).first);
    await tester.pump();

    // 遷移後は、詳細画面が表示される
    expect(find.byType(DetailScreen), findsOneWidget);

    //// 詳細画面
    expect(find.text('${S.current.titleDetail}:'), findsOneWidget);
    expect(find.text('a'), findsOneWidget);
    expect(find.text('b'), findsOneWidget);
    expect(find.text('c'), findsOneWidget);

    // push で遷移した場合は、遷移元の画面は残る
    expect(find.byType(SearchScreen), findsOneWidget);

    // a ボタンをタップ
    // スタックに積まれた最前面の画面のボタンをタップする(.hitTestable())
    await tester.tap(find.text('a').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('${S.current.titleDetail}:/a'), findsOneWidget);

    // b ボタンをタップ
    // スタックに積まれた最前面の画面のボタンをタップする(.hitTestable())
    await tester.tap(find.text('b').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('${S.current.titleDetail}:/a/b'), findsOneWidget);

    // c ボタンをタップ
    // スタックに積まれた最前面の画面のボタンをタップする(.hitTestable())
    await tester.tap(find.text('c').hitTestable());
    await tester.pumpAndSettle();
    expect(find.text('${S.current.titleDetail}:/a/b/c'), findsOneWidget);
    //// 詳細画面

    // バックキーを押下
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    // 遷移後は、検索画面が表示される
    expect(find.byType(SearchScreen), findsOneWidget);
  });
}
