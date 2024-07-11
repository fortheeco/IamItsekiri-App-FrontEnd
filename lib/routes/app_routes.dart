import 'package:flutter/material.dart';
import 'package:oneitsekiri_flutter/screens/introduction/choose_auth_route.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_up.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_in.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const ChooseAuthRoute(),
  SignupScreen.routeName: (context) => SignupScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
};
