import 'package:masterclass_api/app/home/infra/model/anime_model.dart';
import 'package:masterclass_api/app/home/infra/repository/anime_repository.dart';

abstract class GetListAnimesContract {
  Future<List<AnimeModel>> call({required int page, required int perPage});
}

class GetListAnimes implements GetListAnimesContract {
  final AnimeRepositoryContract repository;
  const GetListAnimes(this.repository);

  @override
  Future<List<AnimeModel>> call(
      {required int page, required int perPage}) async {
    return await repository.getListAnimes(page: page, perPage: perPage);
  }
}
