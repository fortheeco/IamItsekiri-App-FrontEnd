// ignore_for_file: prefer_final_fields, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oneitsekiri_flutter/components/circular_loader.dart';
import 'package:oneitsekiri_flutter/components/custom_app_bar.dart';
import 'package:oneitsekiri_flutter/components/custom_elevated_button.dart';
import 'package:oneitsekiri_flutter/components/layout_padding.dart';
import 'package:oneitsekiri_flutter/components/registration_section_tile.dart';
import 'package:oneitsekiri_flutter/controllers/auth_controllers.dart';
import 'package:oneitsekiri_flutter/models/auth/form_state.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/themes/palette.dart';
import 'package:oneitsekiri_flutter/themes/typography.dart';
import 'package:oneitsekiri_flutter/utils/extensions.dart';

class OtpScreen extends ConsumerStatefulWidget {
  static const String routeName = "otp";
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late List<TextEditingController> _controllers;
  Timer? _timer;
  int _start = 900; // 15 minutes in seconds
  bool _isButtonActive = true;

  @override
  void initState() {
    _controllers = List.generate(5, (index) => TextEditingController());
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _checkAndSendOTP() {
    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      _verifyOTP();
    }
  }

  void _verifyOTP() async {
    AuthController verifyOtpNotifier =
        ref.read(authControllerProvider.notifier);
    String otp = _controllers.map((controller) => controller.text).join();
    await verifyOtpNotifier.verifySignUpOtp(context: context, otp: otp);

    'All fields filled. Sending OTP...'.log();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _isButtonActive = false;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthController authNotifier = ref.read(authControllerProvider.notifier);
    AuthFormState authState = ref.watch(authControllerProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: LayoutPadding(
            child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SectionTitle(
                title: 'Enter code',
                subtitle:
                    'We’ve sent an email with an activation code to your email ${authState.email}',
              ),
              61.sbH,
              Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return SizedBox(
                        height: 64.h,
                        width: 56.w,
                        child: TextFormField(
                          cursorColor: Palette.darkBlueA,
                          controller: _controllers[index],
                          autofocus: true,
                          onChanged: (value) {
                            if (value.length == 1) {
                              FocusScope.of(context).nextFocus();
                              _checkAndSendOTP();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                              _controllers[index--].clear();
                            }
                          },
                          style: AppTypography.inter24DarkBlue,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: _controllers.any(
                                    (controller) => controller.text.isEmpty)
                                ? Palette.redWhite
                                : Colors.transparent,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Palette.surface),
                             ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ));
                  })),
              28.sbH,
              authState.isLoading
                  ? const CircularLoader()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          onPressed: () {
                            // setState(() {
                            //   _isButtonActive = false;
                            // });
                            _isButtonActive
                                ? null
                                : authNotifier.requestSignUpOtp(
                                    view: false,
                                    context: context,
                                    email: authState.email);

                            startTimer();
                            setState(() {
                              _isButtonActive = true;
                              _start = 900;
                            });
                          },
                          width: 127.w,
                          height: 32.h,
                          elevatedButtonText:
                              (_isButtonActive ? 'Resend in' : 'Resend otp')
                                  .interTxt12(),
                        ),
                        8.sbW,
                        SizedBox(
                          child:
                              " ${_isButtonActive ? '${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}' : '${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}'}"
                                  .interTxt16(),
                        )
                      ],
                    )
            ],
          ),
        )),
      ),
    );
  }
}
