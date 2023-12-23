import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/state/github/search_state.dart';
import 'package:flutter_engineer_codecheck/state/github/search_state_notifer.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_result_list_item.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_loading.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_padding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 検索結果リスト
class SearchResultList extends HookConsumerWidget {
  /// コンストラクタ
  const SearchResultList({
    required this.hasNext,
    required this.items,
    super.key,
  });

  /// 次のページがあるか
  final bool hasNext;

  /// 検索結果
  final List<SearchSummary> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(searchStateNotifierProvider.notifier);
    final itemCount = items.length;
    return Scrollbar(
      child: NotificationListener<ScrollNotification>(
        onNotification: !hasNext
            ? null
            : (ScrollNotification notification) {
                if (notification.metrics.atEdge &&
                    notification.metrics.extentAfter == 0) {
                  searchState.fetchNext();
                }
                return false;
              },
        child: ListView.builder(
          itemCount: itemCount + (hasNext ? 1 : 0),
          itemBuilder: (context, index) {
            if (!hasNext || index < itemCount) {
              return SearchResultListItem(searchSummary: items[index]);
            }
            return const AppPadding(child: Center(child: AppLoading()));
          },
        ),
      ),
    );
  }
}
