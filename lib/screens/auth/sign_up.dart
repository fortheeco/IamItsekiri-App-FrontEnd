import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/components/custom_app_bar.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/components/registration_section_tile.dart';
import 'package:oneitsekiri_flutter/components/custom_input_field.dart';
import 'package:oneitsekiri_flutter/components/custom_dropdwon.dart';
import 'package:oneitsekiri_flutter/screens/auth/sign_in.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/utils/enums.dart';

class SignupScreen extends ConsumerWidget {
  static const String routeName = "signUp";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> genderItems = [
    'Male',
    'Female',
  ];

  SignupScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final formState = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final signupNotifier = ref.read(signupProvider.notifier);

    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
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
                    onChanged: (value) => formNotifier.setName(value),
                    inputType: InputType.name,
                  ),
                  16.sbH,
                  CustomInputField(
                    keyboardType: TextInputType.phone,
                    label: 'Phone number',
                    hintText: '+234 | enter your phone number',
                    validatorText: 'Please enter your phone number',
                    onChanged: (value) {
                      final phoneNumber = int.tryParse(value) ?? 0;
                      formNotifier.setPhone(phoneNumber);
                    },
                    inputType: InputType.phone,
                  ),
                  16.sbH,
                  CustomInputField(
                    keyboardType: TextInputType.emailAddress,
                    label: 'Email Address',
                    hintText: 'example@email.com',
                    validatorText: 'Please enter your email',
                    onChanged: (value) => formNotifier.setEmail(value),
                    inputType: InputType.email,
                  ),
                  16.sbH,
                  CustomDropdown(
                    label: 'Gender',
                    items: genderItems,
                    hintText: 'Select your gender',
                    validatorText: 'Please select your gender',
                    onChanged: (value) => formNotifier.setGender(value!),
                  ),
                  16.sbH,
                  CustomInputField(
                    label: 'Nickname or Tittle (optional)',
                    customValidator: true,
                    hintText: 'What are you popularly called?',
                    validatorText: 'Please enter your nickname',
                    onChanged: (value) => formNotifier.setNickname(value),
                    inputType: InputType.name,
                  ),
                  16.sbH,
                  CustomInputField(
                    label:
                        'Upload Identification (NIN,L.G.A Certificate, e.t.c;) ',
                    hintText: 'John Martins',
                    validatorText: 'Please identification',
                    onChanged: (value) => formNotifier.setEmail(value),
                    inputType: InputType.file,
                  ),
                  61.sbH,
                  if (formState.isLoading) const CircularProgressIndicator(),
                  if (!formState.isLoading)
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          signupNotifier.signup();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
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
                          style: AppTypography.bodyLarge.copyWith(
                              color: Palette.surface,
                              fontFamily: "Inter",
                              decoration: TextDecoration.underline,
                              decorationColor: Palette.surface),
                        ),
                      ],
                    ),
                  ).tap(onTap: () {
                    Navigator.popAndPushNamed(context, SignInScreen.routeName);
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
