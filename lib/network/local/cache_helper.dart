// import 'package:shared_preferences/shared_preferences.dart';
//
// class CachHelper {
//   static var sharedPreferences;
//
//
//
//   static init() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//   }
//
//   static Future<bool> pubBoolean({
//     required String key,
//     required bool value
//   }) async
//   {
//     return await sharedPreferences.setBool(key, value);
//   }
//
//
//   // static bool? getBoolean({
//   //   required String key,
//   //
//   // }) {
//   //   return sharedPreferences.getBool(key);
//   // }
//
//   static Future<bool> pubData
//       ({
//     required String key,
//     required dynamic value
//   }) async
//   {
//     if (value is String) return await sharedPreferences.setString(key, value);
//     if (value is int) return await sharedPreferences.setInt(key, value);
//     if (value is bool) return await sharedPreferences.setBool(key, value);
//
//     return await sharedPreferences.setDouble(key, value);
//   }
//
// //   static Future<String> getData({
// //     required String? key,
// // }) {
// //    return sharedPreferences.getString(key);
// //   }
//
//   static Future<bool> removeData({required String key}) async
//   {
//   return await sharedPreferences.remove(key);
//   }
//
// }