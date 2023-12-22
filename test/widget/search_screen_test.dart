import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/api/api_search.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/item.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/search_response.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';
import 'package:flutter_engineer_codecheck/state/github/search_state.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_result_list.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_screen_test.mocks.dart';

late MockNavigationHandler mockNavigation;
late MockApiSearch mockApiSearch;

@GenerateMocks([ApiSearch, NavigationHandler])
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
            fullName: 'a',
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

  testWidgets('SearchScreen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          apiSearchProvider.overrideWithValue(mockApiSearch),
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
          home: const SearchScreen(),
        ),
      ),
    );

    // 表示内容確認
    expect(find.text(S.current.titleSearch), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    // 検索アイコンをタップ
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // 表示内容変化を確認
    expect(find.text(S.current.titleSearch), findsNothing);

    // 'test'を入力
    await tester.enterText(find.byType(TextField), 'test');
    await tester.pumpAndSettle();

    // IMEの検索ボタンを押下
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    // 検索処理が呼ばれることを確認
    verify(mockApiSearch.search('test', 1)).called(1);

    // 最初のリストアイテムをタップ
    await tester.tap(find.byType(ListTile).first);
    await tester.pump();

    // ナビゲーション処理が呼ばれることを確認
    verify(mockNavigation.navigate(any, '/detail')).called(1);
  });

  testWidgets('SearchAppBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
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
          home: const SearchScreen(),
        ),
      ),
    );

    // 表示内容確認
    expect(find.text(S.current.titleSearch), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);

    // 検索アイコンをタップ
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();

    // 表示内容変化を確認
    expect(find.text(S.current.titleSearch), findsNothing);

    // 'test'を入力
    await tester.enterText(find.byType(TextField), 'test');
    await tester.pumpAndSettle();

    // IMEの検索ボタンを押下
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    // 検索処理が呼ばれることを確認
    verify(mockApiSearch.search('test', 1)).called(1);
  });

  testWidgets('SearchResultList', (WidgetTester tester) async {
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
          home: const Scaffold(
            body: SearchResultList(
              hasNext: false,
              items: [
                SearchSummary(
                  ownerName: 'a',
                  repoName: 'a',
                  fullName: 'a',
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/1687248?v=4',
                ),
                SearchSummary(
                  ownerName: 'b',
                  repoName: 'b',
                  fullName: 'b',
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/1687248?v=4',
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // 最初のリストアイテムをタップ
    await tester.tap(find.byType(ListTile).first);
    await tester.pump();

    // ナビゲーション処理が呼ばれることを確認
    verify(mockNavigation.navigate(any, '/detail')).called(1);
  });
}
