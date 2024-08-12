import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


String? selectedValue;

class CustomDropdown extends StatelessWidget {
  final String? label;
  final String hintText;
  final bool obscureText;
  final String validatorText;
  final List<String>? items;
  final void Function(String?)? onChanged;
  const CustomDropdown({
    super.key,
    this.label,
    required this.hintText,
    this.obscureText = false,
    required this.validatorText,
    required this.onChanged,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null && label!.isNotEmpty)
          Text(
            label!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontFamily: "Inter", color: Palette.greyBlueB),
          ),
        if (label != null && label!.isNotEmpty) 7.sbH,
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(contentPadding: EdgeInsets.fromLTRB(0.w, 0, 16.w, 0)),
          hint: Text(hintText,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Palette.greyBlueA)),
          // style: AppTypography.bodyLargeGrey,
          items: items?.map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: AppTypography.raleway16Dark,
                    ),
                  ))
              .toList(),
          validator: (value) {
            if (value == null) {
              return validatorText;
            }
            return null;
          },
          onChanged: onChanged,
          onSaved: (value) {
            selectedValue = value.toString();
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        )
      ],
    );
  }
}
