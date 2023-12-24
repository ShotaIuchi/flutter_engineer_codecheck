import 'package:dio/dio.dart';
import 'package:flutter_engineer_codecheck/api/dio.dart';
import 'package:flutter_engineer_codecheck/api/model/github/search/search_response.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

part 'api_search.g.dart';

/// 検索API
final apiSearchProvider = Provider(ApiSearch.di);

/// 検索API
@RestApi(baseUrl: 'https://api.github.com')
abstract class ApiSearch {
  /// コンストラクタ
  /// [dio] Dio
  /// [baseUrl] ベースURL
  factory ApiSearch(Dio dio, {String baseUrl}) = _ApiSearch;

  /// DIによるコンストラクタ
  /// [ref] ProviderRef
  factory ApiSearch.di(ProviderRef<void> ref) =>
      ApiSearch(ref.read(dioProvider));

  /// リポジトリ検索
  /// [query] 検索クエリ
  /// [page] ページ
  @GET('/search/repositories')
  Future<SearchResponse> search(
    @Query('q') String query,
    @Query('page') int page,
  );
}
