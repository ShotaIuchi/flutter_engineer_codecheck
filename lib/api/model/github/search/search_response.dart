import 'package:flutter_engineer_codecheck/api/model/github/search/item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_response.freezed.dart';
part 'search_response.g.dart';

/// 検索結果
@freezed
class SearchResponse with _$SearchResponse {
  /// コンストラクタ
  const factory SearchResponse({
    @JsonKey(name: 'total_count') required int totalCount,
    @JsonKey(name: 'incomplete_results') required bool incompleteResults,
    @JsonKey(name: 'items') required List<Item> items,
  }) = _SearchResponse;

  /// JSONからインスタンスを生成
  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);
}

/// 検索結果の拡張
extension SearchResponseExtension on SearchResponse {
  /// 次のページがあるかどうか
  bool get hasNextPage => totalCount > items.length;
}
