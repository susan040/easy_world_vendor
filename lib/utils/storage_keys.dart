import 'dart:convert';
import 'dart:developer';
import 'package:easy_world_vendor/models/users.dart';
import 'package:get_storage/get_storage.dart';

class StorageKeys {
  static const String USER = "user";
  static const String ACCESS_TOKEN = "accessToken";
}

class StorageHelper {
  static String? getToken() {
    try {
      final box = GetStorage();
      String? token = box.read(StorageKeys.ACCESS_TOKEN);
      log("Token from storage: $token");
      return token;
    } catch (e, s) {
      log("Error getting token: $e");
      log(s.toString());
      return null;
    }
  }

  static UsersDetails? getUser() {
    log("Fetching user");
    try {
      final box = GetStorage();
      final storedUser = box.read(StorageKeys.USER);
      log("Raw stored user: $storedUser");

      if (storedUser == null) return null;

      UsersDetails user = UsersDetails.fromJson(
        storedUser is String ? json.decode(storedUser) : storedUser,
      );

      return user;
    } catch (e, s) {
      log("Error decoding user: $e");
      log(s.toString());
      return null;
    }
  }
}
