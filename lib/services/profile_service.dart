import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oneitsekiri_flutter/providers/auth_providers.dart';
import 'package:oneitsekiri_flutter/services/auth_service.dart';
import 'package:oneitsekiri_flutter/shared/app_urls.dart';
import 'package:oneitsekiri_flutter/utils/enums.dart';
import 'package:oneitsekiri_flutter/utils/type_defs.dart';

class ProfileService {
  final Ref _ref;
  ProfileService({required Ref ref}) : _ref = ref;

  FutureEither<String> updateUserProfile({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? mobile,
    String? country,
    String? gender,
    File? avatar,
    String? password,
  }) async {
    final Dio dio = _ref.read(dioProvider);
    Map<String, dynamic> filterNonNullValues(Map<String, dynamic> input) {
      return Map.fromEntries(input.entries.where(
          (entry) => entry.value != null && entry.value.toString().isNotEmpty));
    }

    final FormData data = FormData.fromMap(filterNonNullValues({
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'country': country,
      'gender': gender,
      'password': password,
      if (avatar != null && avatar.existsSync())
        'avatar': await MultipartFile.fromFile(
          avatar.path,
          filename: avatar.path.split('/').last,
        ),
    }));
    return makeApiRequest(
      ref: _ref,
      endpoint: AppUrls.profile,
      requestBody: data,
      dio: dio,
      apiType: ApiType.updateUserProfile,
      endpointName: "Update User Profile",
    );
  }
}
