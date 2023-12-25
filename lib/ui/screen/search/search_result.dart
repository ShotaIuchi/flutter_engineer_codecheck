import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_result_list.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state_notifer.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_exception.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 検索結果リスト
class SearchResult extends HookConsumerWidget {
  /// コンストラクタ
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchStateNotifierProvider);
    return searchState.when(
      uninitialized: () => const SizedBox.shrink(),
      searching: (query) => const Center(child: AppLoading()),
      success: (query, page, hasNextPage, items) =>
          SearchResultList(hasNext: hasNextPage, items: items),
      successNextFetching: (query, page, items) =>
          SearchResultList(hasNext: true, items: items),
      successEmpty: (query) =>
          const SearchResultList(hasNext: false, items: []),
      failure: (exception) => AppException(exception: exception),
    );
  }
}
