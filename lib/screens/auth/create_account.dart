import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/components/custom_app_bar.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/components/registration_section_tile.dart';
import 'package:oneitsekiri_flutter/components/custom_input_field.dart';

class SignupScreen extends ConsumerWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    onChanged: (value) => formNotifier.setEmail(value),
                  ),
                  16.sbH,
                  CustomInputField(
                    label: 'Phone number',
                    hintText: '+234 | enter your phone number',
                    validatorText: 'Please enter your name',
                    onChanged: (value) => formNotifier.setEmail(value),
                  ),
                  16.sbH,
                  CustomInputField(
                    label: 'Email Address',
                    hintText: 'example@email.com',
                    validatorText: 'Please enter your name',
                    onChanged: (value) => formNotifier.setEmail(value),
                  ),
                  16.sbH,
                  CustomInputField(
                    label: 'Gender',
                    hintText: 'Select your gender',
                    validatorText: 'Please enter your name',
                    onChanged: (value) => formNotifier.setEmail(value),
                  ),
                  16.sbH,
                  CustomInputField(
                    label: 'Nickname or Tittle (optional)',
                    hintText: 'What are you popularly called?',
                    validatorText: 'Please enter your name',
                    onChanged: (value) => formNotifier.setEmail(value),
                  ),
                  16.sbH,
                  CustomInputField(
                    label:
                        'Upload Identification (NIN,L.G.A Certificate, e.t.c;) ',
                    hintText: 'John Martins',
                    validatorText: 'Please enter your name',
                    onChanged: (value) => formNotifier.setEmail(value),
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
                  const Text("Already have an account? Login").alignCenter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
