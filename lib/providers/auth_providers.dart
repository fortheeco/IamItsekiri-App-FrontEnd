import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/cache/token_cache.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/controllers/auth_controllers.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/models/tokens/token_model.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/choose_auth_route.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/continue_registration_screen.dart';
import 'package:oneitsekiri_flutter/screens/wrapper/base_nav_wrapper.dart';
import 'package:oneitsekiri_flutter/services/auth_service.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final Provider<Dio> dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  return dio;
});

// AuthService provider
final Provider<AuthService> plainAuthServiceProvider =
    Provider<AuthService>((ref) {
  final dio = ref.read(dioProvider);
  return AuthService(ref: ref, dio: dio);
});

final Provider<AuthService> authServiceWithdioInterceptorProvider =
    Provider<AuthService>((ref) {
  final Dio dio = ref.read(dioProvider);
  final AuthService authService = ref.read(plainAuthServiceProvider);
  dio.interceptors.add(AuthInterceptor(authService, dio));
  return AuthService(ref: ref, dio: dio);
});

//! the auth controller provider=
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthFormState>(
  (ref) {
    final authService = ref.read(authServiceWithdioInterceptorProvider);
    return AuthController(
      authService: authService,
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
    "userToken is not empty".log();
    await ref.read(authServiceWithdioInterceptorProvider).getUserData();
    final user = ref.read(userProvider);
    if (user?.state != null) {
      return const BaseNavWrapper();
    } else {
      return ContinueRegistrationScreen();
    }
  }
});

// final checkToken = FutureProvider<String?>((ref) async {
//   Iterable<UserToken?> userToken = await TokenCache.getUserTokens();
//   if (userToken.isEmpty && userToken.first?.accessToken == null) {
//     return "";
//   } else {
//     "userToken is not empty: ${userToken.first}".log();
//     await ref.read(authServiceWithdioInterceptorProvider).getUserData();
//     return userToken.first?.accessToken;
//   }
// });


// void getUserData () async {
  
//     await ref.read(authServiceWithdioInterceptorProvider).getUserData();
// }