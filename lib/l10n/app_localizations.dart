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

  /// 検索ヒント
  String get hintSearch => Intl.message(
        'Enter search word',
        name: 'hintSearch',
        desc: 'Hint of Search',
      );
}
