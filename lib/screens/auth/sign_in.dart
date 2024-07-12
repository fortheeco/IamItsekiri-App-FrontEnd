import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/components/custom_app_bar.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/components/registration_section_tile.dart';
import 'package:oneitsekiri_flutter/components/custom_input_field.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_up.dart';

class SignInScreen extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static const String routeName = 'signIn';
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final signInNotifier = ref.read(signInProvider.notifier);
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: LayoutPadding(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          child: SectionTitle(
                            title: 'Erubo',
                            subtitle: 'Login to your account',
                          ),
                        ),
                        Image.asset(
                          'lib/assets/images/Itsekiri-second-Logo.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    16.sbH,
                    CustomInputField(
                        label: "Email or Phone number",
                        hintText: "Enter your email or phone number",
                        validatorText: "Enter your email or phone number",
                        onChanged: (value) => formNotifier.setEmail(value)),
                    16.sbH,
                    CustomInputField(
                        keyboardType: TextInputType.visiblePassword,
                        label: "Password",
                        hintText: "Enter your password",
                        validatorText: "Please Enter your password",
                        onChanged: (value) => formNotifier.setPassword(value)),
                    40.sbH,
                    Text(
                      "Forgot Password?",
                      style: AppTypography.bodyMediumBold
                          .copyWith(color: Palette.surface),
                    ).tap(onTap: () {}).alignCenterRight(),
                    49.sbH,
                    if (formState.isLoading) const CircularProgressIndicator(),
                    if (!formState.isLoading)
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              signInNotifier.signIn();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          child: const Text("Login")),
                    24.sbH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 116.0.w,
                          child: const Divider(
                            thickness: 3,
                            color: Palette.greyB,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.h),
                          child: Text(
                            'OR',
                            style: AppTypography.bodyMediumBold
                                .copyWith(color: Palette.greyA),
                          ),
                        ),
                        SizedBox(
                          width: 116.0.w,
                          child: const Divider(
                            thickness: 3,
                            color: Palette.greyB,
                          ),
                        ),
                      ],
                    ),
                    31.sbH,
                    ElevatedButton(
                        style: Theme.of(context)
                            .elevatedButtonTheme
                            .style
                            ?.copyWith(
                                backgroundColor: const MaterialStatePropertyAll(
                                    Palette.whiteA)),
                        onPressed: () {
                          Navigator.pushNamed(context, SignupScreen.routeName);
                        },
                        child: Text(
                          "Continue as guest",
                          style: AppTypography.redBodyMediumBold,
                        )),
                    151.sbH,
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Don’t have an account?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontFamily: "Inter"),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Create Account',
                              style: AppTypography.bodyLarge.copyWith(
                                  color: Palette.surface,
                                  fontFamily: "Inter",
                                  decoration: TextDecoration.underline,
                                  decorationColor: Palette.surface)),
                        ],
                      ),
                    ).tap(onTap: () {
                      Navigator.pushNamed(context, SignupScreen.routeName);
                    }),
                  ]),
            ),
          ),
        ));
  }
}
