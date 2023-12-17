import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';

/// 検索画面
class SearchScreen extends StatelessWidget {
  /// コンストラクタ
  /// naviHandler: ナビゲーションハンドラ
  /// key: キー
  const SearchScreen({required this.naviHandler, super.key});

  /// ナビゲーション
  final NavigationHandler naviHandler;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('検索画面')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => naviHandler.navigate('/detail'),
          child: const Text('詳細画面へ遷移'),
        ),
      ),
    );
  }
}
