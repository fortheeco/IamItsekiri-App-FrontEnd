import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:oneitsekiri_flutter/models/tokens/token_model.dart';

class TokenCache {
  //! TOKEN CACHE STARTS HERE.
  //! CACHE USER TOKENS SECURELY
  static Future<bool> cacheUserTokens({UserToken? tokens}) async {
    bool areTokensCached = false;

    //! GET / GENERATE SECURE STORAGE
    const FlutterSecureStorage appSecureStorage = FlutterSecureStorage();

    //! FETCH ENCRYPTION KEY
    String? userTokenEncryptionKey =
        await appSecureStorage.read(key: "userTokenEncryptionKey");

    //! ENCRYPTION KEY DOESN'T EXIST, CREATE KEY.
    if (userTokenEncryptionKey == null) {
      List<int> encryptionKey = Hive.generateSecureKey();

      await appSecureStorage.write(
          key: "userTokenEncryptionKey", value: base64UrlEncode(encryptionKey));
    }

    //! ENCRYPTION KEY EXISTS, GET, DECODE AND USE.
    String? encryptionKey =
        await appSecureStorage.read(key: "userTokenEncryptionKey");
    Uint8List savedUserTokenEncryptionKey = base64Url.decode(encryptionKey!);

    //! OPEN A TOKEN BOX.
    Box<UserToken> encryptedBox = await Hive.openBox<UserToken>("userTokenBox",
        encryptionCipher: HiveAesCipher(savedUserTokenEncryptionKey));

    //! CREATE A USER TOKEN OBJECT
    UserToken userTokens = tokens ??
        UserToken(
          refreshToken: '',
          accessToken: '',
        );

    //! ADD TOKEN OBJECT TO BOX
    await encryptedBox.clear();
    encryptedBox.add(userTokens);

    //! CHECK IF TOKENS HAVE BEEN SAVED.
    encryptedBox.values.contains(userTokens)
        ? {areTokensCached = true}
        : {areTokensCached = false};
        
    //! CLOSE TOKEN BOX
    await encryptedBox.close();

    return areTokensCached;
  }

  //! FETCH USERS TOKEN.

  static Future<Iterable<UserToken>> getUserTokens() async {
    try {
      //! GET SECURE STORAGE
      const FlutterSecureStorage appSecureStorage = FlutterSecureStorage();

      //! ENCRYPTION KEY EXISTS, GET, DECODE AND USE.
      String? encryptionKey =
          await appSecureStorage.read(key: "userTokenEncryptionKey");
      if (encryptionKey == null) {
        if (kDebugMode) {
          print('userTokenLog: No encryption key found.');
        }
        return [];
      }
      Uint8List savedUserTokenEncryptionKey = base64Url.decode(encryptionKey);

      //! OPEN TOKEN BOX.
      Box<UserToken> encryptedBox = await Hive.openBox<UserToken>(
        "userTokenBox",
        encryptionCipher: HiveAesCipher(savedUserTokenEncryptionKey),
      );

      //! FETCH AND CLOSE TOKEN BOX
      final tokens = encryptedBox.values;
      await encryptedBox.close();

      return tokens;
    } catch (e) {
      if (kDebugMode) {
        print('userTokenLog: Error fetching user tokens: $e');
      }
      return [];
    }
  }

//! CLEAR USER TOKEN.
  static Future<void> clearUserTokens() async {
    try {
      //! GET SECURE STORAGE
      const FlutterSecureStorage appSecureStorage = FlutterSecureStorage();

      //! ENCRYPTION KEY EXISTS, GET, DECODE AND USE.
      String? encryptionKey =
          await appSecureStorage.read(key: "userTokenEncryptionKey");
      if (encryptionKey == null) {
        if (kDebugMode) {
          print('userTokenLog: No encryption key found.');
        }
        return;
      }
      Uint8List savedUserTokenEncryptionKey = base64Url.decode(encryptionKey);

      //! OPEN TOKEN BOX.
      Box<UserToken> encryptedBox = await Hive.openBox<UserToken>(
        "userTokenBox",
        encryptionCipher: HiveAesCipher(savedUserTokenEncryptionKey),
      );

      //! CLEAR TOKEN BOX
      await encryptedBox.clear();
      await appSecureStorage.delete(key: "userTokenEncryptionKey");

      //! CLOSE TOKEN BOX
      await encryptedBox.close();

      if (kDebugMode) {
        print('userTokenLog: User tokens cleared.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('userTokenLog: Error clearing user tokens: $e');
      }
    }
  }
}
