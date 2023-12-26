import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/api/api_search.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/item.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/search_response.dart';
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
late MockApiSearch mockApiSearch;

@GenerateMocks([NavigationHandler, ApiSearch])
void main() {
  setUp(() {
    mockNavigation = MockNavigationHandler();
    when(mockNavigation.navigate(any, any)).thenAnswer((_) async {
      return;
    });

    mockApiSearch = MockApiSearch();
    when(mockApiSearch.search(any, any)).thenAnswer(
      (_) async => const SearchResponse(
        totalCount: 2,
        incompleteResults: true,
        items: [
          Item(
            name: 'a',
            fullName: 'fullname-a',
            stargazersCount: 1,
            watchersCount: 1,
            language: 'a',
            forksCount: 1,
            openIssuesCount: 1,
          ),
          Item(
            name: 'b',
            fullName: 'b',
            stargazersCount: 1,
            watchersCount: 1,
            language: 'b',
            forksCount: 1,
            openIssuesCount: 1,
          ),
        ],
      ),
    );
  });

  testWidgets('DetailScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          pushNavigationHandlerProvider.overrideWithValue(mockNavigation),
          apiSearchProvider.overrideWithValue(mockApiSearch),
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

    // 空の画面が表示されることを確認
    expect(find.byType(DetailScreen), findsOneWidget);

    // // ボタン確認
    // await tester.tap(find.text('a'));

    // // ボタンタップ時に、navigate('/detail?path=/a')が呼ばれることを確認
    // verify(mockNavigation.navigate(any, '/detail?path=/a')).called(1);
  });
}
