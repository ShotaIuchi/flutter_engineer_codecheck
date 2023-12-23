import 'package:flutter/material.dart';

/// アプリローディング
class AppLoading extends StatelessWidget {
  /// コンストラクタ
  const AppLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Colors.grey,
      strokeWidth: 2,
    );
  }
}
