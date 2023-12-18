import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/detail_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'util/mock.dart';

void main() {
  testWidgets('DetailScreen', (WidgetTester tester) async {
    final mock = MockNavigationHandler();
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: DetailScreen(
          naviHandler: mock,
          path: '',
        ),
      ),
    );

    // 表示内容確認
    expect(find.text('${S.current.titleDetail}:'), findsOneWidget);
    expect(find.text('a'), findsOneWidget);
    expect(find.text('b'), findsOneWidget);
    expect(find.text('c'), findsOneWidget);

    // ボタン確認
    await tester.tap(find.text('a'));

    // ボタンタップ時に、navigate('/detail?path=/a')が呼ばれることを確認
    verify(mock.navigate('/detail?path=/a')).called(1);
  });
}
