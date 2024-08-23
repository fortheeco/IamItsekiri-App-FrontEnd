import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/components/circular_loader.dart';
import 'package:oneitsekiri_flutter/components/custom_dropdwon.dart';
import 'package:oneitsekiri_flutter/components/custom_input_field.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/models/profile/profile_form_state.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/providers/profile_provider.dart';
import 'package:oneitsekiri_flutter/screens/onboarding/complete_registration_screen.dart';
import 'package:oneitsekiri_flutter/screens/wrapper/base_nav_wrapper.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/utils/nav.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContinueRegistrationScreen extends ConsumerWidget {
  static const String routeName = "profile_setup_screen";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> communities = ["Egbok"];
  ContinueRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? userprovider = ref.watch(userProvider);
    ProfileFormState profileControllerState =
        ref.watch(profileControllerProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Palette.darkRedA,
          surfaceTintColor: Palette.darkRedA,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  color: Palette.darkRedA,
                ),
                Expanded(
                  child: Container(
                    color: Colors.white, // The rest of the screen is white
                  ),
                ),
              ],
            ),
          ),
          // Scrollable content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          color: Palette.darkRedA,
                          child: LayoutPadding(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                84.sbH,
                                'Set up your profile'.ralewayTxt18(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 159.h,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 176.r,
                        height: 176.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Palette.whiteA,
                            width: 4.0.w,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 88.r,
                          backgroundColor: const Color(0xFFD8D8D8),
                          child: SvgPicture.asset(
                            'lib/assets/images/gallery-add.svg',
                            height: 48.h,
                            width: 48.w,
                            color: Palette.surface,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Palette.whiteA,
                      child: LayoutPadding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            30.sbH,
                            "${userprovider?.fullName}".ralewayTxt18(
                                textAlign: TextAlign.center,
                                style: AppTypography.raleway18
                                    .copyWith(color: Palette.surface)),
                            40.sbH,
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  CustomInputField(
                                      label: "Bio",
                                      contentPadding: EdgeInsets.fromLTRB(
                                          16.w, 16.w, 16.w, 16.w),
                                      minLines: 4,
                                      maxLines: null,
                                      hintText: "Tell us about yourself",
                                      onChanged: (value) {
                                        profileControllerState.copyWith(
                                            bio: value);
                                      }),
                                  25.sbH,
                                  CustomDropdown(
                                      label: "Community",
                                      items: communities,
                                      hintText:
                                          "Select the community you are from",
                                      validatorText:
                                          "Please choose a community",
                                      onChanged: (value) {
                                        profileControllerState.copyWith(
                                            community: value);
                                      }),
                                  25.sbH,
                                  CustomInputField(
                                      label: "Location",
                                      hintText: "Wherre are you?",
                                      validatorText:
                                          "Please include a location",
                                      onChanged: (value) {
                                        profileControllerState.copyWith(
                                            location: value);
                                      }),
                                  35.sbH,
                                  if (profileControllerState.isLoading)
                                    const CircularLoader(),
                                  if (!profileControllerState.isLoading)
                                    ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            goTo(
                                                context: context,
                                                view: CompleteRegistrationScreen
                                                    .routeName);
                                          }
                                        },
                                        child: "Continue Registration"
                                            .interTxt14(
                                                style: AppTypography
                                                    .inter14WhiteA
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600))),
                                  TextButton(
                                      onPressed: () {
                                        goTo(
                                            replace: true,
                                            context: context,
                                            view: BaseNavWrapper.routeName);
                                      },
                                      child: "Remind me later".interTxt14(
                                          style: AppTypography.inter14WhiteA
                                              .copyWith(
                                                  color: Palette.surface,
                                                  fontWeight: FontWeight.w600)))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Add more content here
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
