import 'package:flutter/material.dart';
import 'package:oneitsekiri_flutter/screens/auth/otp_screen.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/choose_auth_route.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_up_screen.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_in_screen.dart';
import 'package:oneitsekiri_flutter/components/route_generators.dart.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/complete_registration_screen.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/continue_registration_screen.dart';
import 'package:oneitsekiri_flutter/screens/wrapper/base_nav_wrapper.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChooseAuthRoute.routeName:
      return MaterialPageRoute(builder: (_) => const ChooseAuthRoute());
    case SignInScreen.routeName:
      return NoAnimationRoute(page: SignInScreen());
    case SignupScreen.routeName:
      return NoAnimationRoute(page: SignupScreen());
    case OtpScreen.routeName:
      return MaterialPageRoute(builder: (_) => const OtpScreen());
    case BaseNavWrapper.routeName:
      return MaterialPageRoute(builder: (_) => const BaseNavWrapper());
    case ContinueRegistrationScreen.routeName:
      return MaterialPageRoute(builder: (_) => ContinueRegistrationScreen());
    case CompleteRegistrationScreen.routeName:
      return MaterialPageRoute(builder: (_) => CompleteRegistrationScreen());
    default:
      return null;
  }
}
