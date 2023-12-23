part of 'palindrome_bloc.dart';

@freezed
class PalindromeState with _$PalindromeState {
  const factory PalindromeState.initial() = _Initial;
  const factory PalindromeState.loading() = _Loading;
  const factory PalindromeState.success(String message) = _Success;
  const factory PalindromeState.error(String message) = _Error;
}
