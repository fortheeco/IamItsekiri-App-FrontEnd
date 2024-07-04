import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'palette.dart';

class AppTypography {
  static TextStyle displayLarge = GoogleFonts.raleway(
    fontSize: 36.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle bodyLarge = GoogleFonts.raleway(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

  static TextStyle bodyMedium = GoogleFonts.raleway(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: Colors.black,
  );

    static TextStyle bodyMediumBold = GoogleFonts.raleway(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: Colors.black,
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
