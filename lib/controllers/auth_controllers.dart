import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';

class FormNotifier extends StateNotifier<AuthFormState> {
  FormNotifier() : super(AuthFormState());

  // void setField(String field, dynamic value) {
  //   final fields = state.toJson();
  //   if (!fields.containsKey(field)) {
  //     throw ArgumentError('Invalid field: $field');
  //   }

  //   state = state.copyWith(
  //     email: field == 'email' ? value as String : state.email,
  //     password: field == 'password' ? value as String : state.password,
  //     phone: field == 'phone' ? value as int : state.phone,
  //     name: field == 'name' ? value as String : state.name,
  //     nickname: field == 'nickname' ? value as String : state.nickname,
  //     identification: field == 'identification' ? value as String : state.identification,
  //     gender: field == 'gender' ? value as String : state.gender,
  //     isLoading: field == 'isLoading' ? value as bool : state.isLoading,
  //     error: field == 'error' ? value as String? : state.error,
  //   );
  // }
  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setPhone(int phone) {
    state = state.copyWith(phone: phone);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void setIdentification(String identification) {
    state = state.copyWith(identification: identification);
  }

  void setGender(String password) {
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


class SignInNotifier extends StateNotifier<void> {
  SignInNotifier({required Ref ref})
      : _ref = ref,
        super(null);

  final Ref _ref;

  Future<void> signIn() async {
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
