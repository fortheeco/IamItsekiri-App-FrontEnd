import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:oneitsekiri_flutter/cache/token_cache.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/models/tokens/token_model.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/shared/app_urls.dart';
import 'package:oneitsekiri_flutter/utils/enums.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/utils/failure.dart';
import 'package:oneitsekiri_flutter/utils/network_errors.dart';
import 'package:oneitsekiri_flutter/utils/type_defs.dart';

class AuthRepository {
  final Ref? _ref;
  final Dio? _dio;
  final Dio dioWithNoInterceptor = Dio();
  AuthRepository({Dio? dio, Ref? ref})
      : _ref = ref,
        _dio = dio,
        super();

  //! sign up user
  FutureEither<String> signUpUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String username,
  }) async {
    Map<String, dynamic> requestBody = {
      "password": password,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      'username': username,
    };

    return _makeApiRequest(
        endpoint: AppUrls.userSignUp,
        endpointName: "Sign up",
        requestBody: requestBody,
        dio: dioWithNoInterceptor);
  }

  //! log in user
  FutureEither<String> loginUser({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
    };
    // ! MAKE REQUEST

    return _makeApiRequest(
        endpoint: AppUrls.userLogin,
        apiType: ApiType.signIn,
        endpointName: "Sign In",
        requestBody: requestBody,
        dio: dioWithNoInterceptor);
  }

  FutureEither<String> logOut() async {
    final Iterable<UserToken?> userTokens = await TokenCache.getUserTokens();
    if (userTokens.isEmpty) {
      return left(Failure('logOut: No user tokens found.'));
    }
    Map<String, dynamic> requestBody = {
      "refresh": userTokens.first?.refreshToken!,
    };
    return _makeApiRequest(
        endpoint: AppUrls.userLogOut,
        dio: _dio!,
        endpointName: "Log Out",
        apiType: ApiType.logOut,
        requestBody: requestBody);
  }

  //! get user data
  Future<void> getUserData() async {
    try {
      final Response<dynamic> response = await _dio!.get(AppUrls.getUserData);
      Map<String, dynamic> responseInMap = response.data;

      switch (response.statusCode) {
        case 200 || 201:
          UserModel registeredUser = UserModel.fromJSON(responseInMap);
          _ref?.watch(userProvider.notifier).state = registeredUser;

        case 400:
          "GET user details Response Failure: $response".log();

        default:
          "Default GET user details Error Code: ${response.statusCode} \nResponse: $response, \nReason: ${response.statusMessage}"
              .log();
      }
    } catch (error) {
      "GET user details default Error ${error.toString()}".log();
    }
  }

  FutureEither<String> requestOtp(String email) async {
    final requestBody = {
      "email": email,
    };
    return _makeApiRequest(
        endpoint: AppUrls.requestOtp,
        requestBody: requestBody,
        dio: dioWithNoInterceptor);
  }

  FutureEither<String> verifyOtp(
      {required String email, required String otp}) async {
    final requestBody = {
      "email": email,
      "otp_code": otp,
    };
    return _makeApiRequest(
        endpoint: AppUrls.verifyOtp,
        requestBody: requestBody,
        dio: dioWithNoInterceptor);
  }

  FutureEither<String> changePassword(String email, String newPassword) {
    final requestBody = {
      "email": email,
      "new_password": newPassword,
    };
    return _makeApiRequest(
        endpoint: AppUrls.changePassword,
        requestBody: requestBody,
        dio: dioWithNoInterceptor);
  }

  Future<String?> refreshToken() async {
    try {
      final Iterable<UserToken?> tokens = await TokenCache.getUserTokens();
      if (tokens.isEmpty ||
          tokens.first == null ||
          tokens.first?.refreshToken == null) {
        'Refresh token is null or missing'.log();
        return null; // No valid token found
      }
      final response = await _dio?.post(AppUrls.refreshAccessToken, data: {
        'refresh': tokens.first?.refreshToken,
      });

      if (response?.statusCode == 200 && response?.data != null) {
        final newAccessToken = response?.data;

        if (newAccessToken['access'] == null) {
          'Invalid token response from server'.log();
          return null;
        }

        final newUserToken = UserToken(
          refreshToken: tokens.first!.refreshToken,
          accessToken: newAccessToken['access'],
        );

        await TokenCache.cacheUserTokens(tokens: newUserToken);
        return newUserToken.accessToken;
      } else {
        'Failed to refresh token: ${response?.statusCode}'.log();
        return null;
      }
    } catch (e) {
      'Exception during token refresh: $e'.log();
      return null;
    }
  }
}

