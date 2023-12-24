import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/detail_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'detail_screen_test.mocks.dart';

late MockNavigationHandler mockNavigation;

@GenerateMocks([NavigationHandler])
void main() {
  setUp(() {
    mockNavigation = MockNavigationHandler();
    when(mockNavigation.navigate(any, any)).thenAnswer((_) async {
      return;
    });
  });

  testWidgets('DetailScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pushNavigationHandlerProvider.overrideWithValue(mockNavigation),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: const DetailScreen(path: ''),
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
    verify(mockNavigation.navigate(any, '/detail?path=/a')).called(1);
  });
}
