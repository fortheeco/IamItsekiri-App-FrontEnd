import 'package:flutter/material.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';


class SpannedText extends StatelessWidget {
  final String before;
  final String after;
  const SpannedText({
    super.key,
    required this.before,
    required this.after,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: before,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontFamily: "Inter"),
        children: <TextSpan>[
          TextSpan(
              text: after,
              style: AppTypography.raleway16.copyWith(
                  color: Palette.surface,
                  fontFamily: "Inter",
                  decoration: TextDecoration.underline,
                  decorationColor: Palette.surface)),
        ],
      ),
    );
  }
}