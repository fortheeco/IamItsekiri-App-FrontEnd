import 'package:flutter/material.dart';
import "package:flutter/foundation.dart";
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

//! LOG EXTENSION - THIS HELPS TO CALL A .log() ON ANY OBJECT
extension Log on Object {
  void log() {
    if (kDebugMode) {
      print(toString());
    }
  }
}

extension LogString on String? {
  void logString() {
    if (kDebugMode) {
      print(toString());
    }
  }
}

extension InkWellExtension on Widget {
  InkWell tap({
    required GestureTapCallback? onTap,
    GestureTapCallback? onDoubleTap,
    GestureLongPressCallback? onLongPress,
    BorderRadius? borderRadius,
    Color? splashColor = Colors.transparent,
    Color? highlightColor = Colors.transparent,
  }) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      borderRadius: borderRadius ?? BorderRadius.circular(12.r),
      splashColor: splashColor,
      highlightColor: highlightColor,
      child: this,
    );
  }
}

extension AlignExtension on Widget {
  Align align(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: this,
    );
  }

  Align alignCenter() {
    return Align(
      alignment: Alignment.center,
      child: this,
    );
  }

  Align alignCenterLeft() {
    return Align(
      alignment: Alignment.centerLeft,
      child: this,
    );
  }

  Align alignCenterRight() {
    return Align(
      alignment: Alignment.centerRight,
      child: this,
    );
  }

  Align alignTopCenter() {
    return Align(
      alignment: Alignment.topCenter,
      child: this,
    );
  }

  Align alignBottomCenter() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: this,
    );
  }
}

/// Extension for creating a ValueNotifier from a value directly.
extension ValueNotifierExtension<T> on T {
  ValueNotifier<T> get notifier {
    return ValueNotifier<T>(this);
  }
}

/// extension for listening to ValueNotifier instances.
extension ValueNotifierBuilderExtension<T> on ValueNotifier<T> {
  Widget sync(
      {required Widget Function(BuildContext context, T value, Widget? child)
          builder,
      Widget? child}) {
    return ValueListenableBuilder<T>(
      valueListenable: this,
      builder: builder,
      child: child,
    );
  }
}

extension ListenableBuilderExtension on List<Listenable> {
  Widget multiSync({
    required Widget Function(BuildContext context, Widget? child) builder,
    Widget? child,
  }) {
    return ListenableBuilder(
      listenable: Listenable.merge(this),
      builder: builder,
      child: child,
    );
  }
}
