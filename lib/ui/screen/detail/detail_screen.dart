import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final naviHandler = ref.watch(pushNavigationHandlerProvider);
    return Scaffold(
      appBar: AppBar(title: Text('${S.of(context).titleDetail}:$path')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => naviHandler.navigate(context, '/detail?path=$path/a'),
              child: const Text('a'),
            ),
            ElevatedButton(
              onPressed: () => naviHandler.navigate(context, '/detail?path=$path/b'),
              child: const Text('b'),
            ),
            ElevatedButton(
              onPressed: () => naviHandler.navigate(context, '/detail?path=$path/c'),
              child: const Text('c'),
            ),
          ],
        ),
      ),
    );
  }
}
