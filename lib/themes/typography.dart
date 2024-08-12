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
  static TextStyle raleway16Dark = GoogleFonts.raleway(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle inter16GreyBlueB = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Palette.greyBlueB,
  );
  static TextStyle inter16WhiteC = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Palette.whiteC,
  );

  static TextStyle inter16GreyBlueA = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Palette.greyBlueA,
  );

  static TextStyle inter16Red = GoogleFonts.inter(
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      color: Palette.surface,
      decorationColor: Palette.surface);

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

  static TextStyle raleway14Red = GoogleFonts.raleway(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Palette.surface,
  );

  static TextStyle raleway14Dark = GoogleFonts.raleway(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: Palette.surface,
  );

  static TextStyle elevatedButtonText = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Palette.elevatedButtonTextColor,
  );

  static TextStyle inter12Red = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: Palette.surface,
  );

  static TextStyle caption = GoogleFonts.raleway(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
  static TextStyle bodySmall = GoogleFonts.raleway(
    fontSize: 10.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );
}
