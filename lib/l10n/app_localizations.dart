import 'package:intl/intl.dart';

/// アプリローカライズ
class AppLocalizations {

  /// タイトル：検索画面
  String get titleSearch => Intl.message(
        'Search Screen',
        name: 'titleSearch',
        desc: 'Title of Search Screen',
      );

  /// タイトル：詳細画面
  String get titleDetail => Intl.message(
        'Detail Screen',
        name: 'detailSearch',
        desc: 'Title of Detail Screen',
      );

  /// ボタン：詳細画面へ遷移
  String get buttonDetail => Intl.message(
        'Navigate to Detail Screen',
        name: 'buttonDetail',
        desc: 'Button of Navigate to Detail Screen',
      );
}
