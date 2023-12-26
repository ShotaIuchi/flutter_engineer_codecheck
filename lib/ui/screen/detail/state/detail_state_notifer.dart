import 'package:flutter_engineer_codecheck/ui/screen/detail/state/detail_state.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/state/search_state_notifer.dart';
import 'package:flutter_engineer_codecheck/ui/screen/select_index_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 詳細状態通知プロバイダー
final detailStateProvider = Provider.autoDispose<DetailSummary?>((ref) {
  final index = ref.watch(selectIndexProvider);
  final searchState = ref.watch(searchStateNotifierProvider);
  if (searchState is Success && searchState.items.length > index) {
    final item = searchState.items[index];
    return DetailSummary(searchSummary: item);
  }
  return null;
});
