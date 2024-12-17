import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messify_owner/pages/CredentialPages/Loginscreen.dart';
import 'package:messify_owner/pages/HomeScreen/Maindashboard.dart';
import 'package:messify_owner/pages/BoardingPages/Splashscreen.dart';
import 'package:messify_owner/pages/BoardingPages/firstonboardingscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCseZOQg7tDdizV6Pv51Z4dU2c041QXTL8",
          appId: "1:579643748294:android:01bdbc48426f9975df0cc7",
          messagingSenderId: "579643748294",
          projectId: "messify-flutter"));

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static double width = 0;
  static double heigth = 0;
  static String messName = '';

  static widthCal(double width) {
    double ans = width / MainApp.width;
    return ans * MainApp.width;
  }

  static heightCal(double height) {
    double ans = height / MainApp.heigth;
    return ans * MainApp.heigth;
  }

  static bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    heigth = MediaQuery.of(context).size.height;
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstOnboardingScreen(),
    );
  }
}
