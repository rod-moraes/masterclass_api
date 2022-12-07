import 'package:masterclass_api/app/home/errors/server_exception.dart';
import 'package:masterclass_api/app/home/external/datasource/anime_datasource.dart';
import 'package:masterclass_api/app/home/infra/model/anime_model.dart';

abstract class AnimeRepositoryContract {
  Future<List<AnimeModel>> getListAnimes(
      {required int page, required int perPage});
}

class AnimeRepository implements AnimeRepositoryContract {
  final AnimeDatasourceContract datasource;
  const AnimeRepository({required this.datasource});

  @override
  Future<List<AnimeModel>> getListAnimes(
      {required int page, required int perPage}) async {
    try {
      final response =
          await datasource.getListAnimes(page: page, perPage: perPage);
      return response.map((e) => AnimeModel.fromMap(e)).toList();
    } on ServerException {
      rethrow;
    }
  }
}
