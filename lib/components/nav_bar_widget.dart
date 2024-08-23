// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/controllers/base_nav_controller.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

class NavBarIcon extends ConsumerWidget {
  final Nav navIcon;
  const NavBarIcon({
    super.key,
    required this.navIcon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    return LayoutPadding(
      top: 0,
      bottom: 10.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            navIcon.icon,
            height: 20.h,
            width: 20.w,
            color: indexFromController == navIcon.index
                ? Palette.surface
                : Palette.greyA,
          ),
          6.sbH,
          navIcon.iconName.ralewayTxt9()
        ],
      ),
    ).tap(
      onTap: () {
        moveToPage(
          context: context,
          ref: ref,
          index: navIcon.index,
        );
      },
    );
  }
}
