import 'package:flutter/material.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
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
        gradientOverlay(context),
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

  Container gradientOverlay(BuildContext context) {
    return Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0.5),
              Colors.black.withOpacity(0.2),
              Colors.transparent,
            ],
            stops: const [0.0, 0.3, 0.7, 1.0],
          ),
        ),
      );
  }
}
