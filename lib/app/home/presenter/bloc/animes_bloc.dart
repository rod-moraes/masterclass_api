import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masterclass_api/app/home/domain/usecases/anime_usecase.dart';
import 'package:masterclass_api/app/home/errors/server_exception.dart';
import 'package:masterclass_api/app/home/infra/model/anime_model.dart';
import 'package:masterclass_api/app/home/presenter/bloc/animes_event.dart';
import 'package:masterclass_api/app/home/presenter/bloc/animes_state.dart';

class AnimesBloc extends Bloc<AnimesEvent, AnimesState> {
  final GetListAnimesContract usecase;
  AnimesBloc(this.usecase) : super(const AnimesStateIdle()) {
    on<GetListAnimesEvent>(_getListAnimes);
    on<RefreshAnimesEvent>(_refreshListAnimes);
  }

  Future<void> _refreshListAnimes(
      RefreshAnimesEvent event, Emitter<AnimesState> emit) async {
    try {
      emit(const AnimesStateLoadingInitial(animes: []));
      final listAnime = await usecase(page: event.page, perPage: event.perPage);
      final list = <AnimeModel>[];
      list
        ..addAll(state.animes)
        ..addAll(listAnime);
      emit(AnimesStateSuccess(animes: list));
    } on ServerException catch (e) {
      emit(AnimesStateError(message: e.message));
    }
  }

  Future<void> _getListAnimes(
      GetListAnimesEvent event, Emitter<AnimesState> emit) async {
    try {
      emit(AnimesStateLoading(animes: state.animes));
      final listAnime = await usecase(page: event.page, perPage: event.perPage);
      final list = <AnimeModel>[];
      list
        ..addAll(state.animes)
        ..addAll(listAnime);
      emit(AnimesStateSuccess(animes: list));
    } on ServerException catch (e) {
      emit(AnimesStateError(message: e.message));
    }
  }
}
