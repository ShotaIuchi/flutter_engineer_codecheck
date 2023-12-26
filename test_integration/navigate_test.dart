import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    // 詳細画面の表示内容を確認
    // ※さすがにflutter公式が表示されるだろうという前提で、flutter/flutterを探す
    expect(find.descendant(of: find.byType(DetailScreen), matching: find.text('flutter/flutter')), findsOneWidget);

    // push で遷移した場合は、遷移元の画面は残る
    expect(find.byType(SearchScreen), findsOneWidget);

    // 戻るボタンをタップ
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    // 遷移後は、検索画面が表示される
    expect(find.byType(SearchScreen), findsOneWidget);
    expect(find.byType(DetailScreen), findsNothing);
  });
}
