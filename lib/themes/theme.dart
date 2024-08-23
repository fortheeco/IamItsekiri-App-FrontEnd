import 'package:flutter/material.dart';
import 'palette.dart';
import 'typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: Palette.whiteA,
    primaryColor: Palette.whiteA,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Palette.whiteA,
        onPrimary: Palette.surface,
        secondary: Palette.darkRedB,
        onSecondary: Palette.whiteA,
        error: Colors.red,
        onError: Palette.surface,
        background: Palette.whiteB,
        onBackground: Palette.darkA,
        surface: Palette.surface,
        onSurface: Palette.darkA),
    textSelectionTheme: const TextSelectionThemeData(
      selectionHandleColor: Colors.transparent,
      selectionColor: Palette.greyBlueB,
      cursorColor: Palette.darkA,
    ),
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge,
      headlineLarge: AppTypography.headlineLarge,
      headlineMedium: AppTypography.headlineMedium,
      headlineSmall: AppTypography.headlineSmall,
      bodyMedium: AppTypography.raleway14DarkA,
      bodyLarge: AppTypography.raleway16,
      bodySmall: AppTypography.bodySmall,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.darkRedA,
      foregroundColor: Palette.whiteA,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: AppTypography.raleway14Red,
      contentPadding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
      constraints: BoxConstraints(minHeight: 52.h),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Palette.whiteC),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Palette.whiteC),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF838383)),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      labelStyle: AppTypography.inter16GreyBlueA,
      hintStyle: AppTypography.inter16GreyBlueA,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(323.w, 50.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
              side: const BorderSide(color: Palette.surface),
            ),
            textStyle: AppTypography.elevatedButtonText)));
