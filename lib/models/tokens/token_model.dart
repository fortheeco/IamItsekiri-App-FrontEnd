//! THIS FILE CONTAINS THE IMPLEMENTATION FOR USER TOKENS.
//! WITH THIS MODEL, USER TOKENS ARE ENCRYPTED AND SAVED FOR REFERENCING

//! TO GENERATE NEW HIVE ADAPTER, RUN THE BELOW COMMAND.
//! - flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs

import 'package:hive/hive.dart';
part "token_model.g.dart";

@HiveType(typeId: 1)
class UserToken extends HiveObject {
  @HiveField(0)
  late String? refreshToken;
  @HiveField(1)
  late String? accessToken;

  //! constructor
  UserToken({this.refreshToken, this.accessToken});

  //! TO JSON
  Map<String, dynamic> toJSON() => {
        "refreshToken": refreshToken,
        "accessToken": accessToken,
      };

  //! FROM JSON
  factory UserToken.fromJSON(Map<String, dynamic> json) => UserToken(
        refreshToken: json["refreshToken"] ?? "",
        accessToken: json["accessToken"] ?? "",
      );
}
