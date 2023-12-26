import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/detail_screen.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_app_bar.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_result_list.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_result_list_item.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_screen.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_exception.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_icon.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_loading.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_padding.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

void main() {
  testWidgets('起動テスト::共通パーツ', (WidgetTester tester) async {
    for (final widget in [
      AppException(exception: Exception('test')),
      const AppIcon(
        imageUri: 'https://avatars.githubusercontent.com/u/1687248?v=4',
      ),
      const AppLoading(),
      const AppPadding(child: SizedBox()),
    ]) {
      Logger().i('widget: $widget');
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
            home: widget,
          ),
        ),
      );
    }
  });

  testWidgets('起動テスト::検索画面', (WidgetTester tester) async {
    for (final widget in [
      const SearchScreen(),
      const SearchAppBar(),
      const SearchResultList(hasNext: false, items: []),
      const SearchResultListItem(
        searchSummary: SearchSummary(
          ownerName: 'a',
          repoName: 'a',
          fullName: 'a',
          imageUrl: 'a',
          language: 'a',
          stargazersCount: 1,
          watchersCount: 1,
          forksCount: 1,
          openIssuesCount: 1,
        ),
        index: 0,
      ),
    ]) {
      Logger().i('起動テスト::widget: $widget');
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
            // Materialデザイン前提のため、Scaffoldでラップする
            home: Scaffold(body: widget),
          ),
        ),
      );
    }
  });

  testWidgets('詳細画面', (WidgetTester tester) async {
    for (final widget in [
      const DetailScreen(path: ''),
    ]) {
      Logger().i('widget: $widget');
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
            // Materialデザイン前提のため、Scaffoldでラップする
            home: Scaffold(body: widget),
          ),
        ),
      );
    }
  });
}
