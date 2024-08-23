// ignore_for_file: unused_field

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:oneitsekiri_flutter/models/profile/profile_form_state.dart';
import 'package:oneitsekiri_flutter/screens/wrapper/base_nav_wrapper.dart';
import 'package:oneitsekiri_flutter/services/profile_service.dart';
import 'package:oneitsekiri_flutter/utils/failure.dart';
import 'package:oneitsekiri_flutter/utils/nav.dart';
import 'package:oneitsekiri_flutter/utils/snack_bar.dart';
import 'package:oneitsekiri_flutter/utils/type_defs.dart';

class ProfileController extends StateNotifier<ProfileFormState> {
  final ProfileService _profileService;
  final Ref _ref;
  ProfileController({
    required ProfileService profileService,
    required Ref ref,
  })  : _profileService = profileService,
        _ref = ref,
        super(const ProfileFormState());

  //! update username
  void updateUserProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    String? country,
    String? gender,
    File? avatar,
    String? password,
    required BuildContext context,
    bool? isPassword,
  }) async {
    state = state.copyWith(isLoading: true);

    final Either<Failure, String> res = await _profileService.updateUserProfile(
        username: username,
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobile: mobile,
        country: country,
        gender: gender,
        avatar: avatar,
        password: password);

    state = state.copyWith(isLoading: false);

    res.fold(
      (l) {
        showBanner(
          theMessage: l.message,
          theType: NotificationType.failure,
        );
      },
      (r) {
        goTo(context: context, view: BaseNavWrapper.routeName, replace: true);
      },
    );
  }
}
