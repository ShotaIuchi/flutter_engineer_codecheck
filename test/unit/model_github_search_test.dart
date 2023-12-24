import 'package:dio/dio.dart';
import 'package:flutter_engineer_codecheck/api/api_search.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('[Api][GitHub][Search]呼び出し', () async {
    final api = ApiSearch(Dio());
    await api.search('flutter', 1);
  });
}
