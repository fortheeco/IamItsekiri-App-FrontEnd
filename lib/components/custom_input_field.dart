import 'package:flutter/material.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final String validatorText;
  final bool customValidator;
  final TextInputType? keyboardType;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;

  const CustomInputField({
    super.key,
    this.keyboardType,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    required this.validatorText,
    required this.onChanged,
    this.customValidator = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontFamily: "inter", color: Palette.greyBlueB),
        ),
        7.sbH,
        TextFormField(
            obscureText: obscureText,
            onChanged: onChanged,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: hintText,
              border: const OutlineInputBorder(),
            ),
            validator: !customValidator
                ? (value) {
                    if (value == null || value.isEmpty) {
                      return validatorText;
                    }
                    return null;
                  }
                : validator),
      ],
    );
  }
}
