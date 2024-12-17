import 'package:flutter/material.dart';
import 'package:messify/pages/MainDashboard.dart';
import 'package:messify/pages/loginScreen.dart';
import 'package:messify/pages/sessionData.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    // Wait for 2 seconds (Splash screen duration)
    await Future.delayed(const Duration(seconds: 2));

    // Fetch session data
    await Sessiondata.getSessionData();

    // Navigate to appropriate screen
    if (Sessiondata.islogin == true) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Maindashboard()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Loginscreen()),
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
              height: 250,
              width: 300,
              child: Image.asset(
                "assets/messify.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              height: 300,
              width: 300,
              child: Image.asset("assets/logo.png"),
            ),
          ],
        ),
      ),
    );
  }
}
