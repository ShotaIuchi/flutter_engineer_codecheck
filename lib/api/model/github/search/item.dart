import 'package:flutter/foundation.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/license.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/owner.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

/// 検索結果のアイテム情報
@freezed
class Item with _$Item {
  /// コンストラクタ
  const factory Item({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'full_name') required String fullName,
    @JsonKey(name: 'stargazers_count') required int stargazersCount,
    @JsonKey(name: 'watchers_count') required int watchersCount,
    @JsonKey(name: 'forks_count') required int forksCount,
    @JsonKey(name: 'open_issues_count') required int openIssuesCount,
    @JsonKey(name: 'language') String? language,
    @JsonKey(name: 'owner') Owner? owner,
    @JsonKey(name: 'license') License? license,
  }) = _Item;

  /// JSON からインスタンスを生成する
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
