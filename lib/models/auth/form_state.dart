class AuthFormState {
  final String email;
  final String password;
  final int phone;
  final String name;
  final String nickname;
  final String identification;
  final String gender;
  final bool isLoading;
  final String? error;

  AuthFormState({
    this.phone = 0,
    this.name = '',
    this.nickname = '',
    this.identification = '',
    this.gender = '',
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.error,
  });

  AuthFormState copyWith({
    String? email,
    String? password,
    bool? isLoading,
    String? error,
    int? phone,
    String? name,
    String? nickname,
    String? identification,
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
      error: error ?? this.error,
    );
  }
}
