import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/controllers/auth_controllers.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final formProvider =
    StateNotifierProvider<FormNotifier, AuthFormState>((ref) => FormNotifier());

final signupProvider = StateNotifierProvider<SignupNotifier, void>(
    (ref) => SignupNotifier(ref: ref));

final signInProvider = StateNotifierProvider<SignInNotifier, void>(
    (ref) => SignInNotifier(ref: ref));
