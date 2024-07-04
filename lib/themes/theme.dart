import 'package:flutter/material.dart';
import 'palette.dart';
import 'typography.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final ThemeData appTheme = ThemeData(
    primaryColor: Palette.primary,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Palette.primary,
        onPrimary: Palette.surface,
        secondary: Palette.secondary,
        onSecondary: Palette.onSecondary,
        error: Colors.red,
        onError: Palette.surface,
        background: Palette.background,
        onBackground: Palette.onBackground,
        surface: Palette.surface,
        onSurface: Palette.onBackground),
    textTheme: TextTheme(
      displayLarge: AppTypography.displayLarge,
      bodyMedium: AppTypography.bodyMedium,
      bodyLarge: AppTypography.bodyLarge,
      bodySmall: AppTypography.bodySmall,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
           fixedSize: Size(323.w, 41.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.r),
      ),
      textStyle: AppTypography.elevatedButtonText
    )));
