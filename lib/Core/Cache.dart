import 'package:shared_preferences/shared_preferences.dart';

class Cache {
  static late SharedPreferences sharedPreferences;
  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future setbool({required String key, required bool value}) async {
    await sharedPreferences.setBool(key, value);
  }

  static bool? getbool({required key}) {
    return sharedPreferences.getBool(key);
  }
}
