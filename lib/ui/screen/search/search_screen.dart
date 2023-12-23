import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_app_bar.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 検索画面
class SearchScreen extends ConsumerWidget {
  /// コンストラクタ
  /// key: キー
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      appBar: SearchAppBar(),
      body: SearchResult(),
    );
  }
}
