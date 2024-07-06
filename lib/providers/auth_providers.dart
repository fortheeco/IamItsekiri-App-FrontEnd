import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/controllers/auth_controllers.dart';

final formProvider =
    StateNotifierProvider<FormNotifier, AuthFormState>((ref) => FormNotifier());

final signupProvider = StateNotifierProvider<SignupNotifier, void>(
    (ref) => SignupNotifier(ref: ref));