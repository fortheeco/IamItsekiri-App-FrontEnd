import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/cache/token_cache.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/controllers/auth_controllers.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/models/tokens/token_model.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/choose_auth_route.dart';
import 'package:oneitsekiri_flutter/services/auth_service.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final Provider<Dio> dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  return dio;
});

// AuthService provider
final Provider<AuthService> authServiceAuthServiceProvider =
    Provider<AuthService>((ref) {
  final dio = ref.read(dioProvider);
  return AuthService(ref: ref, dio: dio);
});

final Provider<AuthService> authServiceAuthServiceWithdioInterceptorProvider =
    Provider<AuthService>((ref) {
  final Dio dio = ref.read(dioProvider);
  final AuthService authServiceAuthService =
      ref.read(authServiceAuthServiceProvider);
  dio.interceptors.add(AuthInterceptor(authServiceAuthService, dio));
  return AuthService(ref: ref, dio: dio);
});

//! the auth controller provider=
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthFormState>(
  (ref) {
    final authServiceAuthService =
        ref.read(authServiceAuthServiceWithdioInterceptorProvider);
    return AuthController(
      authService: authServiceAuthService,
      ref: ref,
    );
  },
);

final checkTokenProvider = FutureProvider<Widget>((ref) async {
  Iterable<UserToken?> userToken = await TokenCache.getUserTokens();
  // TokenCache.clearUserTokens();
  if (userToken.isEmpty) {
    return const ChooseAuthRoute();
  } else {
    "userToken is not empty: ".log();
    await ref
        .read(authServiceAuthServiceWithdioInterceptorProvider)
        .getUserData();
    return const Placeholder();
  }
});
