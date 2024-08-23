import 'package:flutter_riverpod/flutter_riverpod.dart';

class NestedApiState {
  final String? signUpOtpError;
  final String? signInError;
  final String? getUserError;
  final bool isLoading;
  final String? err;

  NestedApiState(
      {this.signUpOtpError,
      this.err,
      this.isLoading = true,
      this.signInError,
      this.getUserError});
}

final nestedApiStateProvider =
    StateNotifierProvider<NestedApiNotifier, NestedApiState>((ref) {
  return NestedApiNotifier();
});

class NestedApiNotifier extends StateNotifier<NestedApiState> {
  NestedApiNotifier() : super(NestedApiState());

  void setNestedSignUpOtpError(String message) {
    state = NestedApiState(signUpOtpError: message);
  }

  void setNestedSignInError(String message) {
    state = NestedApiState(signInError: message);
  }

  void setNestedGetUserError(String message) {
    state = NestedApiState(getUserError: message);
  }

  void setError(String message) {
    state = NestedApiState(err: message);
  }

  void setLoading(bool value) {
    state = NestedApiState(isLoading: value);
  }

  void clearErrors() {
    state = NestedApiState();
  }
}
