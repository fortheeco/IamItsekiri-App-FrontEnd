import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget elevatedButtonText;
  final Color? color;
  final void Function()? onPressed;
  final OutlinedBorder? shape;

  const CustomElevatedButton(
      {super.key,
      required this.width,
      this.color,
      required this.height,
      required this.elevatedButtonText,
      this.shape,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        fixedSize: Size(width.w, height.h),
        backgroundColor: color ??
            Theme.of(context)
                .elevatedButtonTheme
                .style
                ?.backgroundColor
                ?.resolve({}),
        side: const BorderSide(color: Colors.transparent),
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
      ),
      child: Center(
        child: elevatedButtonText,
      ),
    );
  }
}
