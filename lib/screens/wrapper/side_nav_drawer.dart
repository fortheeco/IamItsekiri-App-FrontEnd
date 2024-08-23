// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/models/auth/user_model.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/screens/profile/profile_image_preview.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/utils/image_loader.dart';
import 'package:oneitsekiri_flutter/utils/nav.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NavDrawer extends ConsumerWidget {
  const NavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? user = ref.watch(userProvider);
    bool logOutState = ref.watch(authControllerProvider).isLoading;
    return Drawer(
      backgroundColor: Palette.whiteA,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      width: 350.w,
      child: user != null
          ? Column(
              children: [
                93.sbH,
                Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 33.h,
                            child: ClipOval(
                              child: ImageLoader(
                                height: 64.h,
                                width: 64.h,
                                imageUrl: user.avatar ??
                                    "https://www.shutterstock.com/image-vector/user-profile-icon-vector-avatar-260nw-2220431045.jpg",
                              ),
                            ),
                          ).tap(onTap: () {
                            push(
                                context: context,
                                view: ProfileImagePreview(
                                  imageUrl: user.avatar ??
                                      "https://cdn-icons-png.flaticon.com/512/3541/3541871.png",
                                  userName: user.fullName ?? "User",
                                ));
                          }),
                          17.sbW,
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //! name
                              '${user.fullName}'.interTxt16(),
                            ],
                          ).tap(onTap: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
                50.sbH,

                //! first set
                Padding(
                  padding: EdgeInsets.only(left: 26.w),
                  child: Column(
                    children: List.generate(
                      sideNavItems1.length,
                      (index) => ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              // goTo(
                              //     context: context,
                              //     view: const Placeholder());
                              break;
                            case 1:
                              // goTo(context: context, view: const BlogsView());
                              break;
                            case 2:
                              // moveToPage(context: context, ref: ref, index: 1);
                              goBack(context);
                              break;
                            case 3:
                              // goTo(
                              //     context: context, view: const SettingsView());
                              break;
                            default:
                          }
                        },
                        leading: Icon(
                          sideNavItems1[index].icon,
                          size: 23.sp,
                          color: Palette.greyBlueB,
                        ),
                        title: sideNavItems1[index].title.interTxt12(),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: const Divider(
                    thickness: 0.5,
                  ),
                ),

                //! second set
                Padding(
                  padding: EdgeInsets.only(left: 26.w),
                  child: Column(
                    children: List.generate(
                      sideNavItems2.length,
                      (index) => ListTile(
                        onTap: () {
                          switch (index) {
                            case 0:
                              // goTo(context: context, view: const HelpView());
                              break;
                            case 1:
                              // goTo(
                              //     context: context,
                              //     view: const ContactUsView());
                              break;
                            case 2:
                              ref.read(authControllerProvider.notifier).logOut(
                                    context,
                                  );
                              break;
                            default:
                          }
                        },
                        leading: sideNavItems2[index].title == 'Log out' &&
                                logOutState
                            ? SizedBox(
                                height: 23.sp,
                                width: 23.sp,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Palette.surface),
                                ),
                              )
                            : Icon(
                                sideNavItems2[index].icon,
                                size: 23.sp,
                                color: sideNavItems2[index].title == 'Log out'
                                    ? Palette.surface
                                    : Palette.greyBlueB,
                              ),
                        title: sideNavItems2[index].title.interTxt16(
                              color: sideNavItems2[index].title == 'Log out'
                                  ? Palette.surface
                                  : Palette.darkA,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Text(
                'Error finding user',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Palette.darkA,
                ),
              ),
            ),
    );
  }
}

class SideNavItem {
  final IconData icon;
  final String title;
  const SideNavItem({
    required this.icon,
    required this.title,
  });
}

List<SideNavItem> sideNavItems1 = const [
  SideNavItem(icon: PhosphorIconsFill.pen, title: 'Edit Profile'),
  SideNavItem(icon: PhosphorIconsFill.book, title: 'Blogs'),
  SideNavItem(icon: PhosphorIconsFill.users, title: 'Connect Groups'),
  SideNavItem(icon: PhosphorIconsFill.gear, title: 'Settings'),
];

List<SideNavItem> sideNavItems2 = const [
  SideNavItem(icon: PhosphorIconsRegular.pen, title: 'Help'),
  // SideNavItem(icon: PhosphorIconsRegular.money, title: 'Donate'),
  SideNavItem(icon: PhosphorIconsRegular.phone, title: 'Contact us'),
  SideNavItem(icon: PhosphorIconsRegular.power, title: 'Log out'),
];
