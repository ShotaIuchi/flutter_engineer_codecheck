import 'package:flutter_engineer_codecheck/api/api_search.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/search_response.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

/// 検索状態のプロバイダー
final searchStateNotifierProvider =
    StateNotifierProvider.autoDispose<SearchStateNotifer, SearchState>(
  SearchStateNotifer.new,
);

/// 検索状態の通知
class SearchStateNotifer extends StateNotifier<SearchState> {
  /// コンストラクタ
  /// [_ref] プロバイダー参照
  /// 初期値は未初期化を設定
  SearchStateNotifer(this._ref) : super(const SearchState.uninitialized());

  /// プロバイダー参照
  final StateNotifierProviderRef<SearchStateNotifer, SearchState> _ref;

  /// 検索API
  ApiSearch get _apiSearch => _ref.read(apiSearchProvider);

  /// 検索
  /// [query] 検索クエリ
  /// [page] ページ
  /// 検索中、検索成功、検索成功（空）、検索失敗のいずれかの状態になる
  Future<void> search(String query, int page) async {
    // 検索中
    state = SearchState.searching(query: query);

    // 検索処理
    try {
      await _search(query, page, []);
    } on Exception catch (e) {
      Logger().e(e);
      state = SearchState.failure(exception: e);
    }
  }

  /// 次のページを検索
  Future<void> fetchNext() async {
    // 現在の状態を取得
    final nowState = state;

    // 再検索ガード
    if (nowState is Success && nowState.hasNextPage) {
      // 次のページがある場合
      state = SearchState.successNextFetching(
        query: nowState.query,
        page: nowState.page,
        items: nowState.items,
      );

      // 検索処理
      try {
        await _search(nowState.query, nowState.page + 1, nowState.items);
      } catch (e) {
        Logger().e(e);
        // 検索失敗時は現在の状態を復元
        state = SearchState.success(
          query: nowState.query,
          page: nowState.page,
          hasNextPage: nowState.hasNextPage,
          items: nowState.items,
        );
      }
    }
  }

  /// 検索処理
  /// [query] 検索クエリ
  /// [page] ページ
  /// [nowItems] 現在の検索結果
  Future<void> _search(
    String query,
    int page,
    List<SearchSummary> nowItems,
  ) async {
    // 検索APIを呼び出す
    final SearchResponse response;
    try {
      response = await _apiSearch.search(query, page);
    } on Exception {
      rethrow;
    }

    if (response.totalCount == 0) {
      // 検索結果が0件の場合
      state = SearchState.successEmpty(query: query);
    } else {
      if (response.items.isEmpty) {
        // 検索結果がない場合
        // サーバー側の不具合の可能性があるため、エラーとして扱う
        state = const SearchState.failure();
      } else {
        // 検索結果がある場合
        state = SearchState.success(
          query: query,
          page: page,
          hasNextPage: response.hasNextPage,
          items: nowItems +
              response.items
                  .map(
                    (item) => SearchSummary(
                      ownerName: item.owner?.login ?? '',
                      repoName: item.name,
                      fullName: item.fullName,
                      imageUrl: item.owner?.avatarUrl ?? '',
                    ),
                  )
                  .toList(),
        );
      }
    }
  }
}
