import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/utils/type_defs.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
final messenger = scaffoldMessengerKey.currentState;

// Show Snackbar
void showSnackBar({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 2000),
        content: text.ralewayTxt16(),
      ),
    );
}

//! SHOW BANNER
showBanner({
  required String theMessage,
  required NotificationType theType,
  Duration? dismissIn,
}) {
  messenger?.showMaterialBanner(
    MaterialBanner(
      elevation: 4.0.sp,
      padding: EdgeInsets.symmetric(
        vertical: 20.0.h,
        horizontal: 25.0.w,
      ),
      forceActionsBelow: true,
      backgroundColor: theType == NotificationType.failure
          ? Palette.surface
          : theType == NotificationType.success
              ? Colors.green.shade400
              : Colors.brown,

      //! THE CONTENT
      content: Text(
        maxLines: 50,
        theMessage,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Palette.whiteA,
        ),
      ),

      //! ACTIONS - DISMISS BUTTON
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => messenger?.hideCurrentMaterialBanner(),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              padding: const EdgeInsets.all(12.0),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white24,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21.0.r),
              ),
            ),
            child: Text(
              "Dismiss",
              style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Palette.whiteA),
            ),
          ),
        ),
      ],
    ),
  );

  //! DISMISS AFTER 2 SECONDS
  Timer(
    dismissIn ?? const Duration(milliseconds: 2500),
    () => messenger?.hideCurrentMaterialBanner(),
  );
}
