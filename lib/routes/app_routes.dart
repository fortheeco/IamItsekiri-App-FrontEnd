import 'package:flutter/material.dart';
import 'package:oneitsekiri_flutter/screens/introduction/choose_auth_route.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_up.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_in.dart';
import 'package:oneitsekiri_flutter/components/route_generators.dart.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const ChooseAuthRoute());
    case SignInScreen.routeName:
      return NoAnimationRoute(page: SignInScreen());
    case SignupScreen.routeName:
      return NoAnimationRoute(page: SignupScreen());
    default:
      return null;
  }
}
