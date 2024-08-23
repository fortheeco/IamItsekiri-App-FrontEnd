import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/app_constants.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

class UpdateProfileReminderCard extends StatelessWidget {
  const UpdateProfileReminderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Palette.pinkA,
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'lib/assets/images/profile-circle.svg',
          ),
          SizedBox(width: 16.0.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Profile Picture".ralewayTxt16(fontWeight: FontWeight.w500),
                2.sbH,
                "Help people identify you and add a face to your name"
                    .ralewayTxt12(),
              ],
            ),
          ),
          24.sbW,
          Stack(
            children: [
              SizedBox(
                height: 60.h,
                child: SvgPicture.asset(
                  color: Palette.darkA,
                  'lib/assets/images/close-circle-dark.svg',
                ).alignTopCenter(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
