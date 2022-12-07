import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masterclass_api/app/home/domain/usecases/anime_usecase.dart';
import 'package:masterclass_api/app/home/external/datasource/anime_datasource.dart';
import 'package:masterclass_api/app/home/infra/model/anime_model.dart';
import 'package:masterclass_api/app/home/infra/repository/anime_repository.dart';

void main() {
  test("Listagem de animes", () async {
    final Dio dio = Dio();
    final AnimeDatasourceContract datasource = AnimeDatasource(dio: dio);
    final AnimeRepositoryContract repository =
        AnimeRepository(datasource: datasource);
    final GetListAnimesContract usecase = GetListAnimes(repository);

    final list = await usecase(page: 1, perPage: 10);
    expect(list.length, 10);
    expect(list.runtimeType, List<AnimeModel>);
  });
}
