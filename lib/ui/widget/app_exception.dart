import 'package:flutter/material.dart';

/// アプリケーション例外クラス
class AppException extends StatelessWidget {
  /// コンストラクタ
  /// [exception] 例外
  const AppException({
    this.exception,
    super.key,
  });

  /// 例外
  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          exception?.runtimeType.toString() ?? 'unknown',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
