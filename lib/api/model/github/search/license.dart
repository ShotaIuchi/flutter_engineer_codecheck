import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'license.freezed.dart';
part 'license.g.dart';

/// ライセンス情報
@freezed
class License with _$License {
  /// コンストラクタ
  const factory License({
    @JsonKey(name: 'name') required String name,
  }) = _License;

  /// JSON からインスタンスを生成する
  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);
}
