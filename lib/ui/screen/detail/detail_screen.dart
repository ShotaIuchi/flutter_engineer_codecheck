import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/state/detail_state.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/state/detail_state_notifer.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_logo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細画面
class DetailScreen extends ConsumerWidget {
  /// コンストラクタ
  /// path: パス
  /// key: キー
  const DetailScreen({
    required this.path,
    super.key,
  });

  /// ID
  final String path;

  /// 画像の比率（有効領域）
  static const imageRatio = 0.8;

  /// 画像とテキスト間のマージン
  static const imageTextMargin = 20.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(detailStateProvider);
    // 空の場合は何も表示しない
    if (null == detailState) {
      return Scaffold(
        appBar: AppBar(title: Text(S.of(context).titleDetail)),
        body: const SizedBox.expand(),
      );
    }
    // 画面表示
    return Scaffold(
      appBar: AppBar(title: Text(detailState.searchSummary.fullName)),
      body: _buildBody(context, ref),
    );
  }

  /// Body
  /// [context] コンテキスト
  /// [ref] リファレンス
  Widget _buildBody(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(detailStateProvider)!;
    // 縦横で表示を変える
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      // 縦
      return _buildBodyOrientation(context, ref, detailState, true);
    } else {
      // 横
      return _buildBodyOrientation(context, ref, detailState, false);
    }
  }

  /// 詳細情報
  /// [context] コンテキスト
  /// [ref] リファレンス
  /// [detailState] 詳細状態
  /// [isPortrait] 縦向きかどうか
  Widget _buildBodyOrientation(
    BuildContext context,
    WidgetRef ref,
    DetailSummary detailState,
    bool isPortrait,
  ) {
    final detailState = ref.watch(detailStateProvider);
    final summary = detailState!.searchSummary;
    return SafeArea(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // 縦横で表示を変える
          double area;
          Axis axis;
          Alignment alignment;
          if (isPortrait) {
            area = constraints.maxWidth;
            axis = Axis.vertical;
            alignment = Alignment.centerLeft;
          } else {
            area = constraints.maxHeight;
            axis = Axis.horizontal;
            alignment = Alignment.topCenter;
          }
          // サイズ計算（画像）
          final imageSize = area * imageRatio;
          final imageSpace = area * ((1 - imageRatio) / 2);
          // 表示内容
          final child = <Widget>[
            AppLogo(
              imageUri: summary.imageUrl,
              width: imageSize,
              height: imageSize,
            ),
            if (isPortrait)
              const SizedBox(height: imageTextMargin)
            else
              const SizedBox(width: imageTextMargin),
            Align(
              alignment: alignment,
              child: _buildBodyInfo(context, ref),
            ),
          ];
          // 実際の表示
          return SingleChildScrollView(
            scrollDirection: axis,
            child: Padding(
              padding: EdgeInsets.all(imageSpace),
              child:
                  isPortrait ? Column(children: child) : Row(children: child),
            ),
          );
        },
      ),
    );
  }

  /// 詳細情報
  /// [context] コンテキスト
  /// [ref] リファレンス
  Widget _buildBodyInfo(BuildContext context, WidgetRef ref) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;
    final detailState = ref.watch(detailStateProvider);
    final summary = detailState!.searchSummary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${S.of(context).detailBodyLaunguage} : ${summary.language}',
          style: textStyle,
        ),
        Text(
          '${S.of(context).detailBodyStars} : ${summary.stargazersCount}',
          style: textStyle,
        ),
        Text(
          '${S.of(context).detailBodyWatchers} : ${summary.watchersCount}',
          style: textStyle,
        ),
        Text(
          '${S.of(context).detailBodyForks} : ${summary.forksCount}',
          style: textStyle,
        ),
        Text(
          '${S.of(context).detailBodyIssues} : ${summary.openIssuesCount}',
          style: textStyle,
        ),
      ],
    );
  }
}
