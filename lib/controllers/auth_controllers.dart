import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';

class FormNotifier extends StateNotifier<AuthFormState> {
  FormNotifier() : super(AuthFormState());

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }
}

class SignupNotifier extends StateNotifier<void> {
  SignupNotifier({required Ref ref})
      : _ref = ref,
        super(null);

  final Ref _ref;

  Future<void> signup() async {
    final formState = _ref.read(formProvider);

    if (formState.email.isEmpty || formState.password.isEmpty) {
      _ref.read(formProvider.notifier).setError('Please fill in all fields');
      return;
    }

    _ref.read(formProvider.notifier).setLoading(true);

    try {
      await Future.delayed(const Duration(seconds: 2));
      // Perform signup logic (e.g., API call)
      // If successful, navigate to another screen or update state
    } catch (error) {
      _ref.read(formProvider.notifier).setError('Signup failed');
    } finally {
      _ref.read(formProvider.notifier).setLoading(false);
    }
  }
}


