import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_state.freezed.dart';

/// 詳細状態
@freezed
class DetailSummary with _$DetailSummary {
  /// コンストラクタ
  /// [searchSummary] 検索サマリー
  const factory DetailSummary({
    required SearchSummary searchSummary,
  }) = _DetailSummary;
}
