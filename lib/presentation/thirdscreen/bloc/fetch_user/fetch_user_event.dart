part of 'fetch_user_bloc.dart';

@freezed
class FetchUserEvent with _$FetchUserEvent {
  const factory FetchUserEvent.started() = _Started;
  const factory FetchUserEvent.fetchUser(String page) = _FetchUser;
  const factory FetchUserEvent.loadMore(String page) = _loadMore;
  //refresh
  const factory FetchUserEvent.refresh(String page) = _Refresh;
}
