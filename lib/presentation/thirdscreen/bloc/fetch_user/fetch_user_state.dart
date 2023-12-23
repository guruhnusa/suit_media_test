part of 'fetch_user_bloc.dart';

@freezed
class FetchUserState with _$FetchUserState {
  const factory FetchUserState.initial() = _Initial;
  const factory FetchUserState.loading() = _Loading;
  const factory FetchUserState.success(List<Data> data) = _Success;
  const factory FetchUserState.error(String message) = _Error;
}
