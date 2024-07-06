import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final double height;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Widget? flexibleSpace;
  final PreferredSizeWidget? bottom;
  final double? elevation;
  final double? scrolledUnderElevation;
  final bool Function(ScrollNotification) notificationPredicate;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final ShapeBorder? shape;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconThemeData? iconTheme;
  final IconThemeData? actionsIconTheme;
  final bool primary;
  final bool? centerTitle;
  final bool excludeHeaderSemantics = false;
  final double? titleSpacing;
  final double? toolbarOpacity;
  final double? bottomOpacity;
  final double? toolbarHeight;
  final double? leadingWidth;
  final TextStyle? toolbarTextStyle;
  final TextStyle? titleTextStyle;
  // final SystemUiOverlayStyle? systemOverlayStyle;
  final bool? forceMaterialTransparency;
  final Clip? clipBehavior;

  const CustomAppBar(
      {super.key,
      this.title,
      double? height,
      this.automaticallyImplyLeading = false,
      this.primary = true,
      this.titleSpacing,
      this.actions,
      this.flexibleSpace,
      this.bottom,
      this.elevation,
      this.scrolledUnderElevation,
      this.shadowColor,
      this.surfaceTintColor,
      this.shape,
      this.backgroundColor,
      this.foregroundColor,
      this.iconTheme,
      this.actionsIconTheme,
      this.centerTitle,
      this.toolbarHeight,
      this.leadingWidth,
      this.toolbarTextStyle,
      this.titleTextStyle,
      this.clipBehavior,
      this.leading,
      this.notificationPredicate = defaultScrollNotificationPredicate,
      this.forceMaterialTransparency = false,
      this.toolbarOpacity = 1.0,
      this.bottomOpacity = 1.0})
      : height = height ?? 20;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? ""),
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }
}
