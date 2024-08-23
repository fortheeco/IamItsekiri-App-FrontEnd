import 'dart:io';

class AuthFormState {
  final String email;
  final String password;
  final String phone;
  final String name;
  final String nickname;
  final File identification;
  final String gender;
  final bool isLoading;
  final String? errorMessage;

  AuthFormState({
    this.phone = '',
    this.name = '',
    this.nickname = '',
    required this.identification,
    this.gender = '',
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.errorMessage,
  });

  AuthFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? errorMessage,
    String? phone,
    String? name,
    String? nickname,
    File? identification,
    String? gender,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      nickname: nickname ?? this.nickname,
      identification: identification ?? this.identification,
      gender: gender ?? this.gender,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
