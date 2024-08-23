import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/screens/auth/otp_screen.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/choose_auth_route.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/continue_registration_screen.dart';
import 'package:oneitsekiri_flutter/screens/wrapper/base_nav_wrapper.dart';
import 'package:oneitsekiri_flutter/services/auth_service.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/utils/failure.dart';
import 'package:oneitsekiri_flutter/utils/nav.dart';
import 'package:oneitsekiri_flutter/utils/snack_bar.dart';
import 'package:oneitsekiri_flutter/utils/type_defs.dart';

class AuthController extends StateNotifier<AuthFormState> {
  final AuthService _authService;
  // ignore: unused_field
  final Ref _ref;
  AuthController({required AuthService authService, required Ref ref})
      : _authService = authService,
        _ref = ref,
        super(AuthFormState(identification: File("")));

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setNickname(String nickname) {
    state = state.copyWith(nickname: nickname);
  }

  void setIdentification(File identification) {
    state = state.copyWith(identification: identification);
  }

  void setGender(String gender) {
    state = state.copyWith(gender: gender);
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setError(String? error) {
    state = state.copyWith(errorMessage: error);
  }

  //! sign up user
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String fullName,
    required String nickname,
    required String gender,
    required String phone,
    required File identification,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: "");
    try {
      final response = await _authService.signUpUser(
        email: email,
        password: password,
        fullName: fullName,
        nickname: nickname,
        gender: gender,
        identification: identification,
        phone: phone,
      );

      response.fold(
        (Failure l) {
          state = state.copyWith(isLoading: false, errorMessage: l.message);
          showBanner(
            theMessage: l.message,
            theType: NotificationType.failure,
          );
        },
        (String result) {
          state = state.copyWith(isLoading: true, errorMessage: "");
          requestSignUpOtp(context: context, email: email);
        },
      );
    } catch (err) {
      rethrow;
    }
  }

  // //! login user
  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: "");

    try {
      final response = await _authService.loginUser(
        email: email,
        password: password,
      );
      response.fold(
        (Failure l) {
          state = state.copyWith(isLoading: false, errorMessage: l.message);
          if (state.errorMessage != null &&
              state.errorMessage!.contains("User account is not verified")) {
            showBanner(
              theMessage: "User account is not verified",
              theType: NotificationType.failure,
            );
            requestSignUpOtp(email: email, context: context);
          } else {
            showBanner(
              theMessage: l.message,
              theType: NotificationType.failure,
            );
          }
        },
        (String result) {
          state = state.copyWith(errorMessage: "");
          getUserData(context);
        },
      );
    } catch (err) {
      err.log();
      rethrow;
    }
  }

  Future<void> getUserData(BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: "");
    final response = await _authService.getUserData();

    response.fold(
      (Failure l) {
        state = state.copyWith(isLoading: false, errorMessage: l.message);
        showBanner(
          theMessage: l.message,
          theType: NotificationType.failure,
        );
      },
      (String result) {
        UserModel? userprovider = _ref.read(userProvider);
        if (userprovider == null) {
          state = state.copyWith(isLoading: false, errorMessage: "");
          showBanner(
            theMessage: "An error occurred",
            theType: NotificationType.failure,
          );
          return;
        } else {
          userprovider.state != null
              ? goTo(
                  context: context,
                  view: BaseNavWrapper.routeName,
                  replace: true)
              : goTo(
                  context: context,
                  view: ContinueRegistrationScreen.routeName,
                  replace: true);
          state = state.copyWith(isLoading: false, errorMessage: "");
        }
      },
    );
  }

  Future<void> logOut(BuildContext context) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final response = await _authService.logOut();

    response.fold(
      (Failure l) {
        state = state.copyWith(isLoading: false, errorMessage: l.message);
        showBanner(
          theMessage: l.message,
          theType: NotificationType.failure,
        );
      },
      (String result) {
        state = state.copyWith(isLoading: false);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ChooseAuthRoute()),
          (Route<dynamic> route) => false,
        );
      },
    );
  }

  Future<void> requestSignUpOtp({
    required BuildContext context,
    required String email,
    bool? view = true,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: "", email: email);
    final response = await _authService.requestSignUpOtp(email);
    response.fold(
      (Failure l) {
        state = state.copyWith(isLoading: false, errorMessage: l.message);
        showBanner(
          theMessage: l.message,
          theType: NotificationType.failure,
        );
      },
      (String result) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: "",
        );
        view != null && view
            ? goTo(context: context, view: OtpScreen.routeName)
            : null;
      },
    );
  }

  Future<void> verifySignUpOtp({
    required BuildContext context,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: "");
    final response =
        await _authService.verifySignUpOtp(email: state.email, otp: otp);

    response.fold(
      (Failure l) {
        state = state.copyWith(isLoading: false, errorMessage: l.message);
        showBanner(
          theMessage: l.message,
          theType: NotificationType.failure,
        );
      },
      (String result) {
        state = state.copyWith(
          isLoading: true,
          errorMessage: "",
        );
        loginUser(
            email: state.email, password: state.password, context: context);
      },
    );
  }

  Future<void> changePassword({
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final response =
        await _authService.changePassword(state.email, newPassword);

    response.fold(
      (Failure l) {
        state = state.copyWith(isLoading: false, errorMessage: l.message);
      },
      (String result) {
        state = state.copyWith(isLoading: false, email: "");
      },
    );
  }
}
