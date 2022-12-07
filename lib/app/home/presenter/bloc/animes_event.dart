abstract class AnimesEvent {}

class GetListAnimesEvent implements AnimesEvent {
  final int page;
  final int perPage;
  const GetListAnimesEvent({required this.page, required this.perPage});
}

class RefreshAnimesEvent implements AnimesEvent {
  final int page;
  final int perPage;
  const RefreshAnimesEvent({required this.page, required this.perPage});
}
