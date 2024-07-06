import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/components/overlays.dart';
import 'package:oneitsekiri_flutter/shared/app_texts.dart';

class ChooseAuthRoute extends StatelessWidget {
  const ChooseAuthRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/images/intro-bg.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        darkGradientOverlay(context),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(AppTexts.onboardingTitle1,
                  style: Theme.of(context).textTheme.displayLarge),
              9.sbH,
              Text(
                AppTexts.onboardingTitle2,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              39.sbH,
              ElevatedButton(
                style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    fixedSize: MaterialStatePropertyAll(Size(323.w, 41.h))),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Register'),
              ),
              // 5.sbH,
              TextButton(
                onPressed: () {},
                child: Text(
                  "Continue as guest",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )
            ],
          ).paddingOnly(bottom: 75),
        )
      ],
    ));
  }
}
