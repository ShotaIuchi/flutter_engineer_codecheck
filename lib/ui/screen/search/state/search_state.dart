import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_state.freezed.dart';

/// 検索結果のレスポンス
@freezed
class SearchState with _$SearchState {
  /// 未初期化
  const factory SearchState.uninitialized() = Uninitialized;

  /// 検索中
  const factory SearchState.searching({
    required String query,
  }) = Searching;

  /// 成功
  /// [query] 検索クエリ
  /// [page] ページ
  /// [hasNextPage] 次のページがあるかどうか
  /// [items] 全アイテム
  const factory SearchState.success({
    required String query,
    required int page,
    required bool hasNextPage,
    @Default([]) List<SearchSummary> items,
  }) = Success;

  /// 成功
  /// [query] 検索クエリ
  /// [page] ページ
  /// [items] 全アイテム
  const factory SearchState.successNextFetching({
    required String query,
    required int page,
    @Default([]) List<SearchSummary> items,
  }) = SuccessNextFetching;

  /// 成功（空）
  const factory SearchState.successEmpty({
    required String query,
  }) = SuccessEmpty;

  /// 失敗
  const factory SearchState.failure({
    @Default(null) Exception? exception,
  }) = Failure;
}

/// リポジトリのサマリー
@freezed
class SearchSummary with _$SearchSummary {
  /// コンストラクタ
  /// [ownerName] オーナー名
  /// [repoName] リポジトリ名
  /// [fullName] フルネーム
  /// [imageUrl] 画像URL
  const factory SearchSummary({
    required String ownerName,
    required String repoName,
    required String fullName,
    required String imageUrl,
    required String language,
    required int stargazersCount,
    required int watchersCount,
    required int forksCount,
    required int openIssuesCount,
  }) = _SearchSummary;
}
