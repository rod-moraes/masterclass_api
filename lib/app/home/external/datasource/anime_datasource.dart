import 'package:dio/dio.dart';

import 'package:masterclass_api/app/home/errors/server_exception.dart';

abstract class AnimeDatasourceContract {
  Future<List<dynamic>> getListAnimes(
      {required int page, required int perPage});
}

class AnimeDatasource implements AnimeDatasourceContract {
  final Dio dio;
  const AnimeDatasource({required this.dio});
  final host = 'https://www.intoxianime.com/?rest_route=/wp/v2/posts';

  @override
  Future<List<dynamic>> getListAnimes(
      {required int page, required int perPage}) async {
    try {
      final response = await dio.get(host, queryParameters: {
        'page': page,
        'per_page': perPage,
      });
      if (response.statusCode != 200) {
        throw ServerException(message: "Erro na busca!!!");
      }
      return response.data;
    } on DioError catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
