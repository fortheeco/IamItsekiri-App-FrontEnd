import 'package:flutter/material.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:oneitsekiri_flutter/utils/enums.dart';

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscureText;
  final String? validatorText;
  final bool customValidator;
  final TextInputType? keyboardType;
  final void Function(String) onChanged;
  final String? Function(String?)? validator;
  final InputType? inputType;

  const CustomInputField({
    super.key,
    this.keyboardType,
    required this.label,
    required this.hintText,
    this.obscureText = false,
    this.validatorText,
    required this.onChanged,
    this.customValidator = false,
    this.validator,
    this.inputType,
  });

  List<String? Function(String?)> _getDefaultValidators() {
    switch (inputType) {
      case InputType.email:
        return [
          FormBuilderValidators.required(),
          FormBuilderValidators.email(errorText: "Enter a valid email"),
        ];
      case InputType.phone:
        return [
          FormBuilderValidators.required(),
          (value) {
            if (value != null && value.isNotEmpty) {
              if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                return "Enter a valid phone number";
              } else if (value.length != 11) {
                return "Phone number must be 11 digits";
              }
            }
            return null;
          },
        ];
      case InputType.name:
        return [
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(2,
              errorText: "Name must be at least 2 characters"),
        ];
      case InputType.password:
        return [
          FormBuilderValidators.required(),
          FormBuilderValidators.minLength(7,
              errorText: "Password must be greater than 6 characters"),
          (value) {
            if (value != null && value.isNotEmpty) {
              if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                return "Password must contain at least one uppercase letter";
              } else if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                return "Password must contain at least one lowercase letter";
              } else if (!RegExp(r'(?=.*[0-9])').hasMatch(value)) {
                return "Password must contain at least one digit";
              } else if (!RegExp(r'(?=.*[!@#\$&*~])').hasMatch(value)) {
                return "Password must contain at least one special character";
              }
            }
            return null;
          },
        ];
      default:
        return [
          (value) {
            if (value == null || value.isEmpty) {
              return validatorText;
            }
            return null;
          },
        ];
    }
  }

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
          cursorColor: Palette.greyA,
          obscureText: obscureText,
          onChanged: onChanged,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: hintText,
            border: const OutlineInputBorder(),
          ),
          validator: customValidator
              ? validator
              : FormBuilderValidators.compose(_getDefaultValidators()),
        ),
      ],
    );
  }
}
