import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  SharedPreferences? sharedPreferences;

  Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> setValue({required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else if (value is bool) {
      return await sharedPreferences!.setBool(key, value);
    } else if (value is String) {
      return await sharedPreferences!.setString(key, value);
    }
    return await sharedPreferences!.setDouble(key, value);
  }

  dynamic getValue({required String key}) {
    return sharedPreferences!.get(key);
  }
}