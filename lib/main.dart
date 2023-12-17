import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';

void main() {
  runApp(const MyApp());
}

/// ページエントリポイント
class MyApp extends StatelessWidget {
  /// コンストラクタ
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
