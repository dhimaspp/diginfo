import 'dart:async';
import 'package:dio/dio.dart';

import 'package:diginfo/model/model_response.dart';
// ignore: unused_import
import 'package:flutter/foundation.dart';

class DiginfoRepository {
  static String mainUrl = "https://newsapi.org/v2";
  final String apiKey = "4cacb92f67d24ef0b02f956d7b764bbe";

  final Dio _dio = Dio();

  var getSumberUrl = "$mainUrl/sources";
  var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  Future<SumberResponse> getSumber(String category) async {
    var params = {
      "apiKey": apiKey,
      "language": "en",
      "country": "us",
      "category": category
    };

    try {
      Response response = await _dio.get(getSumberUrl, queryParameters: params);
      return SumberResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured:$error stacktrrace:$stacktrace");
      return SumberResponse.withError("$error");
    }
  }

  Future<ArtikelResponse> getTopHeadlinesGen() async {
    var params = {"apiKey": apiKey, "country": "id"};

    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArtikelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured:$error stacktrrace:$stacktrace");
      return ArtikelResponse.withError("$error");
    }
  }

  Future<ArtikelResponse> getTopHeadlinesCat(String category) async {
    var params = {"apiKey": apiKey, "country": "id", "category": category};

    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArtikelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured:$error stacktrrace:$stacktrace");
      return ArtikelResponse.withError("$error");
    }
  }

  Future<ArtikelResponse> search(String value) async {
    var params = {"apiKey": apiKey, "q": value, "sortBy": "relevancy"};
    var response = await _dio.delete(
      everythingUrl,
      data: value,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: params,
      ),
    );
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArtikelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArtikelResponse.withError("$error");
    }
  }

  Future<ArtikelResponse> getHotNews(String query) async {
    var params = {"apiKey": apiKey, "q": query, "sortBy": "popularity"};
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArtikelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArtikelResponse.withError("$error");
    }
  }

  Future<ArtikelResponse> getSumberBerita(String? sumberId) async {
    var params = {"apiKey": apiKey, "sources": sumberId};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArtikelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArtikelResponse.withError("$error");
    }
  }
}
