import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'owner.freezed.dart';
part 'owner.g.dart';

/// オーナー情報
@freezed
class Owner with _$Owner {
  /// コンストラクタ
  const factory Owner({
    @JsonKey(name: 'login') required String login,
    @JsonKey(name: 'avatar_url') required String avatarUrl,
    @JsonKey(name: 'url') required String url,
    @JsonKey(name: 'html_url') required String htmlUrl,
    @JsonKey(name: 'type') required String type,
  }) = _Owner;

  /// JSON からインスタンスを生成する
  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
