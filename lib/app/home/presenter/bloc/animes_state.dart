import 'package:masterclass_api/app/home/infra/model/anime_model.dart';

class AnimesState {
  final List<AnimeModel> animes;
  const AnimesState({this.animes = const []});
}

class AnimesStateIdle extends AnimesState {
  const AnimesStateIdle({super.animes = const []});
}

class AnimesStateLoadingInitial extends AnimesState {
  const AnimesStateLoadingInitial({super.animes});
}

class AnimesStateLoading extends AnimesState {
  const AnimesStateLoading({super.animes});
}

class AnimesStateError extends AnimesState {
  final String message;
  const AnimesStateError({required this.message, super.animes});
}

class AnimesStateSuccess extends AnimesState {
  const AnimesStateSuccess({super.animes});
}
