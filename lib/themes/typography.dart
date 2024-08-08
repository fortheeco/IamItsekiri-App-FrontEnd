import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';

class AppTypography {
  static TextStyle displayLarge = GoogleFonts.raleway(
    fontSize: 36.sp,
    fontWeight: FontWeight.bold,
    color: Palette.whiteA,
  );

  static TextStyle headlineLarge = GoogleFonts.raleway(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: Palette.darkB,
  );
  static TextStyle headlineMedium = GoogleFonts.raleway(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: Palette.darkB,
  );
  static TextStyle headlineSmall = GoogleFonts.raleway(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: Palette.darkB,
  );
  static TextStyle bodyLarge = GoogleFonts.raleway(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle bodyLargeGrey = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Palette.greyBlueA,
  );

  static TextStyle bodyMedium = GoogleFonts.raleway(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Palette.darkA,
  );

  static TextStyle bodyMediumBold = GoogleFonts.raleway(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static TextStyle redBodyMediumBold = GoogleFonts.raleway(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Palette.surface,
  );

  static TextStyle redBodyMedium = GoogleFonts.raleway(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Palette.surface,
  );

  static TextStyle bodySmall = GoogleFonts.raleway(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle caption = GoogleFonts.raleway(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle elevatedButtonText = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Palette.elevatedButtonTextColor,
  );
}
