import 'package:shared_preferences/shared_preferences.dart';

class Sessiondata {
  static bool? islogin;
  static String? usernameget;
  static String? userusername;

  static Future<void> storeSessionData(
      {required bool loginData,
      required String username,
      required userusername}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setBool("loginsession", loginData);
    sharedPreferences.setString("username", username);
    sharedPreferences.setString("userusername", userusername);
    getSessionData();
  }

  static Future<void> getSessionData() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    islogin = sharedPreference.getBool("loginsession") ?? false;
    usernameget = sharedPreference.getString("username");
    userusername = sharedPreference.getString("userusername");
  }
}
