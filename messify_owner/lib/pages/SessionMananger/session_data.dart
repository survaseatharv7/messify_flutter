import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SessionData {
  static String? messName;
  static bool? isLoggedIn;

  SessionData() {
    getSessionData();
  }

  static Future<void> storeSessionData(
      {required String messName, required bool isLoggedIn}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("isLoggedIn", isLoggedIn);
    sharedPreferences.setString("messName", messName);
    log("$messName");
    getSessionData();
  }

  static Future<void> getSessionData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    isLoggedIn = sharedPreferences.getBool("isLoggedIn");
    messName = sharedPreferences.getString("messName");
    log("${SessionData.messName}");
    log("${messName}");
  }
}
