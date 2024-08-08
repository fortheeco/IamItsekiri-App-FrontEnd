// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

class UserModel {
  final int? id;
  final String? firstName;
  final String? userName;
  final String? lastName;
  final String? email;
  final List<dynamic>? preferences;
  final List<dynamic>? verificationDocuments;
  final String? country;
  final String? gender;
  final String? mobile;
  final String? avatar;
  const UserModel({
    this.id,
    this.firstName,
    this.userName,
    this.lastName,
    this.email,
    this.preferences,
    this.verificationDocuments,
    this.country,
    this.gender,
    this.mobile,
    this.avatar,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? userName,
    String? lastName,
    String? email,
    List<dynamic>? preferences,
    List<dynamic>? verificationDocuments,
    String? country,
    String? gender,
    String? mobile,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      userName: userName ?? this.userName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      preferences: preferences ?? this.preferences,
      verificationDocuments:
          verificationDocuments ?? this.verificationDocuments,
      country: country ?? this.country,
      gender: gender ?? this.gender,
      mobile: mobile ?? this.mobile,
      avatar: avatar ?? this.avatar,
    );
  }

  Map<String, dynamic> toJSON() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'preferences': preferences,
        'verificationDocuments': verificationDocuments,
        'country': country,
        'gender': gender,
        'mobile': mobile,
        'avatar': avatar,
        'username': userName,
      };

  factory UserModel.fromJSON(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? 0,
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        email: json['email'] ?? '',
        avatar: json['avatar'] ?? '',
        preferences: json['preferences'] ?? [],
        verificationDocuments: json['verificationDocuments'] ?? [],
        gender: json['profileIgendermageUrl'] ?? '',
        mobile: json['mobile'] ?? '',
        userName: json['username'] ?? '',
      );

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, userName: $userName, lastName: $lastName, email: $email, preferences: $preferences, verificationDocuments: $verificationDocuments, country: $country, gender: $gender, mobile: $mobile, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.userName == userName &&
        other.lastName == lastName &&
        other.email == email &&
        listEquals(other.preferences, preferences) &&
        listEquals(other.verificationDocuments, verificationDocuments) &&
        other.country == country &&
        other.gender == gender &&
        other.mobile == mobile &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        userName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        preferences.hashCode ^
        verificationDocuments.hashCode ^
        country.hashCode ^
        gender.hashCode ^
        mobile.hashCode ^
        avatar.hashCode;
  }
}
