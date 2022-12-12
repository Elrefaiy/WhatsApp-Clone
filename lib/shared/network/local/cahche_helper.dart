import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static dynamic sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required value,
  }) async {
    if (value is int) {
      return await sharedPreferences.setInt(
        key,
        value,
      );
    }
    if (value is String) {
      return await sharedPreferences.setString(
        key,
        value,
      );
    }
    if (value is bool) {
      return await sharedPreferences.setBool(
        key,
        value,
      );
    }
    return await sharedPreferences.setDouble(
      key,
      value,
    );
  }
}
