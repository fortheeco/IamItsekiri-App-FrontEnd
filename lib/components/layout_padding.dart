import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutPadding extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const LayoutPadding({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.fromLTRB(30.w, 30.h, 30.w, 56.h),
      child: child,
    );
  }
}