class AuthInterceptor extends Interceptor {
  final AuthRepository _authRepository;

  final Dio _dio;

  AuthInterceptor(this._authRepository, this._dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final Iterable<UserToken> tokens = await TokenCache.getUserTokens();
    if (tokens.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${tokens.first.accessToken}';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 400) {
      "400 err.message: ${err.response?.data.toString()}".log();
    }
    if (err.response?.statusCode == 401) {
      final responseData = err.response?.data;
      "401 err.message: ${responseData.toString()}".log();
      if (responseData != null &&
          responseData['detail'] ==
              'No active account found with the given credentials') {
        return handler.next(err);
      }
      final newAccessToken = await _authRepository.refreshToken();
      if (newAccessToken != null) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final response = await _dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );
        return handler.resolve(response);
      }
    }
    return handler.next(err);
  }
}

FutureEither<String> _makeApiRequest({
  required String endpoint,
  Map<String, dynamic>? requestBody,
  required Dio dio,
  String? endpointName,
  ApiType? apiType,
}) async {
  try {
    // Make request

    Response<dynamic>? response = await dio.post(endpoint, data: requestBody);

    Map<String, dynamic>? responseInMap = response.data;

    switch (response.statusCode) {
      // Server request was successful
      case 200:
      case 201:
        if (apiType == ApiType.signIn) {
          await TokenCache.cacheUserTokens(
            tokens: UserToken(
              refreshToken: responseInMap?['refresh'],
              accessToken: responseInMap?['access'],
            ),
          );
        } else if (apiType == ApiType.logOut) {
          await TokenCache.clearUserTokens();
        }
        return right(responseInMap?["message"] ?? 'Success');
      case 400:
        "$endpoint Response Failure: ${response.statusMessage}".log();
        return left(Failure(responseInMap?["message"] ?? "Request failed"));

      default:
        "$endpoint Error Code: ${response.statusCode} \nResponse: $response, \nReason: ${response.statusMessage}"
            .log();
        return left(Failure(responseInMap?["message"] ?? "Request failed"));
    }
  } on DioException catch (dioError) {
    final response = dioError.response;

    if (response != null) {
      // Try to extract a detailed error message from the response
      String errorMessage;
      if (response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseInMap = response.data;
        errorMessage = responseInMap["message"] ?? responseInMap.toString();
      } else {
        errorMessage = response.data.toString();
      }

      // Log the error
      "$endpoint DioError Response: ${response.statusCode} \nResponse: $errorMessage"
          .log();

      // Return the detailed error message
      return left(Failure(errorMessage));
    } else {
      "$endpoint DioError ${dioError.message}".log();
      return left(Failure('$endpoint DioError: ${dioError.message}'));
    }
  } on SocketException catch (error) {
    "$endpointName Socket Exception ${error.message.toString()}".log();
    throw left(Failure(NetworkErrors.socketException));
  } on FormatException catch (error) {
    "$endpointName Format Exception ${error.message.toString()}".log();
    throw left(Failure(NetworkErrors.formatException));
  } on HttpException catch (error) {
    "$endpointName Http Exception ${error.message.toString()}".log();
    throw left(Failure(NetworkErrors.httpException));
  } catch (error) {
    "$endpointName Error ${error.toString()}".log();
    return left(Failure('$endpoint error: ${error.toString()}'));
  }
}
