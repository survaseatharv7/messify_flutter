import 'package:flutter/material.dart';
import 'package:messify_owner/pages/CredentialPages/Loginscreen.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  void navigate(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Loginscreen(),
        ),
      );
    });
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
              height: 250,
              width: 300,
              child: Image.asset(
                "assets/messify.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
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
