import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state.dart';
import 'package:flutter_engineer_codecheck/ui/screen/select_index_provider.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 検索結果リストアイテム
class SearchResultListItem extends ConsumerWidget {
  /// コンストラクタ
  /// [searchSummary] 検索サマリー
  /// [index] インデックス
  /// key: キー
  const SearchResultListItem({
    required this.searchSummary,
    required this.index,
    super.key,
  });

  /// 検索サマリー
  final SearchSummary searchSummary;

  /// インデックス
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final naviHandler = ref.watch(pushNavigationHandlerProvider);
    return ListTile(
      minLeadingWidth: 40,
      leading: AppIcon(
        imageUri: searchSummary.imageUrl,
      ),
      title: Text(
        searchSummary.fullName,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      subtitle: Text(
        searchSummary.ownerName,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      onTap: () {
        ref.read(selectIndexProvider.notifier).state = index;
        naviHandler.navigate(context, '/detail');
      },
    );
  }
}
