import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

class FilePickerFormField extends FormField<File> {
  final String? label;
  final void Function(File?) onFilePicked;

  FilePickerFormField({
    Key? key,
    this.label,
    required this.onFilePicked,
    FormFieldSetter<File>? onSaved,
    FormFieldValidator<File>? validator,
    File? initialValue,
    bool autovalidate = false,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: (file) {
            if (file == null) {
              return 'Please select a file';
            }
            return null;
          },
          initialValue: initialValue,
          builder: (FormFieldState<File> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (label != null && label.isNotEmpty)
                  Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(state.context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                            fontFamily: "Inter", color: Palette.greyBlueB),
                  ),
                7.sbH,
                Container(
                  padding: EdgeInsets.all(0.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            state.hasError ? Palette.surface : Palette.whiteC),
                    borderRadius: BorderRadius.circular(5.0.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        padding: EdgeInsets.all(14.w),
                        elevation: 0,
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: [
                              'pdf',
                              'doc',
                              'docx',
                              'png',
                              'jpg',
                              'jpeg'
                            ],
                          );

                          if (result != null) {
                            File file = File(result.files.single.path!);
                            onFilePicked(file);
                            state.didChange(file);
                          } else {
                            onFilePicked(null);
                            state.didChange(null);
                          }
                        },
                        color: Palette.whiteB,
                        minWidth: 99.w,
                        child: 'Choose File'.interTxt12(
                          style: AppTypography.inter12Red,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: state.value != null
                            ? state.value!.path.split('/').last.interTxt16(
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTypography.inter16GreyBlueB,
                                )
                            : 'No file chosen'.interTxt16(
                                overflow: TextOverflow.ellipsis,
                                style: AppTypography.inter16WhiteC,
                              ),
                      ),
                    ],
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 8.0.h, left: 16.w),
                    child: state.errorText!.ralewayTxt14(
                      style: AppTypography.raleway14Red,
                    ),
                  ),
              ],
            );
          },
        );
}
