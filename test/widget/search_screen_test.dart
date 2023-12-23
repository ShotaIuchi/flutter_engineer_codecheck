import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  testWidgets('SearchScreen', (WidgetTester tester) async {
    //final mock = MockNavigationHandler();
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          //home: SearchScreen(naviHandler: mock),
          home: const SearchScreen(),
        ),
      ),
    );

    // 表示内容確認
    //expect(find.text(S.current.titleSearch), findsOneWidget);
    //expect(find.text(S.current.buttonDetail), findsOneWidget);

    // ボタン確認
    //await tester.tap(find.text(S.current.buttonDetail));

    // ボタンタップ時に、navigate('/detail')が呼ばれることを確認
    //verify(mock.navigate('/detail')).called(1);
  });
}
