import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/components/nav_bar_widget.dart';
import 'package:oneitsekiri_flutter/controllers/base_nav_controller.dart';
import 'package:oneitsekiri_flutter/screens/wrapper/side_nav_drawer.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/utils/app_constants.dart';

class BaseNavWrapper extends ConsumerWidget {
  static const String routeName = "wrapper";
  const BaseNavWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int indexFromController = ref.watch(baseNavControllerProvider);
    return Scaffold(
      drawer: const NavDrawer(),
      body: Stack(
        children: [
          pages[indexFromController],
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Palette.whiteA,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              height: 90.h,
              width: width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  nav.length,
                  (index) => NavBarIcon(navIcon: nav[index]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
