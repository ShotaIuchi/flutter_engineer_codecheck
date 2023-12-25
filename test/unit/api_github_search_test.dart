import 'package:flutter_engineer_codecheck/api/api_search.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/search_response.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state_notifer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../test_data/search_repositories.dart';

import '../test_data/search_repositories_error.dart';
import '../test_data/search_repositories_zero.dart';
import '../util/listener_mock.dart';
import 'api_github_search_test.mocks.dart';

@GenerateMocks([ApiSearch])
void main() {
  const query = 'flutter';
  test('[Model][GitHub][Search]レスポンス', () {
    final model = SearchResponse.fromJson(testDataSearchRepositories);
    // SearchResponse
    expect(model.totalCount, 625144);
    expect(model.incompleteResults, false);
    expect(model.items.length, 30);

    // Item
    final item = model.items[0];
    expect(item.name, 'flutter');
    expect(item.fullName, 'flutter/flutter');
    expect(item.stargazersCount, 158781);
    expect(item.watchersCount, 158781);
    expect(item.forksCount, 26534);
    expect(item.openIssuesCount, 12105);
    expect(item.language, 'Dart');
    assert(item.owner != null, 'owner is null');
    assert(item.license != null, 'license is null');

    // Owner
    final owner = item.owner!;
    expect(owner.login, 'flutter');
    expect(
      owner.avatarUrl,
      'https://avatars.githubusercontent.com/u/14101776?v=4',
    );
    expect(owner.url, 'https://api.github.com/users/flutter');
    expect(owner.htmlUrl, 'https://github.com/flutter');
    expect(owner.type, 'Organization');

    // License
    final license = item.license!;
    expect(license.name, 'BSD 3-Clause New or Revised License');
  });

  test('[Model][GitHub][Search]ステータス::成功', () async {
    await _testApiStateCheck(
      query,
      testDataSearchRepositories,
      (listener) {
        verifyInOrder([
          listener(any, const SearchState.uninitialized()),
          listener(any, const SearchState.searching(query: query)),
          listener(
            any,
            SearchState.success(
              query: query,
              page: 1,
              hasNextPage: true,
              items: SearchResponse.fromJson(testDataSearchRepositories)
                  .items
                  .map(
                    (e) => SearchSummary(
                      ownerName: e.owner!.login,
                      repoName: e.name,
                      fullName: e.fullName,
                      imageUrl: e.owner!.avatarUrl,
                    ),
                  )
                  .toList(),
            ),
          ),
        ]);
      },
    );
  });

  test('[Model][GitHub][Search]ステータス::空', () async {
    await _testApiStateCheck(
      query,
      testDataSearchRepositoriesZero,
      (listener) {
        verifyInOrder([
          listener(any, const SearchState.uninitialized()),
          listener(any, const SearchState.searching(query: query)),
          listener(any, const SearchState.successEmpty(query: query)),
        ]);
      },
    );
  });

  test('[Model][GitHub][Search]ステータス::エラー', () async {
    await _testApiStateCheck(
      query,
      testDataSearchRepositoriesError,
      (listener) {
        verifyInOrder([
          listener(any, const SearchState.uninitialized()),
          listener(any, const SearchState.searching(query: query)),
          listener(any, const SearchState.failure()),
        ]);
      },
    );
  });
}

/// API呼び出しの状態変化を確認する
/// [query] 検索クエリ
/// [testDataJson] テストデータ
/// [verifyCheck] 状態変化の確認
Future<void> _testApiStateCheck(
  String query,
  Map<String, dynamic> testDataJson,
  void Function(ListenerMock listener) verifyCheck,
) async {
  // モックを作成
  final mock = MockApiSearch();
  when(mock.search(any, any)).thenAnswer(
    (realInvocation) => Future.value(
      SearchResponse.fromJson(testDataJson),
    ),
  );

  // テスト対象のコンテナを作成
  final container = ProviderContainer(
    overrides: [apiSearchProvider.overrideWithValue(mock)],
  );

  // 状態変化を監視する
  final listener = ListenerMock();
  container.listen(
    searchStateNotifierProvider,
    (previous, next) {
      Logger().i('previous: $previous, next: $next');
      listener(previous, next);
    },
    fireImmediately: true,
  );

  // APIを呼び出す
  final notifier = container.read(searchStateNotifierProvider.notifier);
  await notifier.search(query, 1);

  // 状態変化の監視を解除
  container.dispose();

  // 状態変化を確認
  verifyCheck(listener);

  // 必要以上にlistenerが呼ばれていないか確認
  verifyNoMoreInteractions(listener);
}
