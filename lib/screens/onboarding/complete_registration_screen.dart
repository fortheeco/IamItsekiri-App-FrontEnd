import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/components/circular_loader.dart';
import 'package:oneitsekiri_flutter/components/custom_dropdwon.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/controllers/profile_controller.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/models/profile/profile_form_state.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/providers/profile_provider.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

class CompleteRegistrationScreen extends ConsumerWidget {
  static const String routeName = "complete_registration_screen";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> communities = ["Egbok"];
  CompleteRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? userprovider = ref.watch(userProvider);
    ProfileFormState profileControllerState =
        ref.watch(profileControllerProvider);
    ProfileController profileController =
        ref.watch(profileControllerProvider.notifier);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Palette.darkRedA,
          surfaceTintColor:Palette.darkRedA,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.23,
                color: Palette.darkRedA,
                child: LayoutPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      84.sbH,
                      'Warri Kingdom Communities'.ralewayTxt18(),
                      'Become a member of an Itsekiri Community'
                          .ralewayTxt14(color: Palette.whiteA)
                    ],
                  ),
                ),
              ),
              LayoutPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomDropdown(
                              label: "Select state",
                              items: communities,
                              hintText: "Select your state",
                              validatorText: "Please select your state",
                              onChanged: (value) {
                                profileControllerState.copyWith(state: value);
                              }),
                          25.sbH,
                          CustomDropdown(
                              label: "Select LGA",
                              items: communities,
                              hintText: "Select your LGA",
                              validatorText: "Please choose a community",
                              onChanged: (value) {
                                profileControllerState.copyWith(lga: value);
                              }),
                          25.sbH,
                          CustomDropdown(
                              label: "Community",
                              items: communities,
                              hintText: "Select the community you are from",
                              validatorText: "Please choose a community",
                              onChanged: (value) {
                                profileControllerState.copyWith(
                                    community: value);
                              }),
                          35.sbH,
                          if (profileControllerState.isLoading)
                            const CircularLoader(),
                          if (!profileControllerState.isLoading)
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    profileController.updateUserProfile(
                                        context: context);
                                  }
                                },
                                child: "Complete Registration".interTxt14(
                                    style: AppTypography.inter14WhiteA.copyWith(
                                        fontWeight: FontWeight.w600))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
