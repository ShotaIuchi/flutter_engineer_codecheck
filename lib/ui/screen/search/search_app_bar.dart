import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/state/github/search_state_notifer.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 検索バー
class SearchAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  /// コンストラクタ
  /// key: キー
  const SearchAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSearchMode = useState(false);
    return isSearchMode.value
        ? _buildSearchBar(ref, () => isSearchMode.value = false)
        : _buildNormalBar(ref, () => isSearchMode.value = true);
  }

  /// 通常のバーを作成する
  PreferredSizeWidget _buildNormalBar(
    WidgetRef ref,
    void Function() onPressed,
  ) {
    final searchState = ref.watch(searchStateNotifierProvider);
    return AppBar(
      title: Text(
        searchState.when(
          uninitialized: () => S.of(ref.context).titleSearch,
          searching: (query) => query,
          success: (query, page, hasNextPage, items) => query,
          successNextFetching: (query, page, items) => query,
          successEmpty: (query) => query,
          failure: (exception) => S.of(ref.context).titleSearch,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  /// 検索バーを作成する
  PreferredSizeWidget _buildSearchBar(
    WidgetRef ref,
    void Function() onPressed,
  ) {
    final searchState = ref.watch(searchStateNotifierProvider.notifier);
    return AppBar(
      title: TextField(
        autofocus: true,
        decoration: InputDecoration(hintText: S.of(ref.context).hintSearch),
        textInputAction: TextInputAction.search,
        onSubmitted: (value) {
          searchState.search(value, 1);
          onPressed();
        },
      ),
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
