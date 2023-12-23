import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';
import 'package:flutter_engineer_codecheck/state/github/search_state.dart';
import 'package:flutter_engineer_codecheck/ui/widget/app_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 検索結果リストアイテム
class SearchResultListItem extends ConsumerWidget {
  /// コンストラクタ
  const SearchResultListItem({required this.searchSummary, super.key});

  /// リポジトリサマリー
  final SearchSummary searchSummary;

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
      onTap: () => naviHandler.navigate(context, '/detail'),
    );
  }
}
