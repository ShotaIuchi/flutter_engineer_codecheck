import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/generated/l10n.dart';
import 'package:flutter_engineer_codecheck/navigation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

/// ページエントリポイント
class MyApp extends StatelessWidget {
  /// コンストラクタ
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appBarTheme = AppBarTheme(
      elevation: 10,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );
    return MaterialApp.router(
      // ライトテーマ
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        appBarTheme: appBarTheme,
      ),
      // ダークテーマ
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
          brightness: Brightness.dark,
        ),
        appBarTheme: appBarTheme.copyWith(
          titleTextStyle: appBarTheme.titleTextStyle!.copyWith(
            color: Colors.white,
          ),
        ),
      ),
      // ロケール設定
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // 対応ロケール
      supportedLocales: S.delegate.supportedLocales,
      // ナビゲーション
      routerConfig: router,
    );
  }
}
