import 'package:flutter/material.dart';

/// アプリパディング
class AppPadding extends StatelessWidget {
  /// コンストラクタ
  const AppPadding({required this.child, super.key});

  /// このウィジェットの子
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
