// import 'dart:convert';
// import 'dart:developer';

// import 'package:get_storage/get_storage.dart';

// class StorageKeys {
//   static const String USER = "user";
//   static const String ACCESS_TOKEN = "accessToken";
// }

// class StorageHelper {
//   static getToken() {
//     try {
//       final box = GetStorage();
//       String token = box.read(StorageKeys.ACCESS_TOKEN);
//       return token;
//     } catch (e, s) {
//       log(e.toString());
//       log(s.toString());
//       return null;
//     }
//   }

//   static UserDetails? getUser() {
//     log("Fetching user");
//     try {
//       final box = GetStorage();
//       log("Fetching user1");
//       UserDetails user =
//           UserDetails.fromJson(json.decode(box.read(StorageKeys.USER)));
//       return user;
//     } catch (e, s) {
//       log(e.toString());
//       log(s.toString());
//       log("Failed fetch user");
//       return null;
//     }
//   }

//   // static saveCheckedInState(bool isCheckedIn) {
//   //   try {
//   //     final box = GetStorage();
//   //     box.write(StorageKeys.CHECKED_IN, isCheckedIn);
//   //   } catch (e, s) {
//   //     log(e.toString());
//   //     log(s.toString());
//   //   }
//   // }

//   // static bool getCheckedInState() {
//   //   try {
//   //     final box = GetStorage();
//   //     return box.read(StorageKeys.CHECKED_IN) ?? false;
//   //   } catch (e, s) {
//   //     log(e.toString());
//   //     log(s.toString());
//   //     return false;
//   //   }
//   // }

//   // static saveCheckInTime(String checkInTime) {
//   //   try {
//   //     final box = GetStorage();
//   //     box.write(StorageKeys.CHECK_IN_TIME, checkInTime);
//   //   } catch (e, s) {
//   //     log(e.toString());
//   //     log(s.toString());
//   //   }
//   // }

//   // static String? getCheckInTime() {
//   //   try {
//   //     final box = GetStorage();
//   //     return box.read(StorageKeys.CHECK_IN_TIME);
//   //   } catch (e, s) {
//   //     log(e.toString());
//   //     log(s.toString());
//   //     return null;
//   //   }
//   // }

//   // static saveCheckOutTime(String checkOutTime) {
//   //   try {
//   //     final box = GetStorage();
//   //     box.write(StorageKeys.CHECK_OUT_TIME, checkOutTime);
//   //   } catch (e, s) {
//   //     log(e.toString());
//   //     log(s.toString());
//   //   }
//   // }

//   // static String? getCheckOutTime() {
//   //   try {
//   //     final box = GetStorage();
//   //     return box.read(StorageKeys.CHECK_OUT_TIME);
//   //   } catch (e, s) {
//   //     log(e.toString());
//   //     log(s.toString());
//   //     return null;
//   //   }
//   // }

//   // static saveRemainingTime(int remainingTimeInSeconds) {
//   //   try {
//   //     final box = GetStorage();
//   //     box.write(StorageKeys.REMAINING_TIME, remainingTimeInSeconds);
//   //   } catch (e, s) {
//   //     log(e.toString());
//   //     log(s.toString());
//   //   }
//   // }

//   // static int getRemainingTime() {
//   //   try {
//   //     final box = GetStorage();
//   //     return box.read(StorageKeys.REMAINING_TIME) ?? 0;
//   //   } catch (e, s) {
//   //     log(e.toString());
//   //     log(s.toString());
//   //     return 0;
//   //   }
//   // }
// }
