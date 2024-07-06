import 'package:flutter/material.dart';
import 'package:oneitsekiri_flutter/screens/introduction/choose_auth_route.dart';
import 'package:oneitsekiri_flutter/screens/auth/create_account.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const ChooseAuthRoute(),
  '/register': (context) => SignupScreen(),
};
