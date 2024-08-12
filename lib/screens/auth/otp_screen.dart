import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/components/custom_app_bar.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/components/registration_section_tile.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

class OtpScreen extends ConsumerWidget {
  static const String routeName = "otp";
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: LayoutPadding(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SectionTitle(
              title: 'Enter code',
              subtitle: 'We’ve sent ans SMS with an activation code to your number +234 5678901',
            ),
            32.sbH,
          ],
        )),
      ),
    );
  }
}
