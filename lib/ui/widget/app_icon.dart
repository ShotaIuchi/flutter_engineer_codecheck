import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_loading.dart';

/// アプリアイコン
class AppIcon extends StatelessWidget {
  /// コンストラクタ
  /// [imageUri] 画像URI
  const AppIcon({
    required this.imageUri,
    this.width,
    this.height,
    super.key,
  });

  /// 画像URI
  final String imageUri;

  /// 幅
  final double? width;

  /// 高さ
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imageUri,
        placeholder: (context, url) => const AppLoading(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
