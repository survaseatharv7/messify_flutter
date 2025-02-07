import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:messify/pages/MainDashboard.dart';
import 'package:messify/pages/loginScreen.dart';
import 'package:messify/pages/sessionData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Simulate a delay for splash screen
    await Future.delayed(const Duration(seconds: 2));

  
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const Maindashboard()), // Navigate to dashboard if logged in
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Loginscreen()), // Navigate to login screen if not logged in
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 250.h,
              width: 300.w,
              child: Image.asset(
                "assets/messify.png",
                fit: BoxFit.fill,
              ),
            ),
             SizedBox(height: 2.h),
            Container(
              height: 300.h,
              width: 300.w,
              child: Image.asset("assets/logo.png"),
            ),
          ],
        ),
      ),
    );
  }
}
