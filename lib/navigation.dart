import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/ui/screen/detail/detail_screen.dart';
import 'package:flutter_engineer_codecheck/ui/screen/search/search_screen.dart';
import 'package:go_router/go_router.dart';

/// ナビゲーションハンドラ
abstract class NavigationHandler {
  /// ナビゲーション
  /// path: パス
  void navigate(String path);
}

/// ルーティングルール
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SearchScreen(naviHandler: _PushNavigationHandler(context));
      },
    ),
    GoRoute(
      path: '/detail',
      pageBuilder: (BuildContext context, GoRouterState state) {
        final path = state.uri.queryParameters['path'] ?? '';
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: DetailScreen(
            naviHandler: _PushNavigationHandler(context),
            path: path,
          ),
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

// ※ 画面置換の場合は、以下のコードを使用する
// /// ナビゲーションハンドラ(画面置換)
// class _GoNavigationHandler implements NavigationHandler {
//   _GoNavigationHandler(this.context);

//   final BuildContext context;

//   @override
//   void navigate(String path) {
//     context.go(path);
//   }
// }

/// ナビゲーションハンドラ(画面遷移)
class _PushNavigationHandler implements NavigationHandler {
  _PushNavigationHandler(this.context);

  final BuildContext context;

  @override
  void navigate(String path) {
    context.push(path);
  }
}
