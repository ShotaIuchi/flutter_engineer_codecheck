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

  /// 詳細画面::Body::言語
  String get detailBodyLanguage => Intl.message(
        'Detail Body Language',
        name: 'detailBodyLanguage',
        desc: 'Detail Body Language',
      );

  /// 詳細画面::Body::スター数
  String get detailBodyStar => Intl.message(
        'Detail Body Star',
        name: 'detailBodyStar',
        desc: 'Detail Body Star',
      );

  /// 詳細画面::Body::ウォッチャー数
  String get detailBodyWatcher => Intl.message(
        'Detail Body Watcher',
        name: 'detailBodyWatcher',
        desc: 'Detail Body Watcher',
      );

  /// 詳細画面::Body::フォーク数
  String get detailBodyFork => Intl.message(
        'Detail Body Fork',
        name: 'detailBodyFork',
        desc: 'Detail Body Fork',
      );

  /// 詳細画面::Body::イシュー数
  String get detailBodyIssue => Intl.message(
        'Detail Body Issue',
        name: 'detailBodyIssue',
        desc: 'Detail Body Issue',
      );
}
