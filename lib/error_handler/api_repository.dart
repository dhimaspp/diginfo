import 'package:diginfo/error_handler/api_result.dart';
import 'package:diginfo/error_handler/network_exceptions.dart';
import 'package:diginfo/model/artikel.dart';
import 'package:diginfo/model/sumber.dart';
import 'package:diginfo/model_v2/model_response.dart';
import 'package:dio/dio.dart';
import 'package:diginfo/error_handler/dio_client.dart';
import 'package:diginfo/model/model_response.dart';

class ApiRepository {
  DioClient dioClientSumber;
  DioClient dioClientTopHeadline;
  DioClient dioClientEverything;
  final String _apiKey = "4cacb92f67d24ef0b02f956d7b764bbe";
  Map<String, ApiResult<ArtikelResponseV3>> cache;

  String _getSumberUrl = "https://newsapi.org/v2/sources";
  String _getTopHeadlinesUrl = "https://newsapi.org/v2/top-headlines";
  String _everythingUrl = "https://newsapi.org/v2/everything";

  ApiRepository() {
    var dio = Dio();
    dioClientSumber = DioClient(_getSumberUrl, dio);
    dioClientTopHeadline = DioClient(_getTopHeadlinesUrl, dio);
    dioClientEverything = DioClient(_everythingUrl, dio);
  }

  Future<ApiResult<ArtikelResponseV3>> search(String term) async {
    if (cache.containsKey(term)) {
      return cache[term];
    } else {
      final result = await getSearch2(term);
      cache[term] = result;
      return result;
    }
  }

  Future<ApiResult<ArtikelResponseV3>> getSearch2(String value) async {
    var params = {"apiKey": _apiKey, "q": value, "sortBy": "relevancy"};

    try {
      Response response = await dioClientEverything.get(_everythingUrl,
          queryParameters: params);
      // List<Artikel> artikelList = ArtikelResponseV3.fromJson(response).artikel;
      return ApiResult.success(data: ArtikelResponseV3.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<ArtikelResponseV3>> getHotNews2(String query) async {
    var params = {"apiKey": _apiKey, "q": query, "sortBy": "popularity"};

    try {
      final response = await dioClientEverything.get(_everythingUrl,
          queryParameters: params);
      // List<Artikel> artikelList = ArtikelResponseV3.fromJson(response).items;
      return ApiResult.success(data: ArtikelResponseV3.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<ArtikelResponseV3>> getSumberBerita2(String sumberId) async {
    var params = {"apiKey": _apiKey, "sources": sumberId};

    try {
      final response = await dioClientTopHeadline.get(_getTopHeadlinesUrl,
          queryParameters: params);
      // List<Artikel> artikelList = ArtikelResponseV3.fromJson(response).items;
      return ApiResult.success(data: ArtikelResponseV3.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<ArtikelResponseV3>> getTopHeadlinesGen2() async {
    var params = {"apiKey": _apiKey, "country": "id"};

    try {
      final response = await dioClientTopHeadline.get(_getTopHeadlinesUrl,
          queryParameters: params);
      // List<Artikel> artikelList = ArtikelResponseV3.fromJson(response).items;
      return ApiResult.success(data: ArtikelResponseV3.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<ArtikelResponseV3>> getTopHeadlinesCat2(
      String category) async {
    var params = {"apiKey": _apiKey, "country": "id", "category": category};

    try {
      final response = await dioClientTopHeadline.get(_getTopHeadlinesUrl,
          queryParameters: params);
      // List<Artikel> artikelList = ArtikelResponseV3.fromJson(response).items;
      return ApiResult.success(data: ArtikelResponseV3.fromJson(response.data));
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }

  Future<ApiResult<List<Sumber>>> getSumber2(String category) async {
    var params = {
      "apiKey": _apiKey,
      "language": "en",
      "country": "us",
      "category": category
    };

    try {
      final response =
          await dioClientSumber.get(_getSumberUrl, queryParameters: params);
      List<Sumber> sumberList = SumberResponseV2.fromJson(response).sumber;
      return ApiResult.success(data: sumberList);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
