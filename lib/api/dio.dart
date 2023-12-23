import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Dioプロバイダー
final dioProvider = Provider((ref) {
  final dio = Dio();
  // // APIトークンを設定
  // const apiToken = String.fromEnvironment('API_TOKEN');
  // if (apiToken.isNotEmpty) {
  //   dio.options.headers['Authorization'] = 'token $apiToken';
  // }
  return dio;
});
