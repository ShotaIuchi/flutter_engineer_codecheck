import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';

/// 詳細画面
class DetailScreen extends StatelessWidget {
  /// コンストラクタ
  /// naviHandler: ナビゲーションハンドラ
  /// path: パス
  /// key: キー
  const DetailScreen({
    required this.naviHandler,
    required this.path,
    super.key,
  });

  /// ナビゲーション
  final NavigationHandler naviHandler;

  /// ID
  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('詳細画面:$path')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => naviHandler.navigate('/detail?path=$path/a'),
              child: const Text('a'),
            ),
            ElevatedButton(
              onPressed: () => naviHandler.navigate('/detail?path=$path/b'),
              child: const Text('b'),
            ),
            ElevatedButton(
              onPressed: () => naviHandler.navigate('/detail?path=$path/c'),
              child: const Text('c'),
            ),
          ],
        ),
      ),
    );
  }
}
