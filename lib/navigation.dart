import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/detail_screen.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ナビゲーションハンドラ(画面置換)プロバイダ
final goNavigationHandlerProvider = Provider<NavigationHandler>(
  (ref) => _GoNavigationHandler(),
);

/// ナビゲーションハンドラ(画面遷移)プロバイダ
final pushNavigationHandlerProvider = Provider<NavigationHandler>(
  (ref) => _PushNavigationHandler(),
);

/// ルーティングルール
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SearchScreen();
      },
    ),
    GoRoute(
      path: '/detail',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final path = state.uri.queryParameters['path'] ?? '';
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: DetailScreen(path: path),
          barrierDismissible: true,
          barrierColor: Colors.transparent,
          opaque: false,
          transitionDuration: Duration.zero,
          transitionsBuilder: (_, __, ___, Widget child) => child,
        );
      },
    ),
  ],
);


/// ナビゲーションハンドラ
abstract class NavigationHandler {
  /// ナビゲーション
  /// path: パス
  void navigate(BuildContext context, String path);
}

/// ナビゲーションハンドラ(画面置換)
class _GoNavigationHandler implements NavigationHandler {
  @override
  void navigate(BuildContext context, String path) {
    context.go(path);
  }
}

/// ナビゲーションハンドラ(画面遷移)
class _PushNavigationHandler implements NavigationHandler {
  @override
  void navigate(BuildContext context, String path) {
    context.push(path);
  }
}
