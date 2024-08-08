import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/components/custom_app_bar.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/components/spanned_text.dart';
import 'package:oneitsekiri_flutter/utils/enums.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/components/registration_section_tile.dart';
import 'package:oneitsekiri_flutter/components/custom_input_field.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_up.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
              child: Form(
                key: _formKey,
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
                          customValidator: true,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(
                                errorText: "Enter a valid email"),
                            (value) {
                              if (value!.contains(RegExp(r'^[0-9]+$')) &&
                                  value.length != 10) {
                                return "Enter a valid phone number";
                              }
                              return null;
                            }
                          ]),
                          onChanged: (value) {
                            if (value.contains(RegExp(r'^[0-9]+$'))) {
                              final phoneNumber = int.tryParse(value) ?? 0;
                              formNotifier.setPhone(phoneNumber);
                            } else {
                              formNotifier.setEmail(value);
                            }
                          }),
                      16.sbH,
                      CustomInputField(
                          inputType: InputType.password,
                          keyboardType: TextInputType.visiblePassword,
                          label: "Password",
                          hintText: "Enter your password",
                          validatorText: "Please Enter your password",
                          onChanged: (value) =>
                              formNotifier.setPassword(value)),
                      40.sbH,
                      Text(
                        "Forgot Password?",
                        style: AppTypography.bodyMediumBold
                            .copyWith(color: Palette.surface),
                      ).tap(onTap: () {}).alignCenterRight(),
                      49.sbH,
                      if (formState.isLoading)
                        const CircularProgressIndicator(),
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
                      const CustomDivider(),
                      31.sbH,
                      const WhiteButton(),
                      151.sbH,
                      const SpannedText(
                        before: 'Don’t have an account?',
                        after: ' Create Account',
                      ).tap(onTap: () {
                        Navigator.popAndPushNamed(
                            context, SignupScreen.routeName);
                      }),
                    ]),
              ),
            ),
          ),
        ));
  }
}

class WhiteButton extends StatelessWidget {
  const WhiteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: const WidgetStatePropertyAll(Palette.whiteA)),
        onPressed: () {
          Navigator.popAndPushNamed(context, SignupScreen.routeName);
        },
        child: Text(
          "Continue as guest",
          style: AppTypography.redBodyMediumBold,
        ));
  }
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
            style: AppTypography.bodyMediumBold.copyWith(color: Palette.greyA),
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
    );
  }
}
