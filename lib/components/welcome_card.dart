import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/components/custom_elevated_button.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/app_constants.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(12.0.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0.r),
        child: Row(
          children: [
            // Image
            Stack(
              children: [
                Image.asset(
                  'lib/assets/images/olu_of_warri.png',
                  fit: BoxFit.cover,
                  width: width(context) * 0.3 ,
                ),
                Positioned(
                  bottom: 16.0.h,
                  left: 16.0.w,
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    fit: BoxFit.cover,
                    height: 13.h,
                    width: 48.w,
                  ),
                )
              ],
            ),
            SizedBox(width: 16.0.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "Greetings".ralewayTxt20(),
                  8.sbH,
                  "Olu of Warri welcomes you to the community."
                      .ralewayTxt14(color: Palette.darkA),
                  8.sbH,
                  CustomElevatedButton(
                      width: 116.w,
                      height: 36.h,
                      onPressed: () {},
                      elevatedButtonText:
                          "Read Message".ralewayTxt14(color: Palette.whiteA))
                ],
              ),
            ),
            SizedBox(width: 16.0.w),
          ],
        ),
      ),
    );
  }
}
