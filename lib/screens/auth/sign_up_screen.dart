import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/components/circular_loader.dart';
import 'package:oneitsekiri_flutter/components/custom_app_bar.dart';
import 'package:oneitsekiri_flutter/components/file_picker_form_field.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/screens/auth/otp_screen.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/components/registration_section_tile.dart';
import 'package:oneitsekiri_flutter/components/custom_input_field.dart';
import 'package:oneitsekiri_flutter/components/custom_dropdwon.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_in_screen.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/utils/enums.dart';
import 'package:oneitsekiri_flutter/utils/nav.dart';

class SignupScreen extends ConsumerWidget {
  static const String routeName = "signUp";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> genderItems = [
    'male',
    'female',
  ];

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    AuthFormState formState = ref.watch(authControllerProvider);
    final signupNotifier = ref.watch(authControllerProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: LayoutPadding(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SectionTitle(
                      title: 'Create an account',
                      subtitle: 'Become a member of our community',
                    ),
                    32.sbH,
                    CustomInputField(
                      label: 'Full Name',
                      hintText: 'John Martins',
                      validatorText: 'Please enter your name',
                      onChanged: (value) => signupNotifier.setName(value),
                      inputType: InputType.name,
                    ),
                    16.sbH,
                    CustomInputField(
                      keyboardType: TextInputType.phone,
                      label: 'Phone number',
                      hintText: '+234 | enter your phone number',
                      validatorText: 'Please enter your phone number',
                      onChanged: (value) {
                        signupNotifier.setPhone(value);
                      },
                      inputType: InputType.phone,
                    ),
                    16.sbH,
                    CustomInputField(
                      keyboardType: TextInputType.emailAddress,
                      label: 'Email Address',
                      hintText: 'example@email.com',
                      validatorText: 'Please enter your email',
                      onChanged: (value) => signupNotifier.setEmail(value),
                      inputType: InputType.email,
                    ),
                    16.sbH,
                    CustomDropdown(
                      label: 'Gender',
                      items: genderItems,
                      hintText: 'Select your gender',
                      validatorText: 'Please select your gender',
                      onChanged: (value) {
                        return signupNotifier.setGender(value ?? "null");
                      },
                    ),
                    16.sbH,
                    CustomInputField(
                      label: 'Nickname or Tittle (optional)',
                      customValidator: true,
                      hintText: 'What are you popularly called?',
                      validatorText: 'Please enter your nickname',
                      onChanged: (value) => signupNotifier.setNickname(value),
                      inputType: InputType.name,
                    ),
                    16.sbH,
                    CustomInputField(
                      label: 'Create a password',
                      hintText: 'Must be at least 8 characters',
                      onChanged: (value) => signupNotifier.setPassword(value),
                      inputType: InputType.password,
                    ),
                    16.sbH,
                    FilePickerFormField(
                      label:
                          "Upload Identification (NIN,L.G.A Certificate, e.t.c;)",
                      onFilePicked: (file) {
                        signupNotifier.setIdentification(file ?? File(""));
                      },
                    ),
                    61.sbH,
                    if (formState.isLoading) const CircularLoader(),
                    if (!formState.isLoading)
                      ElevatedButton(
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          // signupNotifier.signUpUser(
                          //   context: context,
                          //   email: formState.email,
                          //   phone: formState.phone,
                          //   password: formState.password,
                          //   fullName: formState.name,
                          //   nickname: formState.nickname,
                          //   gender: formState.gender,
                          //   identification: formState.identification,
                          // );
                          // goTo(context: context, view: OtpScreen.routeName);
                          if (_formKey.currentState?.validate() ?? false) {
                            signupNotifier.signUpUser(
                              context: context,
                              email: formState.email,
                              phone: formState.phone,
                              password: formState.password,
                              fullName: formState.name,
                              nickname: formState.nickname,
                              gender: formState.gender,
                              identification: formState.identification,
                            );
                          }
                        },
                        child: const Text('Verify Account'),
                      ),
                    24.sbH,
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontFamily: "Inter"),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Login',
                            style: AppTypography.inter16Red.copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: Palette.surface),
                          ),
                        ],
                      ),
                    ).tap(onTap: () {
                      Navigator.popAndPushNamed(
                          context, SignInScreen.routeName);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
