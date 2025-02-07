import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:messify_owner/main.dart';
import 'package:messify_owner/pages/CredentialPages/Loginscreen.dart';
import 'package:messify_owner/pages/HomeScreen/Maindashboard.dart';
import 'package:messify_owner/pages/SessionMananger/session_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  bool? isLoggedIn;

  void navigate(BuildContext context) async {
    loggedStatus();
    SessionData.getSessionData();
    log("MessName : ${SessionData.messName}");
    Future.delayed(const Duration(seconds: 3), () {
      if (isLoggedIn!)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Maindashboard(),
          ),
        );
      if (!isLoggedIn!)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Loginscreen()));
    });
  }

  Future<void> loggedStatus() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    SessionData.getSessionData();
    isLoggedIn = sharedPreferences.getBool("isLoggedIn") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    navigate(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MainApp.heightCal(250),
              width: MainApp.widthCal(300),
              child: Image.asset(
                "assets/messify.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Container(
              height: MainApp.heightCal(300),
              width: MainApp.widthCal(300),
              child: Image.asset("assets/logo.png"),
            ),
          ],
        ),
      ),
    );
  }
}
