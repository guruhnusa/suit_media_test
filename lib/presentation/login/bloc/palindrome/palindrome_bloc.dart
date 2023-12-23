import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'palindrome_event.dart';
part 'palindrome_state.dart';
part 'palindrome_bloc.freezed.dart';

class PalindromeBloc extends Bloc<PalindromeEvent, PalindromeState> {
  PalindromeBloc() : super(const _Initial()) {
    on<_CheckPalindrome>((event, emit) {
      emit(const _Loading());
      final originalValue =
          event.value.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
      final reversedValue = originalValue.split('').reversed.join();

      if (originalValue == reversedValue) {
        emit(const _Success('isPalindrome'));
      } else {
        emit(const _Error('not palindrome'));
      }
    });
  }
}
