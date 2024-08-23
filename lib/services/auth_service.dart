import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:dio/dio.dart';
import 'package:oneitsekiri_flutter/cache/token_cache.dart';
import 'package:oneitsekiri_flutter/models/api/api_error_states.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/models/tokens/token_model.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/shared/app_urls.dart';
import 'package:oneitsekiri_flutter/utils/enums.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/utils/extract_text.dart';
import 'package:oneitsekiri_flutter/utils/failure.dart';
import 'package:oneitsekiri_flutter/utils/network_errors.dart';
import 'package:oneitsekiri_flutter/utils/type_defs.dart';

class AuthService {
  final Ref? _ref;
  final Dio? _dio;
  final Dio dioWithNoInterceptor = Dio();
  AuthService({Dio? dio, Ref? ref})
      : _ref = ref,
        _dio = dio,
        super();
  //! sign up user
  FutureEither<String> signUpUser({
    required String email,
    required String password,
    required String fullName,
    required String nickname,
    required String gender,
    required File identification,
    required String phone,
  }) async {
    final Map<String, String> plainRequestBody = {
      "email": email,
      "password": password,
    };
    FormData requestBody = FormData.fromMap({
      "email": email,
      "phone_number": "+234$phone",
      "password": password,
      "full_name": fullName,
      "title": nickname,
      "gender": gender,
      if (identification.existsSync())
        'identification_document': await MultipartFile.fromFile(
          identification.path,
          filename: identification.path.split('/').last,
        ),
    });

    final result = makeApiRequest(
        ref: _ref,
        plainRequestBody: plainRequestBody,
        apiType: ApiType.signUp,
        endpoint: AppUrls.userSignUp,
        endpointName: "Sign up",
        requestBody: requestBody,
        dio: _dio ?? dioWithNoInterceptor);

    return result;
  }

  //! log in user
  FutureEither<String> loginUser({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> requestBody = {
      "email_or_phone_number": email,
      "password": password,
    };

    // ! MAKE REQUEST

    return makeApiRequest(
        ref: _ref,
        endpoint: AppUrls.userLogin,
        apiType: ApiType.signIn,
        endpointName: "Sign In",
        requestBody: requestBody,
        dio: _dio ?? dioWithNoInterceptor);
  }

  FutureEither<String> logOut() async {
    final Iterable<UserToken?> userTokens = await TokenCache.getUserTokens();
    if (userTokens.isEmpty) {
      return left(Failure('logOut: No user tokens found.'));
    }
    Map<String, dynamic> requestBody = {
      "refresh": userTokens.first?.refreshToken!,
    };
    return makeApiRequest(
        ref: _ref,
        endpoint: AppUrls.userLogOut,
        dio: _dio!,
        endpointName: "Log Out",
        apiType: ApiType.logOut,
        requestBody: requestBody);
  }

  //! get user data
  FutureEither<String> getUserData() async {
    return makeApiRequest(
        ref: _ref,
        method: HttpMethod.get,
        endpoint: AppUrls.getUserData,
        apiType: ApiType.getUserData,
        endpointName: "Get user data",
        dio: _dio ?? dioWithNoInterceptor);
  }

  FutureEither<String> requestSignUpOtp(String email) async {
    final requestBody = {
      "email": email,
    };
    final nestedApiNotifier = _ref?.read(nestedApiStateProvider.notifier);
    nestedApiNotifier?.setLoading(true);
    return makeApiRequest(
        apiType: ApiType.requestSignUpOtp,
        endpoint: AppUrls.requestSignUpOtp,
        requestBody: requestBody,
        dio: _dio ?? dioWithNoInterceptor);
  }

  FutureEither<String> verifySignUpOtp(
      {required String email, required String otp}) async {
    final requestBody = {
      "email": email,
      "otp": otp,
    };
    return makeApiRequest(
        apiType: ApiType.verifyOtp,
        endpoint: AppUrls.verifyOtp,
        requestBody: requestBody,
        ref: _ref,
        dio: _dio ?? dioWithNoInterceptor);
  }

  FutureEither<String> changePassword(String email, String newPassword) {
    final requestBody = {
      "email": email,
      "new_password": newPassword,
    };
    return makeApiRequest(
        ref: _ref,
        apiType: ApiType.changePassword,
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
        final newTokens = response?.data;

        if (newTokens['access'] == null) {
          'Invalid token response from server'.log();
          return null;
        }

        final newUserTokens = UserToken(
          refreshToken: newTokens['refresh'],
          accessToken: newTokens['access'],
        );

        await TokenCache.cacheUserTokens(tokens: newUserTokens);
        return newUserTokens.accessToken;
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
  final AuthService _authRepository;

  final Dio _dio;

  AuthInterceptor(this._authRepository, this._dio);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final Iterable<UserToken> tokens = await TokenCache.getUserTokens();
    final List<String> excludedPaths = ['login', 'signup', 'otp'];
    // "tokens: ${tokens.first.accessToken}".log();
    if (tokens.isNotEmpty &&
        tokens.first.accessToken != null &&
        !excludedPaths.any((path) => options.path.contains(path))) {
      options.headers['Authorization'] = 'Bearer ${tokens.first.accessToken}';
    } else {
      "No tokens found or options path contains excluded paths".log();
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
      final newTokens = await _authRepository.refreshToken();
      if (newTokens != null) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newTokens';
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
    if (err.response?.statusCode == 500) {
      return handler.next(err);
    }
    return handler.next(err);
  }
}

FutureEither<String> makeApiRequest(
    {required String endpoint,
    dynamic requestBody,
    Map<String, String>? plainRequestBody,
    required Dio dio,
    String? endpointName,
    required ApiType apiType,
    HttpMethod method = HttpMethod.post,
    Ref? ref}) async {
  try {
    Response<dynamic>? response;

    switch (method) {
      case HttpMethod.post:
        response = await dio.post(endpoint, data: requestBody);
        break;
      case HttpMethod.patch:
        response = await dio.patch(endpoint, data: requestBody);
        break;
      case HttpMethod.get:
        response = await dio.get(endpoint, queryParameters: requestBody);
        break;
      default:
        throw UnsupportedError('Method not supported');
    }
    Map<String, dynamic>? responseInMap = response.data;

    switch (response.statusCode) {
      case 200:
      case 201:
        switch (apiType) {
          case ApiType.signIn:
            await TokenCache.cacheUserTokens(
              tokens: UserToken(
                refreshToken: responseInMap?['token']?['refresh'],
                accessToken: responseInMap?['token']?['access'],
              ),
            );
            break;
          case ApiType.getUserData:
            UserModel registeredUser = UserModel.fromJSON(responseInMap!);
            ref?.watch(userProvider.notifier).state = registeredUser;
            break;
          case ApiType.logOut:
            await TokenCache.clearUserTokens();
          case ApiType.updateUserProfile:
            ref
                ?.read(userProvider.notifier)
                .update((state) => UserModel.fromJSON(responseInMap!));
          default:
            'Unknown apiType: $apiType'.log();
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
      dynamic errorMessage;
      if (response.data is Map<String, dynamic>) {
        final Map<String, dynamic> responseInMap = response.data;
        errorMessage = responseInMap["message"] ?? responseInMap;
        errorMessage = extractText(errorMessage);
      } else {
        errorMessage = extractText(response.data);
      }

      "$endpoint DioError Response: ${response.statusCode} \nResponse: $errorMessage"
          .log();
      return left(Failure(errorMessage));
    } else {
      "$endpoint DioError $dioError".log();
      return left(Failure('$endpoint DioError: $dioError'));
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
