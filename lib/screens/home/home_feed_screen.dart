import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/components/update_profile_reminder_card.dart';
import 'package:oneitsekiri_flutter/components/welcome_card.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

class HomeFeedScreen extends ConsumerWidget {
  const HomeFeedScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    UserModel? userprovider = ref.watch(userProvider);

    // void addReminder(String key, bool condition) {
    //   if (condition) {
    //     reminderValues.add({key: false});
    //   }
    // }

    // addReminder("isBioPresent",
    //     userprovider?.bio == null || userprovider!.bio!.isEmpty);
    // addReminder("isProfilePicturePresent",
    //     userprovider?.avatar == null || userprovider!.avatar!.isEmpty);
    // addReminder("isJoinedGroupsPresent",
    //     userprovider?.groups == null || userprovider!.groups!.isEmpty);
    List<Map<String, bool>> reminderValues = [
      if (userprovider?.bio?.isEmpty ?? true) {"isBioPresent": false},
      if (userprovider?.avatar?.isEmpty ?? true)
        {"isProfilePicturePresent": false},
      if (userprovider?.groups?.isEmpty ?? true)
        {"isJoinedGroupsPresent": false},
    ];
    return Scaffold(
      backgroundColor: Palette.whiteA,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: LayoutPadding(
        top: 0,
        bottom: 0,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: "One Itsekiri".ralewayTxt18(color: Palette.darkA),
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              // // leading:
              centerTitle: true,
              // expandedHeight: 69.h,
              backgroundColor: Palette.whiteA,
              flexibleSpace: FlexibleSpaceBar(
                background: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/images/menu_blue.svg',
                      width: 24.w,
                      height: 24.h,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'lib/assets/images/mi_notification.svg',
                          width: 24.w,
                          height: 24.h,
                        ),
                        13.sbW,
                        SvgPicture.asset(
                          'lib/assets/images/la_hotjar.svg',
                          width: 24.w,
                          height: 24.h,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const WelcomeCard(),
                  24.sbH,
                  const UpdateProfileReminderCard(),
                  39.sbH,
                  "What's new?".ralewayTxt14(color: Palette.darkA),
                  // "$userprovider".ralewayTxt18(color: Palette.darkA),
                  // "$userprovider".ralewayTxt18(color: Palette.darkA),
                  // "$userprovider".ralewayTxt18(color: Palette.darkA),
                  120.sbH
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Map<String, bool>> reminderValues = [];
