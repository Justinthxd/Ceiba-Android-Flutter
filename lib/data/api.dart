import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class Api {
  // Get the data from the API
  Future<dynamic> get() async {
    String url = 'https://jsonplaceholder.typicode.com/users';
    try {
      http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        // json decode

        final response = json.decode(res.body);

        return response;
      } else {
        throw Exception("statusCode: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Get the data from the API or from the cache
  Future getWithCache() async {
    DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
    Options cacheOptions = buildCacheOptions(const Duration(days: 7));
    Dio dio = Dio();
    dio.interceptors.add(dioCacheManager.interceptor);
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/users',
      options: cacheOptions,
    );
    return response.data;
  }

  Future getUserInfoWithCache(int id) async {
    DioCacheManager dioCacheManager = DioCacheManager(CacheConfig());
    Options cacheOptions = buildCacheOptions(const Duration(days: 7));
    Dio dio = Dio();
    dio.interceptors.add(dioCacheManager.interceptor);
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts?userId=$id',
      options: cacheOptions,
    );
    return response.data;
  }
}
