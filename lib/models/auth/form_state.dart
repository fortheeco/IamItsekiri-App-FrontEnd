class AuthFormState {
  final String email;
  final String password;
  final bool isLoading;
  final String? error;

  AuthFormState({
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
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}