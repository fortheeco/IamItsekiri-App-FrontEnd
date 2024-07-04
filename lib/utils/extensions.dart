import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension PaddingExtension on Widget {
  Widget paddingAll(double value) => Padding(
        padding: EdgeInsets.all(value.w),
        child: this,
      );

  Widget paddingOnly({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) =>
      Padding(
        padding: EdgeInsets.only(
          left: left?.w ?? 0,
          top: top?.h ?? 0,
          right: right?.w ?? 0,
          bottom: bottom?.h ?? 0,
        ),
        child: this,
      );

  Widget paddingSymmetric({
    double? vertical,
    double? horizontal,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical?.h ?? 0,
          horizontal: horizontal?.w ?? 0,
        ),
        child: this,
      );
}

extension WidgetExtensionss on num {
  Widget get sbH => SizedBox(
        height: h,
      );

  Widget get sbW => SizedBox(
        width: w,
      );
}

extension WidgetExtensions on double {
  Widget get sbH => SizedBox(
        height: h,
      );

  Widget get sbW => SizedBox(
        width: w,
      );
}
