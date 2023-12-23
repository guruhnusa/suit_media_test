part of 'palindrome_bloc.dart';

@freezed
class PalindromeEvent with _$PalindromeEvent {
  const factory PalindromeEvent.started() = _Started;
  const factory PalindromeEvent.checkPalindrome(String value) = _CheckPalindrome;
}