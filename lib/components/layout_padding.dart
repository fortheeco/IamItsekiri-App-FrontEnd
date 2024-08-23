import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? top;
  final double? bottom;

  const LayoutPadding(
      {super.key, required this.child, this.padding, this.top, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.fromLTRB(30.w, top ?? 30.h, 30.w, bottom ?? 56.h),
      child: child,
    );
  }
}
