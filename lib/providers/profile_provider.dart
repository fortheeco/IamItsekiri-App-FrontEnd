import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/controllers/profile_controller.dart';
import 'package:oneitsekiri_flutter/models/profile/profile_form_state.dart';
import 'package:oneitsekiri_flutter/services/profile_service.dart';

Provider<ProfileService> profileServiceProvider = Provider((ref) {
  return ProfileService(ref: ref);
});

StateNotifierProvider<ProfileController, ProfileFormState> profileControllerProvider =
    StateNotifierProvider((ref) {
  ProfileService profileService = ref.read(profileServiceProvider);
  return ProfileController(
    profileService: profileService,
    ref: ref,
  );
});
